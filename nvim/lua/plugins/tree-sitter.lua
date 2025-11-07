-- lua/plugins/markdown.lua
--
-- This file configures:
-- 1. nvim-treesitter: For better syntax highlighting
-- 2. glow.nvim: For Markdown preview
--
-- The LSP for Markdown ('marksman') is installed in 'lsp.lua'.
return {
    -- 1. Treesitter (Better Syntax Highlighting)
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate", -- Installs/updates parsers
        config = function()
            require("nvim-treesitter.configs").setup({
                -- Parsers to install.
                ensure_installed = { "c", "lua", "vim", "markdown", "markdown_inline" },

                -- Enable syntax highlighting
                highlight = {
                    enable = true,
                },
                -- Enable indentation based on the code structure
                indent = {
                    enable = true,
                },
            })
        end,
    },
}
