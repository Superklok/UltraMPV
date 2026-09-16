# ==================================================================
# UltraMPV Portable Updater Pipeline v2.0.0 - BEST Real Human 4K/60
# Author: Trevor Morin | Superklok Labs ➔ superklok.com
# ==================================================================

$RootDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $RootDir

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "             UltraMPV Automated Core Updater              " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

# Update yt-dlp if it exists
if (Test-Path "yt-dlp.exe") {
    Write-Host "[UltraMPV] Checking for yt-dlp web extractor updates..." -ForegroundColor Green
    Start-Process -FilePath ".\yt-dlp.exe" -ArgumentList "-U" -NoNewWindow -Wait
}

$fallback7z = Join-Path (Get-Location) "\7z\7zr.exe"
$useragent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"

function Get-7z {
    $7z_command = Get-Command -CommandType Application -ErrorAction Ignore 7z.exe | Select-Object -Last 1
    if ($7z_command) { return $7z_command.Source }
    $7zdir = Get-ItemPropertyValue -ErrorAction Ignore "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\7-Zip" "InstallLocation"
    if ($7zdir -and (Test-Path (Join-Path $7zdir "7z.exe"))) { return Join-Path $7zdir "7z.exe" }
    if (Test-Path $fallback7z) { return $fallback7z }
    return $null
}

function Check-7z {
    if (-not (Get-7z)) {
        $null = New-Item -ItemType Directory -Force (Split-Path $fallback7z)
        $download_file = $fallback7z
        Write-Host "Downloading 7zr.exe" -ForegroundColor Green
        Invoke-WebRequest -Uri "https://www.7-zip.org/a/7zr.exe" -UserAgent $useragent -OutFile $download_file
    } else {
        Write-Host "7z already exists. Skipped download" -ForegroundColor Green
    }
}

function Check-PowershellVersion {
    $version = $PSVersionTable.PSVersion.Major
    Write-Host "Checking Windows PowerShell version -- $version" -ForegroundColor Green
    if ($version -le 2) {
        Write-Host "Using Windows PowerShell $version is unsupported. Upgrade your Windows PowerShell." -ForegroundColor Red
        throw
    }
}

function Check-Mpv {
    return Test-Path ((Get-Location).Path + "\mpv.exe")
}

function Download-Archive ($filename, $link) {
    if ([string]::IsNullOrEmpty($filename) -or [string]::IsNullOrEmpty($link)) {
        throw "Download-Archive Error: Filename or Link parameter resolved to null."
    }
    Write-Host "Downloading $filename" -ForegroundColor Green
    Invoke-WebRequest -Uri $link -UserAgent $useragent -OutFile $filename
}

function Extract-Archive ($file) {
    $7z = Get-7z
    Write-Host "Extracting $file while protecting updater configurations..." -ForegroundColor Green
    
    # -x! explicitly prevents 7-Zip from extracting and overwriting specified target filenames
    & $7z x -y $file "-x!*updater.bat" "-x!*updater.ps1"
}

function Get-Latest-Mpv($Arch, $channel) {
    $api_gh = "https://api.github.com/repos/shinchiro/mpv-winbuild-cmake/releases/latest"
    Write-Host "Fetching latest build metadata from GitHub Mirror..." -ForegroundColor Green
    
    $headers = @{"User-Agent" = "UltraMPV-Updater"}
    $json = Invoke-RestMethod -Uri $api_gh -Headers $headers -ErrorAction Stop
    
    # Precise asset targeting: grabs the standard player 7z and avoids debug files or clang developer test packages
    $asset = $json.assets | where { 
        $_.name -like "mpv-$Arch-*.7z" -and 
        $_.name -notlike "*debug*" -and 
        $_.name -notlike "*clang*"
    } | Select-Object -First 1
    
    if (-not $asset) {
        throw "Could not find a valid matching mpv binary package for architecture: $Arch"
    }
    
    return $asset.name, $asset.browser_download_url
}

function Get-Latest-Ytplugin {
    $api_url = "https://github.com/yt-dlp/yt-dlp/releases.atom"
    Write-Host "Fetching latest production build tag for yt-dlp..." -ForegroundColor Green
    
    $headers = @{"User-Agent" = "UltraMPV-Updater"}
    $json = Invoke-RestMethod -Uri $api_url -Headers $headers -ErrorAction Stop
    
    return $json.tag_name
}


function Get-Latest-FFmpeg ($Arch) {
    $api_gh = "https://api.github.com/repos/shinchiro/mpv-winbuild-cmake/releases/latest"
    $headers = @{"User-Agent" = "UltraMPV-Updater"}
    $json = Invoke-RestMethod -Uri $api_gh -Headers $headers -ErrorAction Stop
    
    # Precise utility targeting: tracks the standalone matching FFmpeg decoder 7z
    $asset = $json.assets | where { 
        $_.name -like "ffmpeg-$Arch-*.7z" -and 
        $_.name -notlike "*debug*" -and
        $_.name -notlike "*clang*"
    } | Select-Object -First 1
    
    if (-not $asset) {
        throw "Could not find a valid matching FFmpeg utility package for architecture: $Arch"
    }
    
    return $asset.name, $asset.browser_download_url
}

function ExtractGitFromFile {
    if (-not (Test-Path ./mpv.exe)) { return "none" }
    $stripped = .\mpv --no-config | select-string "mpv" | select-object -First 1
    $pattern = "-g([a-z0-9-]{7})"
    if ($stripped -match $pattern) { return $matches[1] }
    return "unknown"
}

function ExtractGitFromURL($filename) {
    $pattern = "-git-([a-z0-9-]{7})"
    if ($filename -match $pattern) { return $matches[1] }
    return "unknown"
}

