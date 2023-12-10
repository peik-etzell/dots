return {
    {
        'fladson/vim-kitty',
        event = 'BufEnter kitty.conf',
        config = function()
            vim.o.filetype = 'kitty'
        end,
    },
}
