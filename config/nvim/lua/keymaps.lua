Map_key = function(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local let = vim.g

let.mapleader = " "
let.maplocalleader = ","
Map_key("n", "<C-.>", ":CodeActionMenu<CR>")

-- LEADER MAPS
Map_key("n", "<leader>q", ":q<CR>")

Map_key("n", "<C-CR>", ":call TermOpen()<CR>")

-- TELESCOPE
Map_key("n", "<leader>f", ":Telescope find_files<CR>")
Map_key("n", "<leader>g", ":Telescope live_grep<CR>")

-- NVIMTREE
Map_key("n", "<leader><Esc>", ":NvimTreeFocus<CR>")
Map_key("n", "<C-b>", ":NvimTreeToggle<CR>")

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

-- https://github.com/terrortylor/nvim-comment
require("nvim_comment").setup()
Map_key("n", "<leader>/", ":CommentToggle<CR>")
Map_key("v", "<leader>/", ":CommentToggle<CR>")

-- DAP
Map_key("n", "<F4>", ":lua require('dapui').toggle()<CR>")
Map_key("n", "<F5>", ":lua require('dap').continue()<CR>")
Map_key("n", "<F9>", ":lua require('dap').toggle_breakpoint()<CR>")
Map_key("n", "<F10>", ":lua require('dap').step_over()<CR>")
Map_key("n", "<F11>", ":lua require('dap').step_into()<CR>")
Map_key("n", "<S-<F11>>", ":lua require('dap').step_into()<CR>")
