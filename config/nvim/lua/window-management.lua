local set_keymap = vim.keymap.set
local opts = { silent = true }

local function move(key)
    return function()
        vim.cmd.wincmd(key)
    end
end
set_keymap({ 'n', 't', 'i' }, '<A-h>', move('h'), opts)
set_keymap({ 'n', 't', 'i' }, '<A-j>', move('j'), opts)
set_keymap({ 'n', 't', 'i' }, '<A-k>', move('k'), opts)
set_keymap({ 'n', 't', 'i' }, '<A-l>', move('l'), opts)

set_keymap({ 'n', 't' }, '<A-S-q>', vim.cmd.quit, opts)

local function resize(amount, vertical)
    return function()
        vim.cmd.resize({ amount, mods = { vertical = vertical } })
    end
end
set_keymap({ 'n', 't' }, '<A-C-h>', resize('-3', true), opts)
set_keymap({ 'n', 't' }, '<A-C-j>', resize('-1', false), opts)
set_keymap({ 'n', 't' }, '<A-C-k>', resize('+1', false), opts)
set_keymap({ 'n', 't' }, '<A-C-l>', resize('+3', true), opts)

set_keymap('n', '<C-u>', '<C-u>zz', opts)
set_keymap('n', '<C-d>', '<C-d>zz', opts)

set_keymap('n', '<Up>', 'kzz', opts)
set_keymap('n', '<Down>', 'jzz', opts)

-- Resize nvim splits when whole window resizes
vim.api.nvim_create_autocmd({ 'VimResized' }, {
    pattern = { '*' },
    callback = function()
        vim.cmd.wincmd('=')
    end,
})
