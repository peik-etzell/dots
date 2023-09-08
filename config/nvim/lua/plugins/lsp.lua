return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = vim.g.border,
			})
			require("lspconfig.ui.windows").default_options.border = vim.g.border
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP on_attach",
				callback = function(event)
					local set_keymap = function(lhs, rhs)
						vim.keymap.set("n", lhs, rhs, { silent = true, buffer = event.buf })
					end
					set_keymap("K", vim.lsp.buf.hover)
					set_keymap("<leader>rn", vim.lsp.buf.rename)
					set_keymap("<C-k>", function()
						vim.diagnostic.open_float({ border = vim.g.border })
					end)
					set_keymap("<leader>s", function()
						vim.lsp.buf.format({ async = true })
					end)
				end,
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		lazy = true,
		config = function()
			require("mason").setup({
				install_root_dir = vim.fn.stdpath("data") .. "/mason",
				ui = {
					border = vim.g.border,
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
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					local setup = require("lspconfig")[server_name].setup
					local capabilities = require("cmp_nvim_lsp").default_capabilities()
					if server_name ~= "clangd" then
						setup({
							capabilities = capabilities,
						})
					end
				end,
			})
		end,
	},
}
