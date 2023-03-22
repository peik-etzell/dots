require("mason").setup({
	install_root_dir = vim.fn.stdpath("data") .. "/mason",
})

local map = vim.keymap
local buf = vim.lsp.buf
local bufopts = { noremap = true, silent = true }

map.set("n", "<leader>s", function()
	buf.format({
		async = true,
		filter = function(client)
			return client.name ~= "tsserver"
		end,
	})
end, bufopts)

map.set("n", "K", buf.hover, bufopts)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

map.set("n", "gD", buf.declaration, bufopts)
map.set("n", "gd", buf.definition, bufopts)
map.set("n", "gi", buf.implementation, bufopts)
map.set("n", "<leader>rn", buf.rename, bufopts)
map.set("n", "<leader>rr", buf.references, bufopts)

local on_attach = function(client, bufnr)
	local buf = vim.lsp.buf
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

local servers = {
	-- "clangd",
	-- "bashls",
	-- "cmake",
	-- "cssls",
	-- "graphql",
	-- "html",
	-- "jsonls",
	-- "texlab",
	-- "marksman",
	-- "pyright",
	-- "sqls",
	-- "tsserver",
	-- "pylsp",
	-- "lua_ls",
	-- "beancount",
	-- "beancount-language-server",
	-- "openscad-lsp",
}

require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,
	-- ["rust-analyzer"] = function()
	-- 	require("rust-tools").setup()
	-- end,
})

-- for _, lsp in ipairs(servers) do
-- 	lspconfig[lsp].setup({
-- 		on_attach = on_attach,
-- 		capabilities = capabilities,
-- 	})
-- end

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
		["<Tab>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
		-- { name = "cmdline" },
	}),
})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.clang_format.with({
			extra_args = { "--style", "{IndentWidth: 4}" },
		}),
		null_ls.builtins.formatting.uncrustify,
		-- null_ls.builtins.diagnostics.clang_check,
		-- null_ls.builtins.diagnostics.cpplint,
		-- null_ls.builtins.diagnostics.cppcheck,
		-- null_ls.builtins.diagnostics.eslint,
		-- null_ls.builtins.completion.spell,
		null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.formatting.prettierd,
		-- null_ls.builtins.code_actions.proselint,
		null_ls.builtins.code_actions.refactoring,
	},
})

-- require("clangd_extensions").setup({
-- 	server = {
-- 		on_attach = on_attach,
-- 		capabilities = capabilities,
-- 	},
-- })

local rt = require("rust-tools")
rt.setup({
	server = {
		on_attach = on_attach,
		-- on_attach = function(_, bufnr)
		-- 	-- Hover actions
		-- 	-- vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
		-- 	-- Code action groups
		-- 	-- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
		-- end,
	},
})

-- Error lines below code
require("lsp_lines").setup()
-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
	virtual_text = false,
})
