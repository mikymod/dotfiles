-- init.lua
--
-- This is the main entry point for your NeoVim configuration.
-- It sets up the 'lazy.nvim' plugin manager and loads all other
-- configuration files.

-- Set <space> as the leader key
-- This is the most common custom leader key.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 1. BOOTSTRAP LAZY.NVIM
-- This section ensures 'lazy.nvim' is installed.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- 2. LOAD CORE CONFIG
-- Load basic options and keymaps before loading plugins.
require("core.options")
require("core.keymaps")

-- 3. SETUP LAZY.NVIM
-- This tells lazy.nvim to load all plugin specifications from the
-- 'lua/plugins' directory.
require("lazy").setup("plugins", {
    -- You can add lazy.nvim options here, e.g., for a UI
    ui = {
        border = "rounded",
    },
})

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
