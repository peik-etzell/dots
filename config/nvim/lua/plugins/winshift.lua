return {
    {
        'sindrets/winshift.nvim',
        lazy = false,
        opts = { keymaps = { disable_defaults = true } },
        config = function()
            local function map_s_alt(key, dir)
                vim.keymap.set(
                    { 'i', 'n', 't' },
                    '<S-A-' .. key .. '>',
                    function()
                        require('winshift').cmd_winshift(dir)
                    end,
                    { silent = true }
                )
            end
            map_s_alt('h', 'left')
            map_s_alt('j', 'down')
            map_s_alt('k', 'up')
            map_s_alt('l', 'right')
        end,
    },
}
