return {
	{
		"lervag/vimtex",
		ft = "tex",
		keys = {
			{ "j", "gj" },
			{ "k", "gk" },
			{ "$", "g$" },
			{ "0", "g0" },
		},
		config = function()
			local let = vim.g
			let.vimtex_compiler_latexmk = {
				build_dir = "build",
			}

			let.maplocalleader = ","
			let.tex_flavor = "latex"
			let.vimtex_view_method = "zathura"
			let.vimtex_quickfix_mode = 0
			let.tex_conceal = "abdmg"

			local set = vim.opt
			set.conceallevel = 1
			set.wrap = true
			set.linebreak = true
			-- set.sidescoll = 5
			-- set.nolist = true
			--
			-- set.concealcursor = "nc"
		end,
	},
}
