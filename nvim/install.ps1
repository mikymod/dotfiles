# install.ps1
#
# PowerShell script to install the NeoVim configuration.
#
# INSTRUCTIONS:
# 1. Save this file as 'install.ps1' in the same folder where
#    you saved 'init.lua' and the 'lua' directory.
# 2. Right-click this file and select "Run with PowerShell".

# Stop the script if any command fails
$ErrorActionPreference = "Stop"

# --- 1. Define Paths ---

# Get the directory where this script is located
$ScriptDir = $PSScriptRoot

# Define the NeoVim config directory path
$NvimConfigDir = "$env:LOCALAPPDATA\nvim"

# Define a backup path for any existing config
$BackupDir = "$env:LOCALAPPDATA\nvim.bak"

Write-Host "NeoVim configuration will be installed to: $NvimConfigDir"

# --- 2. Pre-flight Checks ---

# Check for Git (required for lazy.nvim)
Write-Host "Checking for Git..."
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "Git is not installed or not in your PATH. Git is required for the plugin manager (lazy.nvim). Please install it and try again."
    Exit 1
}
Write-Host "Git found."

# Check for NeoVim
Write-Host "Checking for NeoVim (nvim.exe)..."
if (-not (Get-Command nvim -ErrorAction SilentlyContinue)) {
    Write-Error "NeoVim (nvim.exe) is not installed or not in your PATH. Please install it from https://neovim.io/ and try again."
    Exit 1
}
Write-Host "NeoVim found."

# --- 3. Backup Existing Configuration ---

if (Test-Path $NvimConfigDir) {
    Write-Host "Existing configuration found. Backing it up to $BackupDir"
    
    # Remove old backup if it exists
    if (Test-Path $BackupDir) {
        Remove-Item -Recurse -Force $BackupDir
    }
    
    # Move the current config to the backup location
    Move-Item -Path $NvimConfigDir -Destination $BackupDir
    Write-Host "Backup complete."
}

# --- 4. Install New Configuration ---

Write-Host "Creating new config directory..."
New-Item -ItemType Directory -Path $NvimConfigDir

Write-Host "Copying configuration files..."
# Copy init.lua
Copy-Item -Path "$ScriptDir\init.lua" -Destination $NvimConfigDir
# Copy the entire lua directory
Copy-Item -Path "$ScriptDir\lua" -Destination $NvimConfigDir -Recurse

Write-Host "Configuration files copied."

# --- 5. Install Recommended Tools (Optional) ---

Write-Host ""
Write-Host "--- Optional Tools ---"
Write-Host "This config uses 'glow' for Markdown previews and 'clangd' for C programming."
Write-Host "You can install them using winget with the following (uncomment the lines in the script if you want):"
Write-Host ""
# Write-Host "Installing glow..."
# winget install glow
# Write-Host "Installing clangd..."
# winget install llvm.clangd
Write-Host "(Note: The LSP/formatter plugins will try to auto-install these anyway, but a manual install is cleaner.)"


# --- 6. Final Instructions ---
Write-Host ""
Write-Host "--- SUCCESS! ---" -ForegroundColor Green
Write-Host ""
Write-Host "Installation is complete."
Write-Host "Run 'nvim' from your terminal."
Write-Host "The plugin manager (lazy.nvim) will open and automatically install all the plugins."
Write-Host "Once it's finished, restart nvim and enjoy!"
Write-Host ""

# Pause the script so the user can read the output
Read-Host -Prompt "Press Enter to exit"
