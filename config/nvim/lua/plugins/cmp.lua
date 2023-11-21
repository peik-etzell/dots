return {
    {
        'hrsh7th/nvim-cmp',
        config = function()
            -- Make runtime files discoverable to the server.
            local runtime_path = vim.split(package.path, ';')
            table.insert(runtime_path, 'lua/?.lua')
            table.insert(runtime_path, 'lua/?/init.lua')

            -- Set completeopt to have a better completion experience.
            vim.o.completeopt = 'menuone,noselect'

            local luasnip = require('luasnip')
            local cmp = require('cmp')

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<Tab>'] = cmp.mapping.confirm({
                        cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    ['<C-l>'] = cmp.mapping(function()
                        if luasnip.jumpable(1) then
                            luasnip.jump(1)
                        end
                    end, { 'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function()
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'nvim_lsp_signature_help' },
                    -- { name = "cmdline" },
                }),
                sorting = {
                    comparators = {
                        function(...)
                            return require('cmp_buffer'):compare_locality(...)
                        end,
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.recently_used,
                        require('clangd_extensions.cmp_scores'),
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                window = {
                    completion = { border = vim.g.border },
                    documentation = { border = vim.g.border },
                },
                formatting = {
                    format = require('lspkind').cmp_format({
                        mode = 'symbol',
                    }),
                },
            })

            -- `/` cmdline setup.
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' },
                },
            })

            -- `:` cmdline setup.
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                }, {
                    { name = 'cmdline' },
                }),
            })

            -- cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
            --      sources = {
            --          { name = "dap" },
            --      },
            --  })
        end,
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'jose-elias-alvarez/null-ls.nvim',
            'p00f/clangd_extensions.nvim',
            -- "rcarriga/cmp-dap",
            'onsails/lspkind.nvim', -- symbols
            {
                'saadparwaiz1/cmp_luasnip',
                dependencies = {
                    {
                        'L3MON4D3/LuaSnip',
                        build = (not jit.os:find('Windows'))
                                and "echo -e 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
                            or nil,
                        config = function()
                            require('luasnip').config.set_config({
                                enable_autosnippets = true,
                            })
                            require('luasnip.loaders.from_lua').lazy_load({
                                paths = '~/.config/nvim/snippets/',
                            })
                        end,
                    },
                },
            },
        },
    },
}
