vim.g.do_filetype_lua = 1
vim.filetype.add({
	extension = {
		repos = "yaml",
		rviz = "yaml",
		scad = "openscad",
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
set.title = true

-- Spell
set.spelllang = "en_us"
set.spell = false
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

require("window-management")
