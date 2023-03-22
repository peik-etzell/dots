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
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
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

require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

local dap = require("dap")
-- ADAPTERS --------------------------------------------------------------------------------------
-- dap.adapters.python = {
-- 	type = 'executable',
-- 	command = '/usr/bin/python', -- os.getenv('HOME') .. '/.virtualenvs/tools/bin/python';
-- 	args = { '-m', 'debugpy.adapter' },
-- }

dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode",
	name = "lldb",
}

dap.adapters.cppdbg = {
	id = "cppdbg",
	name = "cppdbg",
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
}
dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js" },
}

dap.adapters.firefox = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/dev/vscode-firefox-debug/dist/adapter.bundle.js" },
}

-- CONFIGURATIONS ---------------------------------------------------------------------------------

local firefox = {
	name = "Debug with Firefox",
	type = "firefox",
	request = "launch",
	reAttach = true,
	sourceMaps = true,
	url = "http://localhost:3000",
	webRoot = "${workspaceFolder}",
	firefoxExecutable = "/usr/bin/firefox",
}

local node2 = {
	name = "Launch node",
	type = "node2",
	request = "launch",
	program = "${file}",
	cwd = vim.fn.getcwd(),
	sourceMaps = true,
	protocol = "inspector",
	console = "integratedTerminal",
}

local lldb = {
	name = "Launch lldb",
	type = "lldb",
	request = "launch",
	program = function()
		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	end,
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
	args = {},

	-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
	--
	--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
	--
	-- Otherwise you might get the following error:
	--
	--    Error on launch: Failed to attach to the target process
	--
	-- But you should be aware of the implications:
	-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
	runInTerminal = false,
}

local cpptools = {
	name = "Launch cpptools",
	type = "cppdbg",
	request = "launch",
	program = function()
		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	end,
	cwd = "${workspaceFolder}",
	stopOnEntry = true,
}

local gdbserver = {
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
}

local node_attach = {
	-- For this to work you need to make sure the node process is started with the `--inspect` flag.
	name = "Attach to node process",
	type = "node2",
	request = "attach",
	processId = require("dap.utils").pick_process,
}

-- local python_dbg = {
-- 	{
-- 		-- The first three options are required by nvim-dap
-- 		type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
-- 		request = 'launch';
-- 		name = "Launch file";
--
-- 		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
--
-- 		program = "${file}"; -- This configuration will launch the current file if used.
-- 		pythonPath = function()
-- 			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
-- 			-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
-- 			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
-- 			local cwd = vim.fn.getcwd()
-- 			if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
-- 				return cwd .. '/venv/bin/python'
-- 			elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
-- 				return cwd .. '/.venv/bin/python'
-- 			else
-- 				return '/usr/bin/python'
-- 			end
-- 		end;
-- 	},
-- }

dap.configurations.cpp = { lldb, cpptools, gdbserver }
dap.configurations.c = { lldb, cpptools, gdbserver }
dap.configurations.rust = { lldb, cpptools, gdbserver }

dap.configurations.javascript = { firefox, node2, node_attach }
dap.configurations.javascriptreact = {
	firefox,
	node2,
	node_attach,
}

dap.configurations.typescript = { firefox, node2, node_attach }
dap.configurations.typescriptreact = {
	firefox,
	node2,
	node_attach,
}

-- dap.configurations.python = { python_dbg }
