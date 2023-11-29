return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            {
                'folke/neodev.nvim',
                opts = {},
                config = function()
                    require('neodev').setup({})
                end,
            },
            { 'p00f/clangd_extensions.nvim', ft = { 'cpp', 'c' } },
            {
                'simrat39/rust-tools.nvim',
                dependencies = { 'nvim-lua/plenary.nvim' },
                opts = {},
            },
        },
        lazy = false,
        config = function()
            vim.diagnostic.config({ virtual_text = false })
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

            local servers = {
                'typst_lsp',
                -- 'pylsp',
                'pyright',
                'yamlls',
                'texlab',
                'openscad_lsp',
                'cmake',
                'dockerls',
                'docker_compose_language_service',
                'rnix',
                'tsserver',
                'jsonls',
                'cssls',
                'html',
                'zls',
            }
            vim.g.zig_fmt_autosave = 0
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
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = 'Replace',
                        },
                    },
                },
            })
            lspconfig.bashls.setup({
                capabilities = default_capabilities,
                filetypes = { 'sh', 'zsh', 'bash' },
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
                return { 'OmniSharp' }
            end
            lspconfig.omnisharp.setup({
                capabilities = default_capabilities,
                cmd = omnisharp_cmd(),
            })
        end,
    },
}
