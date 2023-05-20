return {
	{
		"lervag/vimtex",
		ft = "tex",
		config = function()
			local set_keymap_n = function(lhs, rhs)
				vim.api.nvim_set_keymap("n", lhs, rhs, {})
			end
			set_keymap_n("j", "gj")
			set_keymap_n("k", "gk")
			set_keymap_n("$", "g$")
			set_keymap_n("0", "g0")
		end,
	},
}
