-- lua/core/options.lua
--
-- This file contains universal editor settings.
-- Each option is commented to explain what it does.

local opt = vim.opt -- Use 'opt' for brevity

-- == VIM BEHAVIOR ==
opt.mouse = "a"               -- Enable mouse support in all modes
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.swapfile = false          -- Don't create swapfiles
opt.undofile = true           -- Enable persistent undo

-- == UI & APPEARANCE ==
opt.number = true         -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.termguicolors = true  -- Enable true color support
opt.scrolloff = 8         -- Keep 8 lines visible above/below cursor
opt.signcolumn = "yes"    -- Always show the sign column
opt.wrap = false          -- Do not wrap long lines

-- == TABS & INDENTATION ==
-- Set indentation to 4 spaces, as is common for C
opt.tabstop = 4        -- Number of spaces a <Tab> counts for
opt.shiftwidth = 4     -- Number of spaces for auto-indent
opt.softtabstop = 4    -- Number of spaces <Tab> inserts
opt.expandtab = true   -- Use spaces instead of tabs
opt.smartindent = true -- Be smart about indentation

-- == SEARCH ==
opt.hlsearch = true   -- Highlight search results
opt.incsearch = true  -- Show search results as you type
opt.ignorecase = true -- Ignore case in search
opt.smartcase = true  -- ...unless search contains an uppercase letter

