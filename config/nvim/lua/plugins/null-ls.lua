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
					builtins.formatting.clang_format.with({
						-- extra_args = { "--style", "{IndentWidth: 4}" },
					}),
					builtins.formatting.uncrustify,
					builtins.formatting.prettierd,
					builtins.code_actions.eslint_d,
					builtins.code_actions.refactoring,
					-- builtins.diagnostics.clang_check,
					-- builtins.diagnostics.cpplint,
					-- builtins.diagnostics.cppcheck,
					-- builtins.diagnostics.eslint,
					-- builtins.completion.spell,
					-- builtins.code_actions.proselint,
				},
			})
		end,
	},
}
