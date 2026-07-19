[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

function Find-CommandPath {
    param([string[]]$Names)

    foreach ($name in $Names) {
        $command = Get-Command $name -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($command -and $command.Source) {
            return $command.Source
        }
    }
    return $null
}

function Find-RegisteredAppPath {
    param([string]$DisplayNamePattern)

    $uninstallRoots = @(
        'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
        'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
        'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
    )
    $entry = Get-ItemProperty $uninstallRoots -ErrorAction SilentlyContinue |
        Where-Object { $_.DisplayName -match $DisplayNamePattern } |
        Sort-Object DisplayVersion -Descending |
        Select-Object -First 1

    if (-not $entry) {
        return $null
    }

    $path = $null
    if ($entry.DisplayIcon) {
        $path = ($entry.DisplayIcon -replace ',\d+$', '').Trim('"')
    }
    if ((-not $path -or -not (Test-Path -LiteralPath $path)) -and $entry.InstallLocation) {
        $path = $entry.InstallLocation
    }

    return [PSCustomObject]@{
        Path = $path
        Version = $entry.DisplayVersion
        InstallLocation = $entry.InstallLocation
    }
}

function Get-FileVersion {
    param([string]$Path)

    if (-not $Path -or -not (Test-Path -LiteralPath $Path)) {
        return $null
    }
    $item = Get-Item -LiteralPath $Path
    if ($item.PSIsContainer) {
        return $null
    }
    return $item.VersionInfo.ProductVersion
}

$codexPython = Join-Path $env:USERPROFILE '.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe'
$pythonPath = Find-CommandPath @('python.exe', 'python3.exe', 'py.exe')
$pythonSource = 'system/PATH'
if (-not $pythonPath -and (Test-Path -LiteralPath $codexPython)) {
    $pythonPath = $codexPython
    $pythonSource = 'Codex bundled runtime'
}

$blockbench = Find-RegisteredAppPath '^Blockbench'
$blender = Find-RegisteredAppPath '^Blender'
$audacity = Find-RegisteredAppPath '^Audacity'
$imagemagick = Find-RegisteredAppPath '^ImageMagick'
$intellij = Find-RegisteredAppPath '^IntelliJ IDEA'
$krita = Find-RegisteredAppPath '^Krita'
$inkscape = Find-RegisteredAppPath '^Inkscape'
$obs = Find-RegisteredAppPath '^OBS Studio'
$localCliRoot = Join-Path $env:LOCALAPPDATA 'Programs\UMBRA-CLI'

$blenderPath = Find-CommandPath @('blender.exe')
if (-not $blenderPath -and $blender -and $blender.InstallLocation) {
    $candidate = Join-Path $blender.InstallLocation 'blender.exe'
    if (Test-Path -LiteralPath $candidate) { $blenderPath = $candidate }
}
$imagemagickPath = Find-CommandPath @('magick.exe')
if (-not $imagemagickPath -and $imagemagick -and $imagemagick.InstallLocation) {
    $candidate = Join-Path $imagemagick.InstallLocation 'magick.exe'
    if (Test-Path -LiteralPath $candidate) { $imagemagickPath = $candidate }
}
$kritaPath = Find-CommandPath @('krita.exe')
if (-not $kritaPath -and $krita -and $krita.InstallLocation) {
    $candidate = Join-Path $krita.InstallLocation 'bin\krita.exe'
    if (Test-Path -LiteralPath $candidate) { $kritaPath = $candidate }
}
$ffmpegPath = Find-CommandPath @('ffmpeg.exe')
if (-not $ffmpegPath) {
    $candidate = Join-Path $localCliRoot 'ffmpeg\bin\ffmpeg.exe'
    if (Test-Path -LiteralPath $candidate) { $ffmpegPath = $candidate }
}
$uvPath = Find-CommandPath @('uv.exe')
if (-not $uvPath) {
    $candidate = Join-Path $localCliRoot 'uv\uv.exe'
    if (Test-Path -LiteralPath $candidate) { $uvPath = $candidate }
}
$inkscapeCliPath = Find-CommandPath @('inkscape.com')
if (-not $inkscapeCliPath -and $inkscape -and $inkscape.Path) {
    $candidate = [System.IO.Path]::ChangeExtension($inkscape.Path, '.com')
    if (Test-Path -LiteralPath $candidate) { $inkscapeCliPath = $candidate }
}
$minecraftPluginPath = Get-ChildItem (Join-Path $env:APPDATA 'JetBrains\IntelliJIdea*\plugins\Minecraft Development') -Directory -ErrorAction SilentlyContinue |
    Sort-Object FullName -Descending |
    Select-Object -First 1

$rows = @(
    [PSCustomObject]@{ Tool = 'Git'; Tier = 'CLI_HEADLESS'; Path = Find-CommandPath @('git.exe'); Version = $null; Note = 'Required' },
    [PSCustomObject]@{ Tool = 'Java'; Tier = 'CLI_HEADLESS'; Path = Find-CommandPath @('java.exe'); Version = $null; Note = 'Conditional until DB-019 pins JDK' },
    [PSCustomObject]@{ Tool = 'Javac'; Tier = 'CLI_HEADLESS'; Path = Find-CommandPath @('javac.exe'); Version = $null; Note = 'Conditional until DB-019 pins JDK' },
    [PSCustomObject]@{ Tool = 'Node'; Tier = 'CLI_HEADLESS'; Path = Find-CommandPath @('node.exe'); Version = $null; Note = 'Optional helper' },
    [PSCustomObject]@{ Tool = 'npm'; Tier = 'CLI_HEADLESS'; Path = Find-CommandPath @('npm.cmd', 'npm.exe'); Version = $null; Note = 'Use npm.cmd if npm.ps1 is blocked' },
    [PSCustomObject]@{ Tool = 'Python'; Tier = 'CLI_HEADLESS'; Path = $pythonPath; Version = $null; Note = $pythonSource },
    [PSCustomObject]@{ Tool = 'Blockbench'; Tier = 'GUI_AUTHORING'; Path = if ($blockbench) { $blockbench.Path } else { $null }; Version = if ($blockbench) { $blockbench.Version } else { $null }; Note = 'Required for first asset exemplar' },
    [PSCustomObject]@{ Tool = 'Blender'; Tier = 'SCRIPTABLE_APP'; Path = $blenderPath; Version = if ($blender) { $blender.Version } else { $null }; Note = 'Standard workstation' },
    [PSCustomObject]@{ Tool = 'FFmpeg'; Tier = 'CLI_HEADLESS'; Path = $ffmpegPath; Version = $null; Note = 'Standard workstation' },
    [PSCustomObject]@{ Tool = 'Audacity'; Tier = 'GUI_AUTHORING'; Path = if ($audacity) { $audacity.Path } else { Find-CommandPath @('audacity.exe') }; Version = if ($audacity) { $audacity.Version } else { $null }; Note = 'Standard workstation' },
    [PSCustomObject]@{ Tool = 'ImageMagick'; Tier = 'CLI_HEADLESS'; Path = $imagemagickPath; Version = if ($imagemagick) { $imagemagick.Version } else { $null }; Note = 'Standard workstation' },
    [PSCustomObject]@{ Tool = 'IntelliJ IDEA'; Tier = 'GUI_AUTHORING'; Path = if ($intellij) { $intellij.Path } else { Find-CommandPath @('idea64.exe', 'idea.exe') }; Version = if ($intellij) { $intellij.Version } else { $null }; Note = '2025.3+; install Minecraft Development plugin' },
    [PSCustomObject]@{ Tool = 'Git LFS'; Tier = 'CLI_HEADLESS'; Path = Find-CommandPath @('git-lfs.exe'); Version = $null; Note = 'Install globally; repo tracking remains policy-controlled' },
    [PSCustomObject]@{ Tool = 'uv'; Tier = 'CLI_HEADLESS'; Path = $uvPath; Version = $null; Note = 'Python runtime/environment manager' },
    [PSCustomObject]@{ Tool = 'Krita'; Tier = 'GUI_AUTHORING'; Path = $kritaPath; Version = if ($krita) { $krita.Version } else { $null }; Note = 'Raster/texture source authoring' },
    [PSCustomObject]@{ Tool = 'Inkscape CLI'; Tier = 'SCRIPTABLE_APP'; Path = $inkscapeCliPath; Version = if ($inkscape) { $inkscape.Version } else { $null }; Note = 'Use inkscape.com, not inkscape.exe, for CLI/export' },
    [PSCustomObject]@{ Tool = 'Minecraft Dev'; Tier = 'IDE_PLUGIN'; Path = if ($minecraftPluginPath) { $minecraftPluginPath.FullName } else { $null }; Version = $null; Note = 'IntelliJ plugin; useful for debug/run configuration, not required for Codex edits' },
    [PSCustomObject]@{ Tool = 'OBS Studio'; Tier = 'GUI_AUTHORING'; Path = if ($obs) { $obs.Path } else { Find-CommandPath @('obs64.exe') }; Version = if ($obs) { $obs.Version } else { $null }; Note = 'Controlled capture and playtest evidence' }
)

foreach ($row in $rows) {
    if (-not $row.Version) {
        $row.Version = Get-FileVersion $row.Path
    }
    $row | Add-Member -NotePropertyName Detected -NotePropertyValue ([bool]($row.Path -and (Test-Path -LiteralPath $row.Path)))
}

Write-Output 'UMBRA workstation inventory (discovery only; run smoke fixtures before a readiness gate)'
$rows | Select-Object Tool, Detected, Tier, Version, Path, Note | Format-Table -AutoSize -Wrap
