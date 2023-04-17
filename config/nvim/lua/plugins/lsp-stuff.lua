return {
	{
		"hrsh7th/nvim-cmp",
		config = function()
			-- Make runtime files discoverable to the server.
			local runtime_path = vim.split(package.path, ";")
			table.insert(runtime_path, "lua/?.lua")
			table.insert(runtime_path, "lua/?/init.lua")

			-- Set completeopt to have a better completion experience.
			vim.o.completeopt = "menuone,noselect"

			local luasnip = require("luasnip")
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<Tab>"] = cmp.mapping.confirm({ cmp.ConfirmBehavior.Replace, select = true }),
					["<C-l>"] = cmp.mapping(function()
						if luasnip.jumpable(1) then
							luasnip.jump(1)
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					-- { name = "cmdline" },
				}),
			})
		end,
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			{
				"saadparwaiz1/cmp_luasnip",
				dependencies = {
					{
						"L3MON4D3/LuaSnip",
						-- install jsregexp (optional!).
						build = (not jit.os:find("Windows"))
								and "echo -e 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
							or nil,
						config = function()
							require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets/" })
						end,
						keys = {
							{ "<Tab>", "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", "i" },
							{ "<C-l>", ':lua require("luasnip").jump(1)<CR>', "s" },
							{ "<C-h>", ':lua require("luasnip").jump(-1)<CR>', "s" },
						},
					},
				},
			},
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
								extra_args = { "--style", "{IndentWidth: 4}" },
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
			{
				"williamboman/mason.nvim",
				lazy = true,
				config = function()
					require("mason").setup({
						install_root_dir = vim.fn.stdpath("data") .. "/mason",
					})
				end,
			},
			{
				"williamboman/mason-lspconfig.nvim",
				lazy = true,
				dependencies = {
					"hrsh7th/cmp-nvim-lsp",
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
							{ "gD", vim.lsp.buf.declaration },
							{ "gd", vim.lsp.buf.definition },
							{ "gi", vim.lsp.buf.implementation },
							{ "<leader>rn", vim.lsp.buf.rename },
							{ "<leader>rr", vim.lsp.buf.references },
							{ "<C-k>", ':lua vim.diagnostic.open_float({ border = "rounded" })<CR>' },
						},
					},
				},
				init = function()
					require("mason-lspconfig").setup({
						automatic_installation = true,
					})
					require("mason-lspconfig").setup_handlers({
						function(server_name)
							require("lspconfig")[server_name].setup({
								capabilities = require("cmp_nvim_lsp").default_capabilities(),
							})
						end,
					})
				end,
			},
		},
	},
	{ "p00f/clangd_extensions.nvim", ft = { "c", "cpp" }, lazy = true },
	{
		"scalameta/nvim-metals",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = "scala",
		lazy = true,
	},
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		config = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		lazy = true,
		dependencies = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
	},
}
