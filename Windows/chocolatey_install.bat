@echo off

:: Pick one of these two files (cmd or ps1)

:: Set directory for installation - Chocolatey does not lock 
:: down the directory if not the default
SET ChocolateyInstall=d:\chocolatey
SET ChocolateyBinRoot=d:\choco_apps
SET ChocolateyToolsLocation=d:\choco_apps

mkdir %ChocolateyInstall% 2>nul 2>&1
mkdir %ChocolateyBinRoot% 2>nul 2>&1

setx ChocolateyInstall %ChocolateyInstall%
setx ChocolateyBinRoot %ChocolateyBinRoot%
setx ChocolateyToolsLocation %ChocolateyToolsLocation%

:: All install options - offline, proxy, etc at
:: https://chocolatey.org/install
@powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH="%PATH%;%ChocolateyInstall%\bin"

pause
