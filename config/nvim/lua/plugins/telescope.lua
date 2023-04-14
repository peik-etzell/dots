return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					sorting_strategy = "ascending",
					scroll_strategy = "limit",
					layout_strategy = "flex",
					layout_config = {
						prompt_position = "top",
						mirror = true,
						anchor = "N",
						height = 0.9,
						width = 0.7,
						horizontal = {
							preview_width = 0.6,
						},
					},
					file_ignore_patterns = {
						"%.ipe",
						"%.eps",
					},
				},
			})
		end,
		keys = {
			{ "<leader>f", ":Telescope find_files<CR>" },
			{ "<leader>g", ":Telescope live_grep<CR>" },
		},
	},
}
