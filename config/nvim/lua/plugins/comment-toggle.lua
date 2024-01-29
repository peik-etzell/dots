return {
    {
        'terrortylor/nvim-comment',
        event = 'VeryLazy',
        config = function()
            require('nvim_comment').setup()
            vim.keymap.set(
                { 'n', 'v' },
                '<leader>/',
                ':CommentToggle<CR>',
                { silent = true }
            )
        end,
    },
}
