local set_keymap = vim.api.nvim_set_keymap

local esc = "<ESC>"
local termesc = "<C-\\><C-n>"

-- Bind esc to same function in terminal
set_keymap("t", esc, termesc, {})
-- Set movement keymaps
local movement_keys = { "h", "j", "k", "l" }
for _, key in pairs(movement_keys) do
	local lhs = "<A-" .. key .. ">"
	local rhs = "<C-w>" .. key
	local opts = {}
	set_keymap("n", lhs, rhs, opts)
	set_keymap("i", lhs, esc .. rhs, opts)
	set_keymap("t", lhs, termesc .. rhs, opts)
end

-- vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", {})
set_keymap("n", "<A-S-q>", ":q<CR>", {})
set_keymap("t", "<A-S-q>", termesc .. ":q<CR>", {})

-- Increase vertical size
set_keymap("n", "<A-C-k>", ":resize +3<CR>", {})
set_keymap("t", "<A-C-k>", termesc .. ":resize +3<CR>i", {})
-- Decrease vertical size
set_keymap("n", "<A-C-j>", ":resize -3<CR>", {})
set_keymap("t", "<A-C-j>", termesc .. ":resize -3<CR>i", {})
-- Increase horizontal size
set_keymap("n", "<A-C-l>", "3<C-w>>", {})
set_keymap("t", "<A-C-l>", termesc .. "3<C-w>>i", {})
-- Decrease horizontal size
set_keymap("n", "<A-C-h>", "3<C-w><", {})
set_keymap("t", "<A-C-h>", termesc .. "3<C-w><i", {})

set_keymap("n", "<C-u>", "<C-u>zz", {})
set_keymap("n", "<C-d>", "<C-d>zz", {})

set_keymap("n", "<Up>", "kzz", {})
set_keymap("n", "<Down>", "jzz", {})

-- Resize nvim splits when whole window resizes
vim.api.nvim_create_autocmd({ "VimResized" }, { pattern = { "*" }, command = "wincmd =" })
