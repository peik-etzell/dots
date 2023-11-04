return {
    {
        'projekt0n/github-nvim-theme',
        branch = '0.0.x',
        priority = 1000,
    },
    { 'ellisonleao/gruvbox.nvim', priority = 1000 },
    { 'catppuccin/nvim', priority = 1000 },
    {
        'nvim-tree/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup({
                color_icons = true,
                -- override_by_filename = { ["gitignore"] = { icon = " ", color = "#f1502f", name = "Gitignore" } },
            })
        end,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        enabled = false,
        config = function()
            require('indent_blankline').setup({
                show_current_context = true,
                show_current_context_start = true,
            })
        end,
    },
    {
        'lewis6991/gitsigns.nvim',
        init = function()
            require('gitsigns').setup()
        end,
    },
    {
        'peik-etzell/persist-theme.nvim',
        config = function()
            require('persist-theme').setup({
                default_colorscheme = 'catppuccin',
            })
        end,
    },
}
