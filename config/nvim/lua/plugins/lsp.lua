return {
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'hrsh7th/cmp-nvim-lsp' },
        lazy = false,
        config = function()
            vim.lsp.handlers['textDocument/hover'] =
                vim.lsp.with(vim.lsp.handlers.hover, {
                    border = vim.g.border,
                })
            require('lspconfig.ui.windows').default_options.border =
                vim.g.border
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP on_attach',
                callback = function(event)
                    local client =
                        vim.lsp.get_client_by_id(event.data.client_id)
                    if
                        vim.fn.has('nvim-0.10') == 1
                        and client.server_capabilities.inlayHintProvider
                    then
                        vim.lsp.inlay_hint(event.buf, true)
                    end

                    local set_keymap = function(lhs, rhs)
                        vim.keymap.set(
                            'n',
                            lhs,
                            rhs,
                            { silent = true, buffer = event.buf }
                        )
                    end
                    set_keymap('K', vim.lsp.buf.hover)
                    set_keymap('<leader>rn', vim.lsp.buf.rename)
                    set_keymap('<C-k>', function()
                        vim.diagnostic.open_float({ border = vim.g.border })
                    end)

                    if
                        client.server_capabilities.documentFormattingProvider
                    then
                        set_keymap('<leader>s', function()
                            vim.lsp.buf.format({
                                async = true,
                                filter = function(server)
                                    return server.name ~= 'lua_ls'
                                end,
                            })
                        end)
                    else
                        set_keymap('<leader>s', 'gg=G')
                    end
                end,
            })

            if not vim.g.use_mason then
                local servers = {
                    'typst_lsp',
                    'pylsp',
                    'yamlls',
                    'texlab',
                    'openscad_lsp',
                }
                local lspconfig = require('lspconfig')
                local default_capabilities =
                    require('cmp_nvim_lsp').default_capabilities()
                for _, server in ipairs(servers) do
                    lspconfig[server].setup({
                        capabilities = default_capabilities,
                    })
                end
                lspconfig.lua_ls.setup({
                    capabilities = default_capabilities,
                })
                lspconfig.bashls.setup({
                    capabilities = default_capabilities,
                })
                lspconfig.clangd.setup({
                    capabilities = vim.tbl_extend(
                        'force',
                        default_capabilities,
                        { offsetEncoding = 'utf-8' }
                    ),
                    filetypes = { 'cpp', 'c', 'cuda', 'objcpp', 'objc' },
                })
                local function omnisharp_cmd()
                    if vim.g.use_mason then
                        return {
                            'dotnet',
                            vim.fn.stdpath('data')
                                .. '/mason/packages/omnisharp/libexec/OmniSharp.dll',
                        }
                    else
                        return { 'OmniSharp' }
                    end
                end
                lspconfig.omnisharp.setup({
                    capabilities = default_capabilities,
                    cmd = omnisharp_cmd(),
                })
            end
        end,
    },
    {
        'williamboman/mason.nvim',
        enabled = vim.g.use_mason,
        lazy = true,
        config = function()
            require('mason').setup({
                install_root_dir = vim.fn.stdpath('data') .. '/mason',
                ui = {
                    border = vim.g.border,
                },
            })
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        enabled = vim.g.use_mason,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'neovim/nvim-lspconfig',
            'p00f/clangd_extensions.nvim',
        },
        config = function()
            local default_capabilities =
                require('cmp_nvim_lsp').default_capabilities()
            require('mason-lspconfig').setup_handlers({
                function(server_name)
                    require('lspconfig')[server_name].setup({
                        capabilities = default_capabilities,
                    })
                end,
                ['clangd'] = function()
                    require('lspconfig').clangd.setup({
                        capabilities = vim.tbl_extend(
                            'force',
                            default_capabilities,
                            { offsetEncoding = 'utf-8' }
                        ),
                        filetypes = { 'cpp', 'c', 'cuda', 'objcpp', 'objc' }, -- everything except .proto
                    })
                end,
                ['omnisharp'] = function()
                    require('lspconfig').omnisharp.setup({
                        capabilities = default_capabilities,
                        cmd = {
                            'dotnet',
                            vim.fn.stdpath('data')
                                .. '/mason/packages/omnisharp/libexec/OmniSharp.dll',
                        },
                    })
                end,
            })
        end,
    },
}
