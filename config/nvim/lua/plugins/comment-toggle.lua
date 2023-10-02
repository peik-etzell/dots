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
            local autopairs = require("nvim-autopairs")
            autopairs.setup()
            local rule = require("nvim-autopairs.rule")
            local tex = { 'tex', 'latex' }
            autopairs.add_rules({
                rule('$$', '$$', tex),
                rule('$', '$', tex),
                rule('\\[', '\\]', tex),
                rule('\\(', '\\)', tex)
            })
        end,
    },
}
