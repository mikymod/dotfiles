return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        spec = {
            {
                mode = { "n", "v" },
                -- Leader groups
                { "<leader>b", group = "buffer" },
                { "<leader>c", group = "code" },
                { "<leader>f", group = "file/find" },
                { "<leader>g", group = "git" },
                { "<leader>h", group = "hunks" },
                { "<leader>p", group = "project/search" },
                { "<leader>s", group = "search" },
                { "<leader>t", group = "terminal" },
                { "<leader>u", group = "ui" },
                { "<leader>v", group = "vim/help" },
                { "<leader>w", group = "windows", proxy = "<c-w>" },
                { "<leader>x", group = "diagnostics" },

                -- Navigation groups
                { "[", group = "prev" },
                { "]", group = "next" },
                { "g", group = "goto" },

                -- Buffers
                { "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete Buffer" },
                { "<leader>bb", "<cmd>e #<cr>", desc = "Switch to Other Buffer" },
                { "<leader>,", "<cmd>Telescope buffers<cr>", desc = "Switch Buffer" },

                -- Files
                { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
                { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
                { "<leader>fn", "<cmd>enew<cr>", desc = "New File" },
                { "<leader>fe", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
                { "<leader>fE", "<cmd>NvimTreeFindFile<cr>", desc = "Explorer (reveal)" },

                -- Search
                { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
                { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
                { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
                { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
                { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
                { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
                { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
                { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
                { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Marks" },
                { "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Resume Last" },
                { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
                { "<leader>sS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
                { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Word under cursor" },

                -- Project search
                { "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
                { "<leader>ps", function()
                    require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
                end, desc = "Grep String" },
                { "<leader>pws", function()
                    require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
                end, desc = "Word (exact)" },
                { "<leader>pWs", function()
                    require("telescope.builtin").grep_string({ search = vim.fn.expand("<cWORD>") })
                end, desc = "WORD (exact)" },

                -- Code/LSP
                { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
                { "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
                { "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, desc = "Format" },
                { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },

                -- Git
                { "<leader>gb", function() require("gitsigns").blame_line() end, desc = "Blame Line" },
                { "<leader>gB", function() require("gitsigns").blame_line({ full = true }) end, desc = "Blame Line (full)" },
                { "<leader>gd", function() require("gitsigns").diffthis() end, desc = "Diff This" },
                { "<leader>gp", function() require("gitsigns").preview_hunk() end, desc = "Preview Hunk" },
                { "<leader>gr", function() require("gitsigns").reset_hunk() end, desc = "Reset Hunk" },
                { "<leader>gR", function() require("gitsigns").reset_buffer() end, desc = "Reset Buffer" },
                { "<leader>gs", function() require("gitsigns").stage_hunk() end, desc = "Stage Hunk" },
                { "<leader>gS", function() require("gitsigns").stage_buffer() end, desc = "Stage Buffer" },
                { "<leader>gu", function() require("gitsigns").undo_stage_hunk() end, desc = "Undo Stage Hunk" },

                -- Hunks (alternative prefix)
                { "<leader>hs", function() require("gitsigns").stage_hunk() end, desc = "Stage Hunk" },
                { "<leader>hr", function() require("gitsigns").reset_hunk() end, desc = "Reset Hunk" },
                { "<leader>hp", function() require("gitsigns").preview_hunk() end, desc = "Preview Hunk" },

                -- Windows
                { "<leader>|", "<cmd>vsplit<cr>", desc = "Vertical Split" },
                { "<leader>_", "<cmd>split<cr>", desc = "Horizontal Split" },
                { "<leader>wd", "<cmd>close<cr>", desc = "Delete Window" },
                { "<leader>ww", "<C-w>w", desc = "Other Window" },
                { "<leader>wh", "<C-w>h", desc = "Go Left" },
                { "<leader>wj", "<C-w>j", desc = "Go Down" },
                { "<leader>wk", "<C-w>k", desc = "Go Up" },
                { "<leader>wl", "<C-w>l", desc = "Go Right" },

                -- Terminal
                { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
                { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
                { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal Terminal" },
                { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Vertical Terminal" },

                -- UI toggles
                { "<leader>uw", "<cmd>set wrap!<cr>", desc = "Toggle Word Wrap" },
                { "<leader>ul", "<cmd>set relativenumber!<cr>", desc = "Toggle Relative Numbers" },
                { "<leader>us", "<cmd>set spell!<cr>", desc = "Toggle Spelling" },
                { "<leader>uc", "<cmd>set cursorline!<cr>", desc = "Toggle Cursorline" },

                -- Vim/Help
                { "<leader>vh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },

                -- Diagnostics/Quickfix
                { "<leader>xd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Buffer Diagnostics" },
                { "<leader>xD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
                { "<leader>xl", "<cmd>lopen<cr>", desc = "Location List" },
                { "<leader>xq", "<cmd>copen<cr>", desc = "Quickfix List" },

                -- Goto with descriptions
                { "gd", vim.lsp.buf.definition, desc = "Definition" },
                { "gD", vim.lsp.buf.declaration, desc = "Declaration" },
                { "gI", vim.lsp.buf.implementation, desc = "Implementation" },
                { "gr", vim.lsp.buf.rename, desc = "Rename" },
                { "gR", vim.lsp.buf.references, desc = "References" },
                { "gy", vim.lsp.buf.type_definition, desc = "Type Definition" },
                { "ga", vim.lsp.buf.code_action, desc = "Code Action" },
                { "K", vim.lsp.buf.hover, desc = "Hover" },

                -- Navigation with descriptions
                { "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
                { "[d", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
                { "]c", desc = "Next Hunk" },
                { "[c", desc = "Prev Hunk" },
            },
        },
    },
    keys = {
        { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Keymaps" },
    },
}
