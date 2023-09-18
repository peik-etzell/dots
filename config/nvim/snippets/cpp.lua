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
    s({
        dscr = "Main function boilerplate",
        trig = "int main()",
    }, {
        t({ "int main(int argc, char** argv) {", "\t" }),
        i(1),
        t({ "", "\treturn 0;", "}" }),
    }),
}
