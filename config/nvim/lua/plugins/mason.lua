return {
	{
		"williamboman/mason.nvim",
		lazy = true,
		config = function()
			require("mason").setup({
				install_root_dir = vim.fn.stdpath("data") .. "/mason",
				ui = {
					border = "single",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {
					"clangd",
					"html",
					"yamlls",
					"cmake",
					"pylsp",
					"pyright",
					"jsonls",
					"stylua",
					"lua_ls",
				},
			})
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					if server_name ~= "clangd" then
						require("lspconfig")[server_name].setup({
							capabilities = require("cmp_nvim_lsp").default_capabilities(),
						})
					end
				end,
			})
		end,
	},
}
