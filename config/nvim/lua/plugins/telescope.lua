return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					layout_strategy = "center",
					layout_config = {
						-- prompt_position = "top",
						mirror = true,
						anchor = "N",
					},
				},
			})
		end,
		keys = {
			{ "<leader>f", ":Telescope find_files<CR>" },
			{ "<leader>g",
				":Telescope live_grep<CR>" },
		},
	},
}
