require('keymaps')

vim.keymap.set(
    'n',
    '<F3>',
    ":w<cr> :call system('openscad ' . expand('%:p') . ' 2> /dev/null &')<cr>",
    { noremap = true, silent = true, buffer = true }
)
