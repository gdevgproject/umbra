$ErrorActionPreference = 'Stop'

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$designRoot = Join-Path $repoRoot 'game-design'
$errors = [System.Collections.Generic.List[string]]::new()

$canonicalFiles = Get-ChildItem -LiteralPath $designRoot -Recurse -File -Filter '*.md'

$parallelLegacyRoot = Join-Path $designRoot '90-archive'
if (Test-Path -LiteralPath $parallelLegacyRoot) {
    $errors.Add("Parallel legacy documentation is forbidden: $parallelLegacyRoot")
}

$legacyAtRoot = Get-ChildItem -LiteralPath $designRoot -File -Filter '*.md' |
    Where-Object { $_.Name -match '^\d' }

foreach ($file in $legacyAtRoot) {
    $errors.Add("Legacy-style numbered file at canonical root: $($file.FullName)")
}

$allowedStatuses = @(
    'SEED', 'DISCOVERY', 'PROPOSED', 'VALIDATION', 'APPROVED',
    'IMPLEMENTATION_READY', 'IMPLEMENTING', 'IMPLEMENTED', 'VERIFIED',
    'RELEASED', 'RETIRED', 'COMPLETE', 'IN_PROGRESS', 'ACTIVE', 'PLANNED',
    'APPROVED_FOR_DOCUMENTATION', 'CANDIDATE', 'EVIDENCE_SEED', 'DEFERRED',
    'BLOCKED_BY_DESIGN', 'OBSERVED', 'SYNTHESIZED', 'STALE'
)

