vim.g.do_filetype_lua = 1
vim.filetype.add({
	extension = {
		rviz = "yaml",
	},
})

vim.g.mapleader = " "
-- Advised by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {
	ui = { border = "rounded" },
	change_detection = { notify = false },
})

vim.filetype.add({
	extension = {
		scad = "openscad",
	},
})

local esc = "<ESC>"
local termesc = "<C-\\><C-n>"
-- Bind esc to same function in terminal
vim.api.nvim_set_keymap("t", esc, termesc, {})
-- Set movement keymaps
local movement_keys = { "h", "j", "k", "l" }
for _, key in pairs(movement_keys) do
	local lhs = "<A-" .. key .. ">"
	local rhs = "<C-w>" .. key
	local opts = {}
	vim.api.nvim_set_keymap("n", lhs, rhs, opts)
	vim.api.nvim_set_keymap("i", lhs, esc .. rhs, opts)
	vim.api.nvim_set_keymap("t", lhs, termesc .. rhs, opts)
end

vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", {})

-- Resize nvim splits when whole window resizes
vim.api.nvim_create_autocmd({ "VimResized" }, { pattern = { "*" }, command = "wincmd =" })

local set = vim.opt
local let = vim.g

set.number = true
set.relativenumber = false
set.tabstop = 4
set.shiftwidth = 4
set.expandtab = false
set.timeoutlen = 500
set.undofile = true
set.wrap = false -- Overridden in ft=tex
set.list = true
set.listchars:append("eol:↴")

-- Spell
set.spelllang = "en_us"
set.spell = true
-- Exclude terminal from spellchecking
vim.api.nvim_create_autocmd({ "TermOpen" }, { pattern = { "*" }, command = "setlocal nospell" })

-- suckless.vim
let.suckless_tmap = 1

-- folding
set.foldlevel = 99
set.foldmethod = "expr"
set.foldexpr = "nvim_treesitter#foldexpr()"
vim.cmd([[
highlight Folded guibg=black guifg=lightgreen
]])

set.updatetime = 300
set.clipboard = "unnamedplus"
