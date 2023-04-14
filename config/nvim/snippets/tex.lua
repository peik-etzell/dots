return {
	-- inline math mode
	s({ trig = "\\math" }, {
		t("\\("),
		i(1),
		t("\\)"),
	}),
	s({
		trig = "\\emph",
	}, {
		t("\\emph{"),
		i(1),
		t("}"),
	}),
	s({ trig = "ie" }, {
		t("i.e."),
	}),
	s({ trig = "beg" }, {
		t("\\begin{"),
		i(1),
		t("}"),
		i(2),
		t("\\end{"),
		f(function(args)
			return args[1]
		end, ai[1]),
		t("}"),
	}),
}
