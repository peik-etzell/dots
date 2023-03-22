local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

plugins = {
	"nvim-tree/nvim-web-devicons",
	-- Themes
	{ "ellisonleao/gruvbox.nvim", enabled = false },
	{ "catppuccin/nvim", enabled = false },
	"projekt0n/github-nvim-theme",
	-- Statusline
	"nvim-lualine/lualine.nvim",
	{
		"lewis6991/gitsigns.nvim",
		init = function()
			require("gitsigns").setup()
		end,
	},
	{ "lukas-reineke/indent-blankline.nvim" },
	-- file tree
	{
		"nvim-tree/nvim-tree.lua",
		lazy = true,
		init = function()
			require("nvim-tree").setup()
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	"terrortylor/nvim-comment",
	{ "lervag/vimtex", ft = "tex" },
	-- Autocomplete
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			{
				"saadparwaiz1/cmp_luasnip",
				dependencies = {
					{
						"L3MON4D3/LuaSnip",
						-- install jsregexp (optional!).
						build = "make install_jsregexp",
					},
				},
			},
		},
	},

	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				-- enable_check_bracket_line = true,
				-- ignored_next_char = '[%w%.]' -- will ignore alphanumeric and '.' symbol
			})
		end,
	},
	"Pocco81/auto-save.nvim",
	"fabi1cazenave/suckless.vim",
	"fabi1cazenave/termopen.vim",
	-- fzf-lua
	{ "junegunn/fzf", enabled = false },
	{
		"ibhagwan/fzf-lua",
		enabled = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	-- treesitter
	{ "nvim-treesitter/nvim-treesitter" },
	{ "nvim-treesitter/nvim-treesitter-context", lazy = true },
	{ "windwp/nvim-ts-autotag", lazy = true },
	-- lsp stuff
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim", lazy = true },
	{ "williamboman/mason-lspconfig.nvim", lazy = true },
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "p00f/clangd_extensions.nvim", ft = { "c", "cpp" }, lazy = true },
	-- c++ extensions
	{
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
		lazy = true,
	},
	-- Rust
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		lazy = true,
		dependencies = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
	},
	-- Scala
	-- Not set up
	{
		"scalameta/nvim-metals",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = "scala",
		lazy = true,
	},
	-- Debugging
	{ "mfussenegger/nvim-dap", lazy = true },
	{ "rcarriga/nvim-dap-ui", lazy = true, dependencies = { "mfussenegger/nvim-dap" } },
	{ "mfussenegger/nvim-dap-python", lazy = true },

	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup({
				virtual_lines = { only_current_line = true },
			})
		end,
	},
	{
		"alexghergh/nvim-tmux-navigation",
		lazy = true,
		config = function()
			require("nvim-tmux-navigation").setup({
				disable_when_zoomed = true, -- defaults to false
				keybindings = {
					left = "<C-h>",
					down = "<C-j>",
					up = "<C-k>",
					right = "<C-l>",
					last_active = "<C-\\>",
					next = "<C-Space>",
				},
			})
		end,
	},
}

require("lazy").setup(plugins, opts)
