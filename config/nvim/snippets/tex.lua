return {
    -- inline math mode
    s({ trig = "\\(\\)" }, {
        t("\\("),
        i(1),
        t("\\)"),
    }),
    s({ trig = "\\[\\]" }, {
        t("\\["),
        i(1),
        t("\\]"),
    }),
}
