return {
    {
        'projekt0n/github-nvim-theme',
        branch = '0.0.x',
    },
    {
        'EdenEast/nightfox.nvim',
        opts = {
            groups = {
                all = {
                    -- Some examples, make sure only to define Conceal once
                    -- Conceal = { link = 'Comment' }, -- link `Conceal` to another highlight group
                    Conceal = { fg = 'syntax.number' }, -- link `Conceal` to a spec value
                },
            },
        },
    },
    { 'ellisonleao/gruvbox.nvim' },
    { 'catppuccin/nvim' },
    { 'nvim-tree/nvim-web-devicons', opts = { color_icons = true } },
    { 'lewis6991/gitsigns.nvim', opts = {} },
    {
        'peik-etzell/persist-theme.nvim',
        opts = { default_colorscheme = 'catppuccin' },
    },
}
