local modes = {'n', 't'}
local opts = { silent = true }
local function set_keymap(lhs, rhs)
   vim.keymap.set(modes, lhs, rhs, opts)
end

local function move(key)
    return function()
        vim.cmd.wincmd(key)
    end
end

set_keymap('<A-h>', move('h'))
set_keymap('<A-j>', move('j'))
set_keymap('<A-k>', move('k'))
set_keymap('<A-l>', move('l'))

set_keymap('<A-S-q>', vim.cmd.quit)

local function resize(amount, vertical)
    return function()
        vim.cmd.resize({ amount, mods = { vertical = vertical } })
    end
end
set_keymap('<A-C-h>', resize('-3', true))
set_keymap('<A-C-j>', resize('-1', false))
set_keymap('<A-C-k>', resize('+1', false))
set_keymap('<A-C-l>', resize('+3', true))

-- Resize nvim splits when whole window resizes
vim.api.nvim_create_autocmd({ 'VimResized' }, {
    pattern = { '*' },
    callback = function()
        vim.cmd.wincmd('=')
    end,
})
