cp gitconfig $home/.gitconfig
cp githelpers $home/.githelpers
cp wezterm.lua $home/.wezterm.lua
cp nvim_config.lua $env:LOCALAPPDATA/nvim

mkdir -p $home/Documents/WindowsPowershell -ErrorAction SilentlyContinue
cp Microsoft.PowerShell_profile.ps1 $home/Documents/WindowsPowershell

mkdir -p $home/Documents/Powershell -ErrorAction SilentlyContinue
cp Microsoft.PowerShell_profile.ps1 $home/Documents/Powershell

