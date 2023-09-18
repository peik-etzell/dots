return {
    s({ trig = "<leader>" }, {
        t("<leader>"),
    }),
    s({ trig = "<CR>" }, {
        t("<CR>"),
    }),
    s({ trig = "<>" }, {
        t("<"),
        i(1),
        t(">"),
    }),
    s({ trig = "<C-?>" }, {
        t("<C-"),
        i(1),
        t(">"),
    }),
}
