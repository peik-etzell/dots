return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			local builtins = null_ls.builtins
			null_ls.setup({
				sources = {
					builtins.formatting.stylua,
					-- builtins.formatting.clang_format.with({
					-- 	-- extra_args = { "--style", "{IndentWidth: 4}" },
					-- }),
					builtins.formatting.prettierd,
					builtins.formatting.xmlformat,
					builtins.formatting.clang_format,
					builtins.code_actions.eslint_d,
					builtins.code_actions.refactoring,
					builtins.diagnostics.clang_check,
					builtins.diagnostics.cpplint.with({
						args = { "--linelength=120" }, -- ROS
					}),
					builtins.diagnostics.cppcheck.with({
						extra_args = { "--language=c++", "--std=c++17" },
					}),
					-- builtins.diagnostics.eslint,
					-- builtins.completion.spell,
					-- builtins.code_actions.proselint,
				},
			})
		end,
	},
}
