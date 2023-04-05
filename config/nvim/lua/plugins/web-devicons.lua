return {
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				color_icons = true,
				override_by_filename = { ["gitignore"] = { icon = " ", color = "#f1502f", name = "Gitignore" } },
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({ show_current_context = true, show_current_context_start = true })
		end,
	},
	{ "ellisonleao/gruvbox.nvim", enabled = false },
	{ "catppuccin/nvim", enabled = false },
	{
		"lewis6991/gitsigns.nvim",
		init = function()
			require("gitsigns").setup()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		init = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					-- lualine_c = { "filename" },
					lualine_c = { "%f" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			})
		end,
		dependencies = {
			{
				"projekt0n/github-nvim-theme",
				init = function()
					require("github-theme").setup()
				end,
			},
		},
	},
}
