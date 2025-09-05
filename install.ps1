cp gitconfig $home/.gitconfig
cp githelpers $home/.githelpers
cp wezterm.lua $home/.wezterm.lua

if (Test-Path -Path $env:LOCALAPPDATA/nvim/lua/config) {
  rm -r $env:LOCALAPPDATA/nvim/lua/config
}
mkdir $env:LOCALAPPDATA/nvim/lua/config

if (Test-Path -Path $env:LOCALAPPDATA/nvim/lua/plugins) {
  rm -r $env:LOCALAPPDATA/nvim/lua/plugins
}
mkdir $env:LOCALAPPDATA/nvim/lua/plugins

cp nvim/init.lua $env:LOCALAPPDATA/nvim/init.lua
cp nvim/lua/config/* $env:LOCALAPPDATA/nvim/lua/config/
cp nvim/lua/plugins/* $env:LOCALAPPDATA/nvim/lua/plugins/

mkdir -p $home/Documents/WindowsPowershell -ErrorAction SilentlyContinue
cp Microsoft.PowerShell_profile.ps1 $home/Documents/WindowsPowershell

mkdir -p $home/Documents/Powershell -ErrorAction SilentlyContinue
cp Microsoft.PowerShell_profile.ps1 $home/Documents/Powershell

