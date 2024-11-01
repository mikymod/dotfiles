cp .gitconfig $home
cp .wezterm.lua $home

mkdir -p $home/Documents/WindowsPowershell -ErrorAction SilentlyContinue
cp Microsoft.PowerShell_profile.ps1 $home/Documents/WindowsPowershell

mkdir -p $home/Documents/Powershell -ErrorAction SilentlyContinue
cp Microsoft.PowerShell_profile.ps1 $home/Documents/Powershell