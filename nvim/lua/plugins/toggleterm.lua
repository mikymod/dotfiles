return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = 15,
            open_mapping = [[<c-`>]],
            direction = "horizontal",
            shade_terminals = true,
            shading_factor = 2,
            persist_size = true,
            close_on_exit = true,
        })
    end,
}
