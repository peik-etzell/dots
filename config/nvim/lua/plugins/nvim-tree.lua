return {
    {
        "nvim-tree/nvim-tree.lua",
        init = function()
            require("nvim-tree").setup({
                update_focused_file = {
                    enable = true,
                },
                renderer = {
                    add_trailing = true,
                    group_empty = true,
                    icons = {
                        git_placement = "after",
                        modified_placement = "after",
                    },
                },
                actions = {
                    open_file = {
                        resize_window = false,
                    },
                },
            })
            local opts = { silent = true }
            vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", opts)         -- Buffer-local binds
            vim.keymap.set("n", "<leader><esc>", ":NvimTreeToggle<CR>", opts) -- Buffer-local binds
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
}
