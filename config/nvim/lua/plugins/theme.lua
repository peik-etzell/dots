return {
	{
		"projekt0n/github-nvim-theme",
		-- init = function()
		-- 	vim.cmd("colorscheme github_dark")
		-- end,
		branch = "0.0.x",
		priority = 1000,
	},
	{ "ellisonleao/gruvbox.nvim", priority = 1000 },
	{ "catppuccin/nvim", priority = 1000 },
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
		enabled = false,
		config = function()
			require("indent_blankline").setup({ show_current_context = true, show_current_context_start = true })
		end,
	},
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
					theme = "auto",
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
					lualine_c = {
						{
							"filename",
							path = 0, -- just the filename
						},
					},
					-- lualine_c = {},
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
				winbar = {
					lualine_a = {
						{
							"filename",
							path = 1, -- just the filename
						},
					},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				inactive_winbar = {},
				extensions = {},
			})
		end,
	},
}
