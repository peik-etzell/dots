return {
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            local builtins = null_ls.builtins
            null_ls.setup({
                sources = {
                    -- Lua
                    -- builtins.formatting.stylua,
                    builtins.diagnostics.luacheck,

                    -- JS/TS
                    builtins.formatting.prettierd,
                    builtins.code_actions.eslint_d,

                    -- XML
                    builtins.formatting.xmlformat,

                    -- Tex
                    builtins.formatting.latexindent,
                    builtins.diagnostics.chktex,

                    -- Shell
                    builtins.formatting.shfmt,
                    builtins.diagnostics.shellcheck,
                    builtins.code_actions.shellcheck,

                    -- Protobuf
                    builtins.diagnostics.buf,
                    builtins.formatting.buf,

                    -- Python
                    builtins.diagnostics.pylint,
                    builtins.formatting.autopep8,

                    builtins.code_actions.eslint_d,
                    builtins.code_actions.refactoring,
                    builtins.code_actions.gitsigns,
                    builtins.diagnostics.gitlint,
                    builtins.code_actions.proselint,
                    builtins.diagnostics.proselint,

                    -- Markdown
                    -- builtins.formatting.markdownlint,
                    builtins.diagnostics.markdownlint,

                    -- C/C++ / CMake / Make
                    -- builtins.diagnostics.clang_check,
                    builtins.diagnostics.cpplint.with({
                        args = { "--linelength=120" }, -- ROS
                    }),
                    builtins.diagnostics.cppcheck,
                    builtins.formatting.clang_format,
                    builtins.diagnostics.cmake_lint,
                    builtins.formatting.cmake_format,
                },
            })
        end,
    },
}
