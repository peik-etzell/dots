return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				popup_border_style = vim.g.border,
				window = {
					width = 40,
					mappings = {
						["<tab>"] = "open",
					},
				},
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			-- { "<C-b>", ":NeoTreeShowToggle<CR>" },
		},
	},
}
