--[[

 To use this configuration:
 1. Make sure you have Neovim v0.8.0+ installed.
 2. Install a Nerd Font: https://www.nerdfonts.com
 6. Launch Neovim (`nvim`). It will automatically install lazy.nvim and all the plugins.

--]]

-- =============================================================================
-- Options
-- =============================================================================
-- For more options, see `:help option-list`

-- UI Font
vim.o.guifont = "FiraCode Nerd Font:h10"

-- Set editor behavior
vim.o.number = true             -- Show line numbers
vim.o.relativenumber = true     -- Show relative line numbers
vim.o.cursorline = true         -- Highlight the current line
vim.o.splitright = true         -- Vertical splits open to the right
vim.o.splitbelow = true         -- Horizontal splits open below
vim.o.termguicolors = true      -- Enable 24-bit RGB color in the TUI
vim.o.scrolloff = 8             -- Keep 8 lines of context around the cursor
vim.o.clipboard = "unnamedplus" -- Use system clipboard

-- Tabs and indentation
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

-- Search
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true


-- =============================================================================
-- Plugin Manager: lazy.nvim
-- =============================================================================
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

require("lazy").setup({
    -- =========================================================================
    -- Theme
    -- =========================================================================
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                contrast = "hard", -- Or "soft"
            })
            vim.cmd.colorscheme "gruvbox"
        end,
    },

    -- =========================================================================
    -- UI and General UX
    -- =========================================================================
    {
        "nvim-tree/nvim-web-devicons", -- Icons for filetypes
        config = function()
            require('nvim-web-devicons').setup()
        end
    },
    {
        "nvim-lualine/lualine.nvim", -- Status line
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'gruvbox'
                }
            })
        end
    },
    {
        "nvim-tree/nvim-tree.lua", -- File explorer
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup()
        end,
    },

    -- =========================================================================
    -- Core Functionality
    -- =========================================================================
    {
        "nvim-treesitter/nvim-treesitter", -- Syntax highlighting and more
        build = ":TSUpdate",
        config = function()
          require'nvim-treesitter.configs'.setup {
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "python", "html", "css" },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
          }
        end
    },
    {
        'nvim-telescope/telescope.nvim', -- Fuzzy finder
        tag = '0.1.5',
        dependencies = { 
            'nvim-lua/plenary.nvim',
            { 
		-- If encountering errors, see telescope-fzf-native README for installation instructions
                'nvim-telescope/telescope-fzf-native.nvim',

                -- `build` is used to run some command when the plugin is installed/updated.
                -- This is only run then, not every time Neovim starts up.
                build = 'make',

                -- `cond` is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                  return vim.fn.executable 'make' == 1
                end,
              
              { 'nvim-telescope/telescope-ui-select.nvim' },

              -- Useful for getting pretty icons, but requires a Nerd Font.
              { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
          },
	},
        
        config = function()
            -- [[ Configure Telescope ]]
            -- See `:help telescope` and `:help telescope.setup()`
            require('telescope').setup {
                -- You can put your default mappings / updates / etc. in here
                -- All the info you're looking for is in `:help telescope.setup()`
                --
                -- defaults = {
                --   mappings = {
                --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
                --   },
                -- },
                -- pickers = {}
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
            }

            -- Enable Telescope extensions if they are installed
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')
        
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = "Find files" })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live Grep" })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find Buffers" })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help Tags" })
            vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = "Git Files" })
        end
    },

    -- =========================================================================
    -- Commenting
    -- =========================================================================
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    -- =========================================================================
    -- VSCode Style Multi-Cursor (Ctrl+D)
    -- =========================================================================
    {
        'mg979/vim-visual-multi',
        branch = 'master',
        init = function()
            -- This plugin has its own extensive set of keymaps.
            -- We are setting global variables to configure it before it loads.
            -- Using vim.api.nvim_set_var is more robust than vim.g for this.
            vim.api.nvim_set_var('VM_maps', {
                ['Find Under'] = '<C-d>',
                ['Find Subword Under'] = '<C-d>',
                ['Select All'] = '' -- Example: disable <C-a> to prevent conflicts
            })
        end
    },
})

-- =============================================================================
-- Keymaps
-- =============================================================================
-- For more information, see `:help key-mapping`

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- NvimTree (File Explorer)
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = "Toggle file explorer" })

-- Buffer management
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = "Next buffer" })
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = "Previous buffer" })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = "Close buffer" })

-- Window management
vim.keymap.set('n', '<leader>wv', ':vsplit<CR>', { desc = "Vertical split" })
vim.keymap.set('n', '<leader>wh', ':split<CR>', { desc = "Horizontal split" })
vim.keymap.set('n', '<leader>wc', '<C-w>c', { desc = "Close window" })

-- Commenting
vim.keymap.set({'n', 'v'}, '<leader>/', function()
    require('Comment.api').toggle.linewise(vim.fn.visualmode())
end, { desc = 'Toggle comment' })

print("Neovim config loaded successfully!")

