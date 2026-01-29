return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup({})

            vim.treesitter.language.register("markdown", "mdx")

            -- Fix for telescope/other plugins using deprecated ft_to_lang
            if not vim.treesitter.language.ft_to_lang then
                vim.treesitter.language.ft_to_lang = vim.treesitter.language.get_lang
            end

            local map = vim.keymap.set
            local selection_node = nil

            map({ "n", "x" }, "[x", function()
                local node = vim.treesitter.get_node()
                if not node then return end
                if vim.fn.mode() == "n" then
                    selection_node = node
                    local sr, sc, er, ec = node:range()
                    vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
                    vim.cmd("normal! v")
                    vim.api.nvim_win_set_cursor(0, { er + 1, ec - 1 })
                else
                    local parent = selection_node and selection_node:parent()
                    if parent then
                        selection_node = parent
                        local sr, sc, er, ec = parent:range()
                        vim.cmd("normal! \027")
                        vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
                        vim.cmd("normal! v")
                        vim.api.nvim_win_set_cursor(0, { er + 1, ec - 1 })
                    end
                end
            end, { desc = "Expand syntax selection" })

            map("x", "]x", function()
                if selection_node then
                    local child = selection_node:child(0)
                    if child then
                        selection_node = child
                        local sr, sc, er, ec = child:range()
                        vim.cmd("normal! \027")
                        vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
                        vim.cmd("normal! v")
                        vim.api.nvim_win_set_cursor(0, { er + 1, ec - 1 })
                    end
                end
            end, { desc = "Shrink syntax selection" })
        end,
    },
    {
        "echasnovski/mini.ai",
        version = "*",
        config = function()
            require("mini.ai").setup({
                n_lines = 500,
                custom_textobjects = {
                    f = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
                    c = require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
                    a = require("mini.ai").gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
                },
            })
        end,
    },
}
