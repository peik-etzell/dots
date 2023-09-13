return {
    {
        "rcarriga/nvim-dap-ui",
        lazy = true,
        dependencies = {
            {
                "mfussenegger/nvim-dap",
                config = function()
                    local dap = require("dap")
                    local adapters = dap.adapters
                    local configurations = dap.configurations


                    -- ADAPTERS
                    adapters.lldb = {
                        type = "executable",
                        command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/codelldb",
                        name = "lldb",
                    }
                    adapters.cppdbg = {
                        id = "cppdbg",
                        name = "cppdbg",
                        type = "executable",
                        command = vim.fn.stdpath("data")
                            .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
                    }
                    -- C#
                    adapters.coreclr = {
                        type = "executable",
                        command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg",
                        args = { "--interpreter=vscode" },
                    }

                    -- CONFIGURATIONS
                    local lldbConfig = {
                        name = "Launch lldb",
                        type = "lldb",
                        request = "launch",
                        program = function()
                            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                        end,
                        cwd = "${workspaceFolder}",
                        stopOnEntry = false,
                        args = {},
                    }
                    local cpptoolsConfig = {
                        name = "Launch cpptools",
                        type = "cppdbg",
                        request = "launch",
                        program = function()
                            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                        end,
                        cwd = "${workspaceFolder}",
                        stopOnEntry = true,
                        setupCommands = {
                            {
                                text = "-enable-pretty-printing",
                                description = "enable pretty printing",
                                ignoreFailures = false,
                            },
                        },
                    }
                    local gdbserverConfig = {
                        name = "Attach to gdbserver :1234",
                        type = "cppdbg",
                        request = "launch",
                        MIMode = "gdb",
                        miDebuggerServerAddress = "localhost:1234",
                        miDebuggerPath = "/usr/bin/gdb",
                        cwd = "${workspaceFolder}",
                        program = function()
                            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                        end,
                        setupCommands = {
                            {
                                text = "-enable-pretty-printing",
                                description = "enable pretty printing",
                                ignoreFailures = false,
                            },
                        },
                    }
                    configurations.cpp = { cpptoolsConfig, gdbserverConfig }
                    configurations.c = { cpptoolsConfig, gdbserverConfig }
                    configurations.rust = { cpptoolsConfig, gdbserverConfig }
                    configurations.cs = {
                        {
                            type = "coreclr",
                            name = "Launch netcoredbg",
                            request = "launch",
                            program = function()
                                return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
                            end,
                        },
                    }
                end,
            },
            { "mfussenegger/nvim-dap-python", lazy = true },
        },
        config = function()
            require("dapui").setup({
                icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
                mappings = {
                    -- Use a table to apply multiple mappings
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                    toggle = "t",
                },
                -- Use this to override mappings for specific elements
                element_mappings = {
                    -- Example:
                    -- stacks = {
                    --   open = "<CR>",
                    --   expand = "o",
                    -- }
                },
                -- Expand lines larger than the window
                -- Requires >= 0.7
                expand_lines = vim.fn.has("nvim-0.7") == 1,
                -- Layouts define sections of the screen to place windows.
                -- The position can be "left", "right", "top" or "bottom".
                -- The size specifies the height/width depending on position. It can be an Int
                -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
                -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
                -- Elements are the elements shown in the layout (in order).
                -- Layouts are opened in order so that earlier layouts take priority in window sizing.
                layouts = {
                    {
                        elements = {
                            -- Elements can be strings or table with id and size keys.
                            { id = "scopes", size = 0.25 },
                            "breakpoints",
                            "stacks",
                            "watches",
                        },
                        size = 40, -- 40 columns
                        position = "left",
                    },
                    {
                        elements = {
                            "repl",
                            "console",
                        },
                        size = 0.25, -- 25% of total lines
                        position = "bottom",
                    },
                },
                controls = {
                    -- Requires Neovim nightly (or 0.8 when released)
                    enabled = true,
                    -- Display controls in this element
                    element = "repl",
                    icons = {
                        pause = "",
                        play = "",
                        step_into = "",
                        step_over = "",
                        step_out = "",
                        step_back = "",
                        run_last = "↻",
                        terminate = "□",
                    },
                },
                floating = {
                    max_height = nil,      -- These can be integers or a float between 0 and 1.
                    max_width = nil,       -- Floats will be treated as percentage of your screen.
                    border = vim.g.border, -- Border style. Can be "single", "double" or "rounded"
                    mappings = {
                        close = { "q", "<Esc>" },
                    },
                },
                windows = { indent = 1 },
                render = {
                    max_type_length = nil, -- Can be integer or nil.
                    max_value_lines = 100, -- Can be integer or nil.
                },
            })
        end,
        keys = {
            { "<F4>",      ":lua require('dapui').toggle()<CR>",          desc = "Toggle UI" },
            { "<F5>",      ":lua require('dap').continue()<CR>",          desc = "Continue" },
            { "<F9>",      ":lua require('dap').toggle_breakpoint()<CR>", desc = "Toggle breakpoint " },
            { "<F10>",     ":lua require('dap').step_over()<CR>",         desc = "Step over" },
            { "<F11>",     ":lua require('dap').step_into()<CR>",         desc = "Step into" },
            { "<S-<F11>>", ":lua require('dap').step_out()<CR>",          desc = "Step out" },
        },
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()
            require("nvim-dap-virtual-text").setup {
                -- enable this plugin (the default)
                enabled = true,
                -- create commands
                -- DapVirtualTextEnable,
                -- DapVirtualTextDisable,
                -- DapVirtualTextToggle,
                -- (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
                enabled_commands = true,
                -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
                highlight_changed_variables = true,
                -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
                highlight_new_as_changed = false,
                -- show stop reason when stopped for exceptions
                show_stop_reason = true,
                -- prefix virtual text with comment string
                commented = false,
                -- only show virtual text at first definition (if there are multiple)
                only_first_definition = true,
                -- show virtual text on all all references of the variable (not only definitions)
                all_references = false,
                -- clear virtual text on "continue" (might cause flickering when stepping)
                clear_on_continue = false,
                --- A callback that determines how a variable is displayed or whether it should be omitted
                --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
                --- @param buf number
                --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
                --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
                --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
                --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
                display_callback = function(variable, buf, stackframe, node, options)
                    if options.virt_text_pos == 'inline' then
                        return ' = ' .. variable.value
                    else
                        return variable.name .. ' = ' .. variable.value
                    end
                end,
                -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text.
                -- Use 'eol' to set to end of line
                virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

                -- experimental features:
                --
                -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
                all_frames = false,
                -- show virtual lines instead of virtual text (will flicker!)
                virt_lines = false,
                -- position the virtual text at a fixed window column (starting from the first text column) ,
                virt_text_win_col = nil
                -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
            }
        end
    },
    {
        'LiadOz/nvim-dap-repl-highlights',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()
            require('nvim-dap-repl-highlights').setup()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { 'dap_repl' },
            }
        end

    }
}
