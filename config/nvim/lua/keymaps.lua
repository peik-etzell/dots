Map_key = function(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local let = vim.g

-- LEADER MAPS
Map_key("n", "<leader>q", ":q<CR>")
Map_key("n", "<C-CR>", ":call TermOpen()<CR>")
-- Map_key("n", "<leader>d", ":lua vim.diagnostic.open_float({border = 'single'})<CR>")
