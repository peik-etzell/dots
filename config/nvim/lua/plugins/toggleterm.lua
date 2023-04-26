return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
		opts = {},
		keys = {
			{
				"<A-CR>",
				function()
					require("toggleterm").toggle()
				end,
				mode = { "n", "i", "t" },
			},
		},
	},
}
