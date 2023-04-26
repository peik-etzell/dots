return {
	"Pocco81/auto-save.nvim",
	-- "fabi1cazenave/suckless.vim",
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
