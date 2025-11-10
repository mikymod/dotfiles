-- lua/plugins/filetree.lua
--
-- Configures 'nvim-tree', a file explorer.
return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- For icons
    config = function()
        require("nvim-tree").setup({
            -- You can add any setup options here
            view = {
                width = 30,
            },
            renderer = {
                group_empty = true,
            },
        })

        -- VSCode-style Toggle (Ctrl+B)
        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", opts)
    end,
}
