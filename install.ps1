# Get the directory where this script is located
$ScriptDir = $PSScriptRoot

# Added -Force to overwrite existing files
Copy-Item "$ScriptDir\gitconfig" "$home\.gitconfig" -Force
Copy-Item "$ScriptDir\githelpers" "$home\.githelpers" -Force
Copy-Item "$ScriptDir\wezterm.lua" "$home\.wezterm.lua" -Force

# NVIM
$NvimConfigDir = "$env:LOCALAPPDATA\nvim"
Write-Host "Creating new config directory..."
# Added -Force to New-Item (prevents error if directory already exists)
New-Item -ItemType Directory -Path $NvimConfigDir -Force
Write-Host "Copying NeoVim configuration files..."
Copy-Item -Path "$ScriptDir\nvim\init.lua" -Destination $NvimConfigDir -Force
Copy-Item -Path "$ScriptDir\nvim\lua" -Destination $NvimConfigDir -Recurse -Force
Write-Host "NeoVim configuration files copied."

# ZED
$ZedConfigDir = "$env:APPDATA\Zed"
Write-Host "Copying Zed configuration files..."
# Ensure Zed dir exists before copying, just in case
New-Item -ItemType Directory -Path $ZedConfigDir -Force
Copy-Item -Path "$ScriptDir\zed\settings.json" -Destination $ZedConfigDir -Force
Copy-Item -Path "$ScriptDir\zed\keymap.json" -Destination $ZedConfigDir -Force
Write-Host "Zed configuration files copied."

# Set windows powershell profile
$WinPowerShellDir = "$env:HOME\Documents\WindowsPowerShell"
Write-Host "Copying Windows PowerShell configuration files in $WinPowerShellDir"
New-Item -ItemType Directory -Path $WinPowerShellDir -Force
# FIXED: Variable was $inPowerShellDirW (typo), changed to $WinPowerShellDir
Copy-Item -Path "$ScriptDir\Microsoft.PowerShell_profile.ps1" -Destination $WinPowerShellDir -Force
Write-Host "Win PowerShell configuration files copied."

# Set powershell profile
$PowerShellDir = "$env:HOME\Documents\PowerShell"
Write-Host "Copying PowerShell configuration files in $PowerShellDir"
New-Item -ItemType Directory -Path $PowerShellDir -Force
Copy-Item -Path "$ScriptDir\Microsoft.PowerShell_profile.ps1" -Destination $PowerShellDir -Force
Write-Host "PowerShell configuration files copied."