function ExtractDateFromFile {
    if (Test-Path ./mpv.exe) {
        $date = (Get-Item ./mpv.exe).LastWriteTimeUtc
        return "$($date.Year.ToString('0000'))$($date.Month.ToString('00'))$($date.Day.ToString('00'))"
    }
    return "00000000"
}

function ExtractDateFromURL($filename) {
    $pattern = "-([0-9]{8})-git-"
    if ($filename -match $pattern) { return $matches[1] }
    return "00000000"
}

function Test-Admin {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent()
    return (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function Check-Autodelete($archive) {
    if (Test-Path $archive) { Remove-Item -Force $archive }
}

function Upgrade-Mpv {
    $need_download = $false
    $remoteName = ""
    $download_link = ""
    
    $channel = "daily" 
    $arch = "x86_64-v3"
    
    $remoteName, $download_link = Get-Latest-Mpv $arch $channel
    
    if (Check-Mpv) {
        $localgit = ExtractGitFromFile
        $localdate = ExtractDateFromFile
        $remotegit = ExtractGitFromURL $remoteName
        $remotedate = ExtractDateFromURL $remoteName
        
        if (($localgit -eq $remotegit) -and ($localdate -eq $remotedate)) {
            Write-Host "You are already using the latest mpv build -- $remoteName" -ForegroundColor Green
            $need_download = $false
        } else {
            Write-Host "Newer mpv build available ($remoteName)" -ForegroundColor Green
            $need_download = $true
        }
    } else {
        Write-Host "mpv doesn't exist. Setting up core binaries..." -ForegroundColor Green
        $need_download = $true
    }
    
    if ($need_download) {
        Download-Archive $remoteName $download_link
        Check-7z
        Extract-Archive $remoteName
    }
    Check-Autodelete $remoteName
}

function Upgrade-Ytplugin {
    if (Test-Path "yt-dlp.exe") {
        $latest_release = Get-Latest-Ytplugin
        if ((& .\yt-dlp.exe --version) -match ($latest_release)) {
            Write-Host "You are already using latest yt-dlp -- $latest_release" -ForegroundColor Green
        } else {
            Write-Host "Newer yt-dlp build available. Updating..." -ForegroundColor Green
            & .\yt-dlp.exe --update
        }
    } else {
        Write-Host "yt-dlp doesn't exist. Downloading production web scraper hook..." -ForegroundColor Green
        $latest_release = Get-Latest-Ytplugin
        
        # Ensures a clean download of the actual compiled binary executable instead of the RSS feed text
        $link = "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe"
        Download-Archive "yt-dlp.exe" $link
    }
}

function Upgrade-FFmpeg {
    $arch = "x86_64-v3"
    $need_download = $false
    $remote_name, $download_link = Get-Latest-FFmpeg $arch
    
    if (-not (Test-Path "ffmpeg.exe")) {
        $need_download = $true
    } else {
        $ffmpeg_file = .\ffmpeg -version | select-string "ffmpeg" | select-object -First 1
        $file_pattern_1 = "git-[0-9]{4}-[0-9]{2}-[0-9]{2}-(?<commit>[a-z0-9]+)"
        $file_pattern_2 = "N-\d+-g(?<commit>[a-z0-9]+)"
        $file_pattern = $file_pattern_1, $file_pattern_2 -join '|'
        $url_pattern = "git-([a-z0-9]+)"
        
        $file_match = [Regex]::Matches($ffmpeg_file, $file_pattern)
        $remote_match = [Regex]::Matches($remote_name, $url_pattern)
        
        $local_git = if ($file_match.Count -gt 0) { $file_match.groups['commit'].value } else { "unknown" }
        $remote_git = if ($remote_match.Count -gt 0) { $remote_match.groups.value } else { "unknown" }
        
        if (($local_git -ne "unknown") -and ($local_git -eq $remote_git)) {
            Write-Host "You are already using latest ffmpeg build -- $remote_name" -ForegroundColor Green
            $need_download = $false
        } else {
            Write-Host "Newer ffmpeg build available" -ForegroundColor Green
            $need_download = $true
        }
    }
    
    if ($need_download) {
        Download-Archive $remote_name $download_link
        Check-7z
        Extract-Archive $remote_name
    }
    Check-Autodelete $remote_name
}

if (Test-Admin) {
    Write-Host "Running script with administrator privileges" -ForegroundColor Yellow
} else {
    Write-Host "Running script without administrator privileges" -ForegroundColor Red
}

try {
    Check-PowershellVersion
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $global:progressPreference = 'silentlyContinue'
    
    Upgrade-Mpv
    Upgrade-Ytplugin
    Upgrade-FFmpeg
    
    # =========================================================================
    # UltraMPV Folder Maintenance Hook
    # Ensures local directory architecture exists natively
    # =========================================================================
    $ClipsDir = Join-Path $RootDir "portable_config\clips"
    if (-not (Test-Path $ClipsDir)) {
        Write-Host "[UltraMPV] Organizing folder hierarchy: Creating portable_config\clips..." -ForegroundColor Yellow
        New-Item -ItemType Directory -Force -Path $ClipsDir | Out-Null
    }
    
    $ScreenshotsDir = Join-Path $RootDir "portable_config\screenshots"
    if (-not (Test-Path $ScreenshotsDir)) {
        Write-Host "[UltraMPV] Organizing folder hierarchy: Creating portable_config\screenshots..." -ForegroundColor Yellow
        New-Item -ItemType Directory -Force -Path $ScreenshotsDir | Out-Null
    }
    # =========================================================================
    Write-Host "Operation completed" -ForegroundColor Magenta
}

catch [System.Exception] {
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}
Write-Host ""
Write-Host "🏁 Core updater checks complete!" -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan