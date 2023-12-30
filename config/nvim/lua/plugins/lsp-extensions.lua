return {
    {
        'scalameta/nvim-metals',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'hrsh7th/cmp-nvim-lsp',
        },
        ft = 'scala',
        lazy = true,
        config = function()
            local metals = require('metals')
            local config = metals.bare_config()
            config.settings = {}
            config.capabilities = require('cmp_nvim_lsp').default_capabilities()
            config.on_attach = function()
                metals.setup_dap()
            end
            local group =
                vim.api.nvim_create_augroup('nvim-metals', { clear = true })
            vim.api.nvim_create_autocmd('FileType', {
                pattern = { 'scala', 'sbt', 'java' },
                callback = function()
                    metals.initialize_or_attach(config)
                end,
                group = group,
            })
        end,
    },
    {
        'simrat39/rust-tools.nvim',
        ft = 'rust',
        lazy = true,
        dependencies = { 'neovim/nvim-lspconfig', 'nvim-lua/plenary.nvim' },
    },
    {
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        enabled = false,
        config = function()
            require('lsp_lines').setup()
            vim.diagnostic.config({
                virtual_text = false,
            })
        end,
        ft = { 'rust' },
    },
}
