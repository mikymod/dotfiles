-- lua/core/keymaps.lua

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Save file (Ctrl+S)
-- In Insert mode, exit to Normal, save, and return to Insert
map("i", "<C-s>", "<ESC>:w<CR>a", opts)
map("n", "<C-s>", ":w<CR>", opts)

-- Copy (Ctrl+C)
-- Copies to the system clipboard
map("v", "<C-c>", '"+y', opts)

-- Cut (Ctrl+X)
map("v", "<C-x>", '"+d', opts)

-- Paste (Ctrl+V)
-- In Normal mode, pastes before the cursor
map("n", "<C-v>", '"+P', opts)
-- In Insert mode, pastes directly
map("i", "<C-v>", '<C-R>+', opts)

-- Undo/Redo
map("n", "<C-z>", "u", opts)
map("n", "<C-y>", "<C-r>", opts)

-- == Line Movement ==
-- Move the current line up/down (Alt + k/j)
map("n", "<M-k>", ":m .-2<CR>==", opts)
map("n", "<M-j>", ":m .+1<CR>==", opts)
-- Move a visual selection up/down
map("v", "<M-k>", ":m '<-2<CR>gv=gv", opts)
map("v", "<M-j>", ":m '>+1<CR>gv=gv", opts)

--
-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map("n", "<leader>|", ":vsplit<CR>", opts) -- Split vertical
map("n", "<leader>_", ":split<CR>", opts)  -- Split horizontal

map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-l>', '<C-w>l', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)

-- TODO: test this
-- Navigate between tabs with Shift+H and Shift+L
map('n', '<S-h>', ':tabprevious<CR>', opts)
map('n', '<S-l>', ':tabnext<CR>', opts)
map('n', '<S-b>', ':Telescope buffers', opts)
