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
					builtins.formatting.prettierd,
					builtins.formatting.xmlformat,
					builtins.formatting.clang_format,
					builtins.formatting.latexindent,
					builtins.code_actions.eslint_d,
					builtins.code_actions.refactoring,
					-- builtins.diagnostics.clang_check.with({
					-- 	extra_args = { "-extra-arg=-std=c++17" },
					-- }),
					builtins.diagnostics.cpplint.with({
						args = { "--linelength=120" }, -- ROS
					}),
					builtins.diagnostics.cppcheck.with({
						extra_args = { "--language=c++", "--std=c++17" },
					}),
				},
			})
		end,
	},
}
