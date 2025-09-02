return {
	-- disable trouble
	{ "folke/trouble.nvim", enabled = false },
	-- disable todo-comment
	{ "folke/todo-comments.nvim", enabled = false },

	-- add more treesitter parsers
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"bash",
				"html",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"vim",
				"yaml",
			},
		},
	},
}
