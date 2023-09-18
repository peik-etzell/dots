return {
    {
        "sindrets/winshift.nvim",
        config = function()
            require("winshift").setup({
                keymaps = {
                    disable_defaults = true,
                },
            })
        end,
        keys = {
            { "<S-A-k>", ":WinShift up<CR>",               mode = { "n" } },
            { "<S-A-j>", ":WinShift down<CR>",             mode = { "n" } },
            { "<S-A-h>", ":WinShift left<CR>",             mode = { "n" } },
            { "<S-A-l>", ":WinShift right<CR>",            mode = { "n" } },
            { "<S-A-k>", "<C-\\><C-n>:WinShift up<CR>",    mode = { "t" } },
            { "<S-A-j>", "<C-\\><C-n>:WinShift down<CR>",  mode = { "t" } },
            { "<S-A-h>", "<C-\\><C-n>:WinShift left<CR>",  mode = { "t" } },
            { "<S-A-l>", "<C-\\><C-n>:WinShift right<CR>", mode = { "t" } },
        },
    },
}
