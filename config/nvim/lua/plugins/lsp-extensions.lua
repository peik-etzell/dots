return {
	{
		"p00f/clangd_extensions.nvim",
		ft = { "c", "cpp" },
		lazy = true,
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
