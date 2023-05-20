return {
	{
		"williamboman/mason.nvim",
		lazy = true,
		config = function()
			require("mason").setup({
				install_root_dir = vim.fn.stdpath("data") .. "/mason",
				ui = {
					border = "rounded",
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
					"pylsp",
					"pyright",
					"jsonls",
					"lua_ls",
					"marksman",
					"bashls",
					"docker_compose_language_service",
					"dockerls",
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
	-- {
	-- 	"WhoIsSethDaniel/mason-tool-installer.nvim",
	-- 	dependencies = {
	-- 		"williamboman/mason.nvim",
	-- 	},
	-- 	config = function()
	-- 		require("mason-tool-installer").setup({
	-- 			ensure_installed = {
	-- 				-- Lua
	-- 				"lua-language-server",
	-- 				"stylua",
	-- 				"luacheck",
	--
	-- 				-- sh
	-- 				"shellcheck",
	-- 				"shfmt",
	-- 				"beautysh",
	--
	-- 				"editorconfig-checker",
	-- 				"staticcheck",
	-- 				"autopep8",
	-- 				"lemminx", -- xmlformatter
	--
	-- 				-- C++
	-- 				"clang-format",
	-- 				"cpplint",
	-- 				"cpptools",
	-- 				"codelldb",
	-- 				"cmake-language-server",
	-- 			},
	--
	-- 			run_on_start = true,
	--
	-- 			start_delay = 3000, -- 3 second delay
	--
	-- 			debounce_hours = 5, -- at least 5 hours between attempts to install/update
	-- 		})
	-- 	end,
	-- },
}
