:: ================================================================
:: UltraMPV Portable Updater Script v2.0.0 - BEST Real Human 4K/60
:: Author: Trevor Morin | Superklok Labs ➔ superklok.com
:: ================================================================

@echo OFF
:: This batch file exists to run ultrampv-updater.ps1 without hassle
pushd %~dp0

:: Lock explicitly to the custom UltraMPV Portable Updater Pipeline
set updater_script="%~dp0\ultrampv-updater.ps1"

:: Check if pwsh is in the system's PATH
where pwsh >nul 2>nul
if %errorlevel% equ 0 (
    :: pwsh is in PATH, so run the script using Windows Powershell
    pwsh -NoProfile -NoLogo -ExecutionPolicy Bypass -File %updater_script%
) else (
    :: pwsh is not in PATH, run the script using PowerShell Core
    powershell -NoProfile -NoLogo -ExecutionPolicy Bypass -File %updater_script%
)

:: ==============================================================
:: UltraMPV Additions: Update internal dependencies seamlessly
:: ==============================================================
if exist "%~dp0\yt-dlp.exe" (
    echo [UltraMPV] Checking for yt-dlp web extractor updates...
    "%~dp0\yt-dlp.exe" -U
)

timeout 5