return {
	{
		"p00f/clangd_extensions.nvim",
		ft = { "c", "cpp" },
		lazy = true,
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.offsetEncoding = "utf-16"
			require("clangd_extensions").setup({
				server = {
					-- options to pass to nvim-lspconfig
					-- i.e. the arguments to require("lspconfig").clangd.setup({})
					capabilities = capabilities,
				},
				extensions = {
					autoSetHints = false,
					inlay_hints = {
						inline = false,
					},
				},
			})
		end,
	},
	{
		"scalameta/nvim-metals",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = "scala",
		lazy = true,
	},
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		lazy = true,
		dependencies = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
	},
}
