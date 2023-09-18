return {
    {

        "epwalsh/obsidian.nvim",
        lazy = true,
        event = { "BufReadPre " .. vim.fn.expand("~") .. "/Obsidian/**.md" },
        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",

            -- see below for full list of optional dependencies 👇
        },
        opts = {
            dir = "~/Obsidian", -- no need to call 'vim.fn.expand' here

            -- see below for full list of options 👇
            completion = {
                nvim_cmp = true,
            },
            mappings = {},
        },
    },
}
