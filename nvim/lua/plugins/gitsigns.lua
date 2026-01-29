return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("gitsigns").setup({
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local map = vim.keymap.set
                local opts = { buffer = bufnr, silent = true }

                -- Navigation (matches Zed's ]c / [c)
                map("n", "]c", function()
                    if vim.wo.diff then return "]c" end
                    vim.schedule(function() gs.next_hunk() end)
                    return "<Ignore>"
                end, { expr = true, buffer = bufnr })

                map("n", "[c", function()
                    if vim.wo.diff then return "[c" end
                    vim.schedule(function() gs.prev_hunk() end)
                    return "<Ignore>"
                end, { expr = true, buffer = bufnr })

                -- Git blame (matches Zed's ,gb)
                map("n", ",gb", gs.blame_line, opts)
                map("n", "<leader>gb", gs.blame_line, opts)

                -- Stage/unstage hunks
                map("n", "<leader>hs", gs.stage_hunk, opts)
                map("n", "<leader>hr", gs.reset_hunk, opts)
                map("n", "<leader>hp", gs.preview_hunk, opts)
            end,
        })
    end,
}
