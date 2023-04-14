return {
	-- Themes
	-- Statusline

	"Pocco81/auto-save.nvim",
	"fabi1cazenave/suckless.vim",
	{
		"fabi1cazenave/termopen.vim",
		keys = {
			{ "<C-CR>", ":call TermOpen()<CR>" },
		},
	},

	-- {
	-- 	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	-- 	config = function()
	-- 		require("lsp_lines").setup({
	-- 			virtual_lines = { only_current_line = true },
	-- 		})
	-- 	end,
	-- },
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
