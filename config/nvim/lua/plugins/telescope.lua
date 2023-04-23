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
			{
				"bi0ha2ard/telescope-ros.nvim",
			},
			{ "nvim-telescope/telescope-dap.nvim" },
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
						"%.ipe",
						"%.eps",
						"build/",
						"install/",
						"log/",
					},
				},
			})
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ros")
		end,
		keys = {
			{ "<leader>f", ":Telescope find_files<CR>" },
			{ "<leader>g", ":lua require('telescope.builtin').live_grep({ layout_strategy = 'vertical' })<CR>" },
			{ "<leader>c", ":Telescope colorscheme<CR>" },
			{ "<leader>lr", ":Telescope lsp_references<CR>" },
			{ "<leader>lk", ":Telescope diagnostics<CR>" },
			{ "<leader>li", ":Telescope lsp_implementations<CR>" },
			{ "<leader>ld", ":Telescope lsp_definitions<CR>" },
			{ "<leader>t", ":Telescope<CR>" },
			{
				"<C-/>",
				":lua require('telescope.builtin').current_buffer_fuzzy_find({ layout_strategy = 'vertical' })<CR>",
			},
		},
	},
}
