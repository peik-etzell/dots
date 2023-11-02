return {
    {
        "terrortylor/nvim-comment",
        lazy = false,
        config = function()
            require("nvim_comment").setup()
            vim.keymap.set({ 'n', 'v' }, '<leader>/', ":CommentToggle<CR>", { silent = true })
        end,
    },
}
