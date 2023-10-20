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

                    builtins.formatting.prettierd,
                    builtins.formatting.xmlformat,

                    -- Tex
                    builtins.formatting.latexindent,
                    builtins.diagnostics.chktex,

                    -- Shell
                    builtins.formatting.shfmt,
                    builtins.diagnostics.shellcheck,

                    -- Python
                    builtins.diagnostics.pylint,
                    builtins.formatting.autopep8,

                    builtins.code_actions.eslint_d,
                    builtins.code_actions.refactoring,

                    -- Markdown
                    -- builtins.formatting.markdownlint,
                    builtins.diagnostics.markdownlint,

                    -- C++
                    -- builtins.diagnostics.clang_check.with({
                    -- 	extra_args = { "-extra-arg=-std=c++17" },
                    -- }),
                    builtins.diagnostics.cpplint.with({
                        args = { "--linelength=120" }, -- ROS
                    }),
                    builtins.diagnostics.cppcheck.with({
                        extra_args = { "--language=c++", "--std=c++17" },
                    }),
                    builtins.formatting.clang_format,
                },
            })
        end,
    },
}
