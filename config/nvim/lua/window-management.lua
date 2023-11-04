local set_keymap = vim.keymap.set

local esc = '<ESC>'
local termesc = '<C-\\><C-n>'
local opts = { silent = true }

-- Set movement keymaps
local movement_keys = { 'h', 'j', 'k', 'l' }
for _, key in pairs(movement_keys) do
    local lhs = '<A-' .. key .. '>'
    local rhs = '<C-w>' .. key
    set_keymap('n', lhs, rhs, opts)
    set_keymap('i', lhs, esc .. rhs, opts)
    set_keymap('t', lhs, termesc .. rhs, opts)
end

set_keymap('n', '<A-S-q>', ':q<CR>', opts)
set_keymap('t', '<A-S-q>', termesc .. ':q<CR>', opts)

-- Increase vertical size
set_keymap('n', '<A-C-k>', ':resize +3<CR>', opts)
set_keymap('t', '<A-C-k>', termesc .. ':resize +3<CR>i', opts)
-- Decrease vertical size
set_keymap('n', '<A-C-j>', ':resize -3<CR>', opts)
set_keymap('t', '<A-C-j>', termesc .. ':resize -3<CR>i', opts)
-- Increase horizontal size
set_keymap('n', '<A-C-l>', '3<C-w>>', opts)
set_keymap('t', '<A-C-l>', termesc .. '3<C-w>>i', opts)
-- Decrease horizontal size
set_keymap('n', '<A-C-h>', '3<C-w><', opts)
set_keymap('t', '<A-C-h>', termesc .. '3<C-w><i', opts)

set_keymap('n', '<C-u>', '<C-u>zz', opts)
set_keymap('n', '<C-d>', '<C-d>zz', opts)

set_keymap('n', '<Up>', 'kzz', opts)
set_keymap('n', '<Down>', 'jzz', opts)

-- Resize nvim splits when whole window resizes
vim.api.nvim_create_autocmd(
    { 'VimResized' },
    { pattern = { '*' }, command = 'wincmd =' }
)
