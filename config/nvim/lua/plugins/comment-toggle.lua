return {
    {
        "terrortylor/nvim-comment",
        lazy = false,
        config = function()
            require("nvim_comment").setup()
            vim.keymap.set({ 'n', 'v' }, '<leader>/', function ()
                vim.cmd([[CommentToggle]])
            end, { silent = true })
        end,
    },
}
