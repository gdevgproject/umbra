$ErrorActionPreference = 'Stop'

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$designRoot = Join-Path $repoRoot 'game-design'
$errors = [System.Collections.Generic.List[string]]::new()

$canonicalFiles = Get-ChildItem -LiteralPath $designRoot -Recurse -File -Filter '*.md' |
    Where-Object { $_.FullName -notmatch '[\\/]90-archive[\\/]' }

$legacyAtRoot = Get-ChildItem -LiteralPath $designRoot -File -Filter '*.md' |
    Where-Object { $_.Name -match '^\d' }

foreach ($file in $legacyAtRoot) {
    $errors.Add("Legacy-style numbered file at canonical root: $($file.FullName)")
}

$allowedStatuses = @(
    'SEED', 'DISCOVERY', 'PROPOSED', 'VALIDATION', 'APPROVED',
    'IMPLEMENTATION_READY', 'IMPLEMENTING', 'IMPLEMENTED', 'VERIFIED',
    'RELEASED', 'RETIRED', 'COMPLETE', 'IN_PROGRESS', 'ACTIVE', 'PLANNED',
    'APPROVED_FOR_DOCUMENTATION'
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

if ($errors.Count -gt 0) {
    Write-Host 'Design documentation validation failed:' -ForegroundColor Red
    $errors | ForEach-Object { Write-Host " - $_" }
    exit 1
}

Write-Host "Design documentation validation passed ($($canonicalFiles.Count) canonical Markdown files)." -ForegroundColor Green
