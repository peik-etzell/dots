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
			local cmp_buffer = require("cmp_buffer")

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
				sorting = {
					comparators = {
						function(...)
							return cmp_buffer:compare_locality(...)
						end,
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.recently_used,
						require("clangd_extensions.cmp_scores"),
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				window = {
					completion = cmp.config.window.bordered(),
				},
			})

			-- `/` cmdline setup.
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- `:` cmdline setup.
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"jose-elias-alvarez/null-ls.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"p00f/clangd_extensions.nvim",
		},
	},
}
