return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
		opts = {},
		keys = {
			{ "<A-CR>", ":ToggleTerm<CR>", "n" },
			{ "<A-CR>", "<C-\\><C-n>:ToggleTerm<CR>", mode = "t" },
		},
	},
}
