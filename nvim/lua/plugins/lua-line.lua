-- lua/plugins/statusline.lua
--
-- Configures 'lualine.nvim', a simple and nice status line.
return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- For icons
    config = function()
        require("lualine").setup({
            options = {
                theme = "gruvbox",
                icons_enabled = true,
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
        })
    end,
}
