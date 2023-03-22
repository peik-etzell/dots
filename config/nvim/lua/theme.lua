require("nvim-web-devicons").setup({
	color_icons = true,
	override_by_filename = { ["gitignore"] = { icon = " ", color = "#f1502f", name = "Gitignore" } },
})

require("indent_blankline").setup({ show_current_context = true, show_current_context_start = true })

require("github-theme").setup()
-- vim.cmd("colorscheme catppuccin-frappe")
--
-- require("catppuccin").setup({
--     flavour = "frappe", -- latte, frappe, macchiato, mocha
--     background = { -- :h background
--         light = "latte",
--         dark = "frappe",
--     },
--     compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
--     transparent_background = false,
--     term_colors = false,
--     dim_inactive = {
--         enabled = true,
--         shade = "dark",
--         percentage = 0.5,
--     },
--     styles = {
--         comments = { "italic" },
--         conditionals = { "italic" },
--         loops = {},
--         functions = {},
--         keywords = {},
--         strings = {},
--         variables = {},
--         numbers = {},
--         booleans = {},
--         properties = {},
--         types = {},
--         operators = {},
--     },
--     color_overrides = {},
--     custom_highlights = {},
--     integrations = {
--         cmp = true,
--         gitsigns = true,
-- 		mason = true,
--         -- nvimtree = true,
--         -- telescope = true,
--         -- treesitter = true,
--         -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
--     },
-- })
--
require("lualine").setup({
	options = {
		icons_enabled = true,
		-- theme = "catppuccin",
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
