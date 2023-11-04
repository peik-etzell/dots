return {
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        branch = '0.1.x',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            },
            {
                'nvim-telescope/telescope-dap.nvim',
                dependencies = {
                    'mfussenegger/nvim-dap',
                    'nvim-treesitter/nvim-treesitter',
                },
            },
        },
        init = function()
            require('telescope').setup({
                defaults = {
                    sorting_strategy = 'ascending',
                    scroll_strategy = 'limit',
                    layout_strategy = 'flex',
                    layout_config = {
                        prompt_position = 'top',
                        mirror = true,
                        anchor = 'N',
                        height = 0.90,
                        width = 0.95,
                        horizontal = {
                            preview_width = 0.5,
                        },
                    },
                    path_display = { 'truncate' },
                    file_ignore_patterns = {
                        -- latex
                        '%.ipe',
                        '%.eps',
                        '%.fls',
                        '%.fdb_latexmk',
                        '%.synctex.gz',
                        '%.aux',
                        -- ros
                        'build/',
                        'install/',
                        'log/',
                        'logs/',
                        'devel/',
                        -- clangd
                        'compile_commands',
                    },
                },
            })
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('dap')

            local function map(lhs, rhs, desc)
                vim.keymap.set('n', lhs, rhs, { silent = true, desc = desc })
            end

            local builtin = require('telescope.builtin')

            map('<leader>f', builtin.find_files, 'Fuzzy find files')
            map('<leader>c', builtin.colorscheme, 'Change colorscheme')
            map('<leader>g', function()
                builtin.live_grep({ layout_strategy = 'vertical' })
            end, 'Fuzzy find in files')
            map('<leader>lr', function()
                builtin.lsp_references()
            end, 'Lsp references')
            map('<leader>lk', function()
                builtin.diagnostics()
            end, 'Lsp diagnostics')
            map('<leader>li', function()
                builtin.lsp_implementations()
            end, 'Lsp implementations')
            map('<leader>ld', function()
                builtin.lsp_definitions()
            end, 'Lsp definitions')
            map('<C-/>', function()
                builtin.current_buffer_fuzzy_find({
                    layout_strategy = 'vertical',
                })
            end, 'Fuzzy find in current buffer')
            map('<leader>ta', function()
                builtin.builtin()
            end, 'Telescope builtins')
        end,
    },
}
