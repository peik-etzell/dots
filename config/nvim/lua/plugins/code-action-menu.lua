return {
    {
        "weilbith/nvim-code-action-menu",
        cmd = "CodeActionMenu",
        lazy = true,
        keys = {
            { "<C-.>", ":CodeActionMenu<CR>" },
        },
        config = function()
            vim.g.code_action_menu_window_border = vim.g.border
        end,
    },
}
