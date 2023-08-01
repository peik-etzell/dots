return {
    {
        "terrortylor/nvim-comment",
        config = function()
            require("nvim_comment").setup()
        end,
        keys = {
            { "<leader>/", ":CommentToggle<CR>", mode = "n" },
            { "<leader>/", ":CommentToggle<CR>", mode = "v" },
        },
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
}
