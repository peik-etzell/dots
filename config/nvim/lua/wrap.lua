-- Use wrap on files
local pattern = { '*.md', '*.tex', '*.txt' }

-- Turn on wrap and modify movement binds when entering a prose-based file
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = pattern,
    callback = function(_)
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        for _, key in pairs({ 'j', 'k', '$', '0' }) do
            vim.keymap.set(
                { 'n', 'v' },
                key,
                'g' .. key,
                { silent = true, buffer = true }
            )
        end
    end,
})
