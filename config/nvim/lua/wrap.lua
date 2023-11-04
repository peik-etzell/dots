-- Use wrap on files
local pattern = { '*.md', '*.tex', '*.txt' }

-- Turn on wrap and modify movement binds when entering a prose-based file
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = pattern,
    callback = function(_)
        vim.opt.wrap = true
        vim.opt.linebreak = true

        local set_keymap_n = function(lhs, rhs)
            vim.keymap.set('n', lhs, rhs, { silent = true, buffer = true }) -- Buffer-local binds
            vim.keymap.set('v', lhs, rhs, { silent = true, buffer = true }) -- Buffer-local binds
        end
        set_keymap_n('j', 'gj')
        set_keymap_n('k', 'gk')
        set_keymap_n('$', 'g$')
        set_keymap_n('0', 'g0')
    end,
})

-- Turn off wrap when leaving a prose-based file
vim.api.nvim_create_autocmd({ 'BufLeave' }, {
    pattern = pattern,
    callback = function(_)
        local set = vim.opt
        set.wrap = false
        set.linebreak = false
    end,
})