foreach ($file in $canonicalFiles) {
    $raw = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    $relativeName = $file.FullName.Replace($repoRoot + '\', '')

    $versionAddendumPattern = '(?im)^#{1,6}\s+.*B' + [char]0x1ED5 + ' sung\s+v\d'
    if ($raw -match $versionAddendumPattern) {
        $errors.Add("Version-addendum heading is forbidden: $relativeName")
    }

    $badReplacement = $raw.IndexOf([char]0xFFFD) -ge 0
    $badDash = $raw.Contains(([string][char]0x00E2 + [char]0x20AC + [char]0x201D))
    $badArrow = $raw.Contains(([string][char]0x00E2 + [char]0x2020))
    if ($badReplacement -or $badDash -or $badArrow) {
        $errors.Add("Possible UTF-8 mojibake: $relativeName")
    }

    foreach ($match in [regex]::Matches($raw, '(?<!!)\[[^\]]+\]\((?<target>[^)#]+)(?:#[^)]+)?\)')) {
        $target = $match.Groups['target'].Value.Trim('<', '>')
        if ($target -and $target -notmatch '^(https?://|mailto:)') {
            $resolved = Join-Path $file.DirectoryName $target
            if (-not (Test-Path -LiteralPath $resolved)) {
                $errors.Add("Broken relative link in ${relativeName}: $target")
            }
        }
    }

    if ($file.FullName -notmatch '[\\/]80-templates[\\/]') {
        $statusMatch = [regex]::Match($raw, '(?m)^> \*\*(?:Status|Trạng thái[^*]*):\*\* `([^`]+)`')
        if ($statusMatch.Success -and $allowedStatuses -notcontains $statusMatch.Groups[1].Value) {
            $errors.Add("Unknown lifecycle status in ${relativeName}: $($statusMatch.Groups[1].Value)")
        }
    }

    if ($file.Name -eq 'README.md' -and $raw -match '(?m)^# FEAT-') {
        foreach ($required in @('> **DRI:**', '> **Status:**', '## 1. Contract')) {
            if (-not $raw.Contains($required)) {
                $errors.Add("Feature Cell missing '$required': $relativeName")
            }
        }
    }
}

# Domain ownership must agree between the global map and canonical charters.
$systemMapPath = Join-Path $designRoot '10-direction\03-system-map.md'
$systemMapRaw = Get-Content -LiteralPath $systemMapPath -Raw -Encoding UTF8
$mappedDomainIds = @(
    [regex]::Matches($systemMapRaw, '(?m)^\|\s*`(?<id>DOM-[A-Z0-9-]+)`\s*\|') |
        ForEach-Object { $_.Groups['id'].Value } |
        Select-Object -Unique
)
$domainCharterIds = [System.Collections.Generic.List[string]]::new()
$domainRoot = Join-Path $designRoot '20-domains'
$domainFiles = @(Get-ChildItem -LiteralPath $domainRoot -Recurse -File -Filter '*.md')
foreach ($domainFile in $domainFiles) {
    $domainRaw = Get-Content -LiteralPath $domainFile.FullName -Raw -Encoding UTF8
    $domainMatch = [regex]::Match($domainRaw, '(?m)^#\s+(?<id>DOM-[A-Z0-9-]+)\s+[\u2014-]')
    if ($domainMatch.Success) {
        $domainCharterIds.Add($domainMatch.Groups['id'].Value)
    }
}

foreach ($duplicate in $domainCharterIds | Group-Object | Where-Object Count -gt 1) {
    $errors.Add("Duplicate Domain Charter ID: $($duplicate.Name)")
}

foreach ($id in $mappedDomainIds) {
    if ($domainCharterIds -notcontains $id) {
        $errors.Add("System Map domain has no canonical charter: $id")
    }
}

foreach ($id in $domainCharterIds) {
    if ($mappedDomainIds -notcontains $id) {
        $errors.Add("Canonical Domain Charter missing from System Map: $id")
    }
}

# Design backlog dependencies are a machine-checkable DAG, not prose shorthand.
$designBacklogPath = Join-Path $designRoot '50-production\02-design-backlog.md'
$designBacklogRaw = Get-Content -LiteralPath $designBacklogPath -Raw -Encoding UTF8
$definedDbIds = @(
    [regex]::Matches($designBacklogRaw, '(?m)^\|\s*(?:\d+\s*\|\s*)?`(?<id>DB-\d{3})`\s*\|') |
        ForEach-Object { $_.Groups['id'].Value }
)

foreach ($duplicate in $definedDbIds | Group-Object | Where-Object Count -gt 1) {
    $errors.Add("Duplicate design-backlog definition: $($duplicate.Name)")
}

$activeDbRows = @{}
$priorityToId = @{}
foreach ($line in Get-Content -LiteralPath $designBacklogPath -Encoding UTF8) {
    if ($line -notmatch '^\|\s*(?<priority>\d+)\s*\|\s*`(?<id>DB-\d{3})`\s*\|') {
        continue
    }

    $cells = $line -split '\|'
    $priority = [int]$Matches['priority']
    $id = $Matches['id']
    $dependencyCell = $cells[5].Trim()

    if ($priorityToId.ContainsKey($priority)) {
        $errors.Add("Duplicate design-backlog priority ${priority}: $id and $($priorityToId[$priority])")
    } else {
        $priorityToId[$priority] = $id
    }

    if ($dependencyCell -match 'DB-\d{3}(?:[/\u2013-]\d{3})+') {
        $errors.Add("Design-backlog dependency shorthand/range is forbidden for ${id}: $dependencyCell")
    }

    $dependencies = @(
        [regex]::Matches($dependencyCell, 'DB-\d{3}') |
            ForEach-Object Value |
            Select-Object -Unique
    )
    foreach ($dependency in $dependencies) {
        if ($definedDbIds -notcontains $dependency) {
            $errors.Add("Unknown design-backlog dependency for ${id}: $dependency")
        }
        if ($dependency -eq $id) {
            $errors.Add("Design-backlog item depends on itself: $id")
        }
    }

    $activeDbRows[$id] = [pscustomobject]@{
        Priority = $priority
        Dependencies = $dependencies
    }
}

$sortedPriorities = @($priorityToId.Keys | Sort-Object)
for ($index = 0; $index -lt $sortedPriorities.Count; $index++) {
    $expected = $index + 1
    if ($sortedPriorities[$index] -ne $expected) {
        $errors.Add("Design-backlog priorities must be contiguous from 1; expected $expected, found $($sortedPriorities[$index])")
        break
    }
}

foreach ($id in $activeDbRows.Keys) {
    foreach ($dependency in $activeDbRows[$id].Dependencies) {
        if ($activeDbRows.ContainsKey($dependency) -and
            $activeDbRows[$dependency].Priority -gt $activeDbRows[$id].Priority) {
            $errors.Add("Design-backlog priority inversion: $id depends on later $dependency")
        }
    }
}

$remainingDependencies = @{}
$dependents = @{}
foreach ($id in $activeDbRows.Keys) {
    $activeDependencies = @($activeDbRows[$id].Dependencies | Where-Object { $activeDbRows.ContainsKey($_) })
    $remainingDependencies[$id] = $activeDependencies.Count
    foreach ($dependency in $activeDependencies) {
        if (-not $dependents.ContainsKey($dependency)) {
            $dependents[$dependency] = [System.Collections.Generic.List[string]]::new()
        }
        $dependents[$dependency].Add($id)
    }
}
$ready = [System.Collections.Generic.Queue[string]]::new()
foreach ($id in $activeDbRows.Keys) {
    if ($remainingDependencies[$id] -eq 0) { $ready.Enqueue($id) }
}
$visitedCount = 0
while ($ready.Count -gt 0) {
    $id = $ready.Dequeue()
    $visitedCount++
    if (-not $dependents.ContainsKey($id)) { continue }
    foreach ($dependent in $dependents[$id]) {
        $remainingDependencies[$dependent]--
        if ($remainingDependencies[$dependent] -eq 0) { $ready.Enqueue($dependent) }
    }
}
if ($visitedCount -ne $activeDbRows.Count) {
    $errors.Add('Design-backlog dependency graph contains a cycle.')
}

# Candidate implementation epics need stable IDs and exact design/epic edges.
$implementationBacklogPath = Join-Path $designRoot '50-production\03-implementation-backlog.md'
$implementationLines = Get-Content -LiteralPath $implementationBacklogPath -Encoding UTF8
$epicRows = @{}
foreach ($line in $implementationLines) {
    if ($line -notmatch '^\|\s*`(?<id>EPIC-[A-Z0-9-]+)`\s*\|') { continue }
    $id = $Matches['id']
    $cells = $line -split '\|'
    if ($epicRows.ContainsKey($id)) {
        $errors.Add("Duplicate implementation epic: $id")
        continue
    }
    if ($line -match 'DB-\d{3}(?:[/\u2013-]\d{3})+') {
        $errors.Add("Implementation epic uses design dependency shorthand/range: $id")
    }
    foreach ($dbId in [regex]::Matches($cells[3], 'DB-\d{3}') | ForEach-Object Value | Select-Object -Unique) {
        if ($definedDbIds -notcontains $dbId) {
            $errors.Add("Implementation epic references unknown design item for ${id}: $dbId")
        }
    }
    $epicDependencies = @(
        [regex]::Matches($cells[4], 'EPIC-[A-Z0-9-]+') |
            ForEach-Object Value |
            Select-Object -Unique
    )
    if ($epicDependencies -contains $id) {
        $errors.Add("Implementation epic depends on itself: $id")
    }
    $epicRows[$id] = $epicDependencies
}

foreach ($id in $epicRows.Keys) {
    foreach ($dependency in $epicRows[$id]) {
        if (-not $epicRows.ContainsKey($dependency)) {
            $errors.Add("Implementation epic references unknown epic for ${id}: $dependency")
        }
    }
}

$remainingEpicDependencies = @{}
$epicDependents = @{}
foreach ($id in $epicRows.Keys) {
    $knownDependencies = @($epicRows[$id] | Where-Object { $epicRows.ContainsKey($_) })
    $remainingEpicDependencies[$id] = $knownDependencies.Count
    foreach ($dependency in $knownDependencies) {
        if (-not $epicDependents.ContainsKey($dependency)) {
            $epicDependents[$dependency] = [System.Collections.Generic.List[string]]::new()
        }
        $epicDependents[$dependency].Add($id)
    }
}
$readyEpics = [System.Collections.Generic.Queue[string]]::new()
foreach ($id in $epicRows.Keys) {
    if ($remainingEpicDependencies[$id] -eq 0) { $readyEpics.Enqueue($id) }
}
$visitedEpicCount = 0
while ($readyEpics.Count -gt 0) {
    $id = $readyEpics.Dequeue()
    $visitedEpicCount++
    if (-not $epicDependents.ContainsKey($id)) { continue }
    foreach ($dependent in $epicDependents[$id]) {
        $remainingEpicDependencies[$dependent]--
        if ($remainingEpicDependencies[$dependent] -eq 0) { $readyEpics.Enqueue($dependent) }
    }
}
if ($visitedEpicCount -ne $epicRows.Count) {
    $errors.Add('Implementation-epic dependency graph contains a cycle.')
}

if ($errors.Count -gt 0) {
    Write-Host 'Design documentation validation failed:' -ForegroundColor Red
    $errors | ForEach-Object { Write-Host " - $_" }
    exit 1
}

Write-Host "Design documentation validation passed ($($canonicalFiles.Count) canonical Markdown files)." -ForegroundColor Green
