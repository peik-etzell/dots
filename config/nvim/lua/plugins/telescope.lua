return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		tag = "0.1.1",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
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
						height = 0.9,
						width = 0.7,
						horizontal = {
							preview_width = 0.6,
						},
					},
					path_display = { "truncate" },
					file_ignore_patterns = {
						"%.ipe",
						"%.eps",
						"build/",
						"install/",
						"log/",
					},
				},
				-- extensions = {
				-- 	fzf = {
				-- 		fuzzy = true,
				-- 		override_generic_sorter = true,
				-- 		override_file_sorter = true,
				-- 		case_mode = "smart_case",
				-- 	},
				-- },
			})
			require("telescope").load_extension("fzf")
		end,
		keys = {
			{ "<leader>f", ":Telescope find_files<CR>" },
			{ "<leader>g", ":Telescope live_grep<CR>" },
			{ "<leader>c", ":Telescope colorscheme<CR>" },
			{ "<leader>lr", ":Telescope lsp_references<CR>" },
			{ "<leader>lk", ":Telescope diagnostics<CR>" },
			{ "<leader>li", ":Telescope lsp_implementations<CR>" },
			{ "<leader>ld", ":Telescope lsp_definitions<CR>" },
			{ "<C-/>", ":Telescope current_buffer_fuzzy_find<CR>" },
		},
	},
}
