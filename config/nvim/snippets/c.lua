return {
    s({
        dscr = "Autosnippet to expand to multiline comment",
        trig = "///",
        snippetType = "autosnippet",
    }, {
        t({ "/**", " * " }),
        i(1),
        t({ "", " */" }),
    }),
}
