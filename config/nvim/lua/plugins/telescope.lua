return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		tag = "0.1.2",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			{
				"nvim-telescope/telescope-dap.nvim",
				dependencies = {
					"mfussenegger/nvim-dap",
					"nvim-treesitter/nvim-treesitter",
				},
			},
		},
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
						height = 0.90,
						width = 0.95,
						horizontal = {
							preview_width = 0.5,
						},
					},
					path_display = { "truncate" },
					file_ignore_patterns = {
						-- latex
						"%.ipe",
						"%.eps",
                        "%.fls",
                        "%.fdb_latexmk",
                        "%.synctex.gz",
                        "%.aux",
						-- ros
						"build/",
						"install/",
						"log/",
						"logs/",
						"devel/",
						-- clangd
						"compile_commands",
					},
				},
			})
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("dap")
		end,
		keys = {
			{ "<leader>f", ":Telescope find_files<CR>", desc = "Find file" },
			{
				"<leader>g",
				":lua require('telescope.builtin').live_grep({ layout_strategy = 'vertical' })<CR>",
				desc = "Grep string",
			},
			{ "<leader>c", ":Telescope colorscheme<CR>", desc = "Colorscheme" },
			{ "<leader>lr", ":Telescope lsp_references<CR>", desc = "References" },
			{ "<leader>lk", ":Telescope diagnostics<CR>", desc = "Diagnostics" },
			{ "<leader>li", ":Telescope lsp_implementations<CR>", desc = "Implementations" },
			{ "<leader>ld", ":Telescope lsp_definitions<CR>", desc = "Definitions" },
			{ "<leader>ta", ":Telescope<CR>", desc = "Telescope" },
			{
				"<C-/>",
				":lua require('telescope.builtin').current_buffer_fuzzy_find({ layout_strategy = 'vertical' })<CR>",
			},
		},
	},
}
