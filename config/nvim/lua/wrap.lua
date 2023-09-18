-- Use wrap on files
local pattern = { "*.md", "*.tex", "*.txt" }
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = pattern,
	callback = function(ev)
		local set = vim.opt
		set.wrap = true
		set.linebreak = true

		local set_keymap_n = function(lhs, rhs)
			vim.keymap.set("n", lhs, rhs, { silent = true, buffer = true })
		end
		set_keymap_n("j", "gj")
		set_keymap_n("k", "gk")
		set_keymap_n("$", "g$")
		set_keymap_n("0", "g0")
	end,
})

vim.api.nvim_create_autocmd({ "BufLeave" }, {
	pattern = pattern,
	callback = function(ev)
		local set = vim.opt
		set.wrap = false
		set.linebreak = false
	end,
})
