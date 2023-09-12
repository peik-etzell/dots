return {
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        init = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    -- C++ / CMake
                    "clangd",
                    "cpplint",
                    "cpptools",
                    "clang-format",
                    "cmake-language-server",
                    "cmakelint",
                    "cmakelang",

                    -- .sh
                    "bash-language-server",
                    "shellcheck",
                    "shfmt",

                    -- Lua
                    "lua-language-server",
                    "stylua",
                    "luacheck",

                    -- Typst
                    "typst-lsp",

                    -- C#
                    "omnisharp",
                    "netcoredbg",

                    -- Clojure
                    "clojure-lsp",

                    -- Python
                    "autopep8",
                    "python-lsp-server",
                    "debugpy",
                    "pylint",

                    -- Webdev
                    "css-lsp",
                    "html-lsp",
                    "json-lsp",
                    "typescript-language-server",

                    -- Docker
                    "docker-compose-language-service",
                    "dockerfile-language-server",

                    -- Yaml, XML
                    "yaml-language-server",
                    "yamlfmt",
                    "yamllint",
                    "lemminx",
                    -- "xmlformatter",

                    -- Rust
                    "rust-analyzer",

                    -- Misc
                    -- "editorconfig-checker",
                    -- "staticcheck",
                    "marksman",
                    "markdownlint",

                    -- Tex
                    "texlab",
                    "latexindent",
                },

                -- if set to true this will check each tool for updates. If updates
                -- are available the tool will be updated. This setting does not
                -- affect :MasonToolsUpdate or :MasonToolsInstall.
                -- Default: false
                auto_update = true,

                -- automatically install / update on startup. If set to false nothing
                -- will happen on startup. You can use :MasonToolsInstall or
                -- :MasonToolsUpdate to install tools and check for updates.
                -- Default: true
                run_on_start = true,

                -- set a delay (in ms) before the installation starts. This is only
                -- effective if run_on_start is set to true.
                -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
                -- Default: 0
                start_delay = 1000, -- 3 second delay

                -- Only attempt to install if 'debounce_hours' number of hours has
                -- elapsed since the last time Neovim was started. This stores a
                -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
                -- This is only relevant when you are using 'run_on_start'. It has no
                -- effect when running manually via ':MasonToolsInstall' etc....
                -- Default: nil
                debounce_hours = 5, -- at least 5 hours between attempts to install/update
            })
        end,
    },
}
