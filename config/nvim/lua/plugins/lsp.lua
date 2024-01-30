local function indent_pure_vim()
    local cursor_pos = vim.fn.getcurpos()
    vim.cmd.normal('gg=G')
    vim.fn.setpos('.', cursor_pos)
end

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
            {
                'https://git.sr.ht/~p00f/clangd_extensions.nvim',
                ft = { 'cpp', 'c' },
            },
            {
                'simrat39/rust-tools.nvim',
                dependencies = { 'nvim-lua/plenary.nvim' },
                opts = {},
            },
        },
        event = 'VeryLazy',
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

                    local function set_keymap(lhs, rhs)
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

                    set_keymap('<leader>s', function()
                        vim.lsp.buf.format({
                            async = true,
                            filter = function(server)
                                return server.name ~= 'lua_ls'
                                    and server.name ~= 'tsserver'
                            end,
                        })
                    end)
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
                'nil_ls',
                'tsserver',
                'jsonls',
                'cssls',
                'html',
                'marksman',
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
            vim.g.zig_fmt_autosave = 0
            lspconfig.zls.setup({
                capabilities = default_capabilities,
                settings = {
                    enable_autofix = false,
                    enable_build_on_save = true,
                },
            })

            lspconfig.denols.setup({
                capabilities = default_capabilities,
                root_dir = lspconfig.util.root_pattern(
                    'deno.json',
                    'deno.jsonc'
                ),
            })
            lspconfig.tsserver.setup({
                capabilities = default_capabilities,
                root_dir = lspconfig.util.root_pattern('package.json'),
                single_file_support = false,
            })
        end,
    },
}
