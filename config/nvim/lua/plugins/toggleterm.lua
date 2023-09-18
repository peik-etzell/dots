return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = true,
        keys = {
            {
                "<A-CR>",
                function()
                    require("toggleterm").toggle()
                end,
                mode = { "n", "i", "t" },
            },
        },
    },
}
