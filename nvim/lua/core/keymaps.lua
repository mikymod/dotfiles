-- lua/core/keymaps.lua

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Save file (Ctrl+S)
map("i", "<C-s>", "<ESC>:w<CR>a", opts)
map("n", "<C-s>", ":w<CR>", opts)

-- Copy/Cut/Paste (system clipboard)
map("v", "<C-c>", '"+y', opts)
map("v", "<C-x>", '"+d', opts)
map("n", "<C-v>", '"+P', opts)
map("i", "<C-v>", '<C-R>+', opts)

-- Undo/Redo
map("n", "<C-z>", "u", opts)
map("n", "<C-y>", "<C-r>", opts)

-- == Line Movement (Alt+j/k) ==
map("n", "<M-k>", ":m .-2<CR>==", opts)
map("n", "<M-j>", ":m .+1<CR>==", opts)
map("v", "<M-k>", ":m '<-2<CR>gv=gv", opts)
map("v", "<M-j>", ":m '>+1<CR>gv=gv", opts)

-- == Window/Split Management (matches Zed ctrl-w bindings) ==
map("n", "<leader>|", ":vsplit<CR>", opts)
map("n", "<leader>_", ":split<CR>", opts)
map("n", "<C-w>sv", ":vnew<CR>", opts)           -- Zed: ctrl-w s v
map("n", "<C-w>sh", ":new<CR>", opts)            -- Zed: ctrl-w s h
map("n", "<C-w>z", "<C-w>|<C-w>_", opts)         -- Zed: ctrl-w z (zoom toggle)
map("n", "<C-w>q", ":close<CR>", opts)           -- Zed: ctrl-w q

-- Pane navigation (ctrl+hjkl, matches Zed)
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-l>', '<C-w>l', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)

-- == LSP Keybindings (matches Zed vim mode) ==
map("n", "gd", vim.lsp.buf.definition, opts)              -- Go to definition
map("n", "gD", vim.lsp.buf.declaration, opts)             -- Go to declaration
map("n", "gI", vim.lsp.buf.implementation, opts)          -- Go to implementation
map("n", "gy", vim.lsp.buf.type_definition, opts)         -- Go to type definition
map("n", "gR", vim.lsp.buf.references, opts)              -- Zed: g shift-r (find all refs)
map("n", "gr", vim.lsp.buf.rename, opts)                  -- Zed: g r (rename)
map("n", "ga", vim.lsp.buf.code_action, opts)             -- Zed: g a (code actions)
map("n", "K", vim.lsp.buf.hover, opts)                    -- Zed: shift-k (hover)

-- Diagnostics navigation (matches Zed g] / g[)
map("n", "g]", vim.diagnostic.goto_next, opts)
map("n", "g[", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "<leader>cd", vim.diagnostic.open_float, opts)   -- Line diagnostics

-- == File Explorer (matches Zed ctrl-e and -) ==
map("n", "<C-e>", ":NvimTreeToggle<CR>", opts)            -- Zed: ctrl-e
map("n", "-", ":NvimTreeFindFile<CR>", opts)              -- Zed: - (reveal in tree)

-- == Telescope/Finder (matches Zed) ==
map("n", ",fo", ":Telescope oldfiles<CR>", opts)          -- Zed: ,fo (recent files)
map("n", "<leader>fo", ":Telescope oldfiles<CR>", opts)
map("n", "<leader>ff", ":Telescope find_files<CR>", opts) -- Find files
map("n", "<leader>/", ":Telescope live_grep<CR>", opts)   -- Grep (like LazyVim)
map("n", "<leader>,", ":Telescope buffers<CR>", opts)     -- Buffers
map("n", "<leader>:", ":Telescope command_history<CR>", opts)

-- == Tabs/Buffers ==
map('n', '<S-h>', ':bprevious<CR>', opts)
map('n', '<S-l>', ':bnext<CR>', opts)
map("n", "<leader>bd", ":bdelete<CR>", opts)              -- Delete buffer
