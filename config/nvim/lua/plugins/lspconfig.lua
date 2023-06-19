return {
	{
		"neovim/nvim-lspconfig",
		init = function()
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = vim.g.border,
			})
		end,
		config = function()
			require("lspconfig").util.default_config.on_attach = function() end
		end,
		keys = {
			{
				"<leader>s",
				function()
					vim.lsp.buf.format({
						async = true,
						filter = function(client)
							return client.name ~= "tsserver"
						end,
					})
				end,
			},
			{ "K",          vim.lsp.buf.hover },
			{ "<leader>rn", vim.lsp.buf.rename },
			{ "<C-k>",      ":lua vim.diagnostic.open_float({ border = vim.g.border })<CR>" },
		},
	},
}
