return {
	{
		"nvim-tree/nvim-tree.lua",
		init = function()
			require("nvim-tree").setup({
				update_focused_file = {
					enable = true,
				},
				renderer = {
					add_trailing = true,
					group_empty = true,
				},
			})
			local function open_nvim_tree(data)
				-- buffer is a real file on the disk
				local real_file = vim.fn.filereadable(data.file) == 1

				-- buffer is a [No Name]
				local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

				if real_file and not no_name then
					return
				end

				-- open the tree, find the file but don't focus it
				require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
			end

			vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader><Esc>", ":NvimTreeFocus<CR>" },
			{ "<C-b>",         ":NvimTreeToggle<CR>" },
		},
	},
}
