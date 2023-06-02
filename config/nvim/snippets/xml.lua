return {
	s({
		trig = "</>",
		dscr = "XML Self-closing Element",
	}, {
		t("<"),
		i(1),
		t("/>"),
	}),
	s({
		trig = "<></>",
		dscr = "XML Element",
	}, {
		t("<"),
		i(1),
		t(">"),
		i(2),
		t("</"),
		f(function(args)
			return args[1]
		end, ai[1]),
		t(">"),
	}),
}
