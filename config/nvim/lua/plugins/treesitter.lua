return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            autotag = {
                enable = true,
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                disable = { "latex", "tex" },
            },
            indent = {
                enable = true,
                disable = { "typescript", "c", "cpp" },
            },
            context_commentstring = { enable = true, enable_autocmd = false },
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "cuda",
                "vimdoc",
                "html",
                "json",
                "jsonc",
                "latex",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "rust",
                "scala",
                "tsx",
                "typescript",
                "vim",
                "yaml",
                "gitcommit",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = "<nop>",
                    node_decremental = "<bs>",
                },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
        dependencies = {
            "windwp/nvim-ts-autotag",
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = true,
        config = function()
            require("treesitter-context").setup({
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
                trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                patterns = {
                    -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
                    -- For all filetypes
                    -- Note that setting an entry here replaces all other patterns for this entry.
                    -- By setting the 'default' entry below, you can control which nodes you want to
                    -- appear in the context window.
                    default = {
                        "class",
                        "function",
                        "method",
                        "for",
                        "while",
                        "if",
                        "switch",
                        "case",
                    },
                    -- Patterns for specific filetypes
                    -- If a pattern is missing, *open a PR* so everyone can benefit.
                    tex = {
                        "chapter",
                        "section",
                        "subsection",
                        "subsubsection",
                    },
                    rust = {
                        "impl_item",
                        "struct",
                        "enum",
                    },
                    scala = {
                        "object_definition",
                    },
                    vhdl = {
                        "process_statement",
                        "architecture_body",
                        "entity_declaration",
                    },
                    markdown = {
                        "section",
                    },
                    elixir = {
                        "anonymous_function",
                        "arguments",
                        "block",
                        "do_block",
                        "list",
                        "map",
                        "tuple",
                        "quoted_content",
                    },
                    json = {
                        "pair",
                    },
                    yaml = {
                        "block_mapping_pair",
                    },
                },
                exact_patterns = {
                    -- Example for a specific filetype with Lua patterns
                    -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
                    -- exactly match "impl_item" only)
                    -- rust = true,
                },
                -- [!] The options below are exposed but shouldn't require your attention,
                --     you can safely ignore them.

                zindex = 20, -- The Z-index of the context window
                mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
            })
        end,
    },
}
