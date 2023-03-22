require('keymaps')

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<F3>",
	":w<cr> :call system('/bin/openscad ' . expand('%:p') . ' 2> /dev/null &')<cr>",
	{
		noremap = true,
		silent = true,
	}
)

-- vim.api.nvim_create_autocmd(
-- 	{ "BufRead", "BufWritePre" },
-- 	{ pattern = { "*" }, command = "gg=G" }
-- )
