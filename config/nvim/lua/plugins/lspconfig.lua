return {
	{
		"neovim/nvim-lspconfig",
		init = function()
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})
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
			{ "K", vim.lsp.buf.hover },
			{ "<leader>rn", vim.lsp.buf.rename },
			{ "<C-k>", ':lua vim.diagnostic.open_float({ border = "rounded" })<CR>' },
		},
	},
}
