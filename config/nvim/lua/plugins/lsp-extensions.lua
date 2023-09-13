return {
    {
        "scalameta/nvim-metals",
        dependencies = { "nvim-lua/plenary.nvim" },
        ft = "scala",
        lazy = true,
    },
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        lazy = true,
        dependencies = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
    },
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
            vim.diagnostic.config({
                virtual_text = false,
            })
        end,
        ft = { "rust" },
    },
}
