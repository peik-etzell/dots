return {
    {
        'windwp/nvim-autopairs',
        event = 'VeryLazy',
        config = function()
            local autopairs = require('nvim-autopairs')
            autopairs.setup()
            local rule = require('nvim-autopairs.rule')
            local tex = { 'tex', 'latex' }
            autopairs.add_rules({
                rule('$', '$', tex),
                rule('\\[', '\\]', tex),
                rule('\\(', '\\)', tex),
            })
        end,
    },
}
