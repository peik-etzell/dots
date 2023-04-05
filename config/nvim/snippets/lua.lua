return {
	s({ trig = "leader" }, {
		t("<leader>"),
	}),
	s({ trig = "cr" }, {
		t("<CR>"),
	}),
	s({ trig = "<" }, {
		t("<"),
		i(1),
		t(">"),
	}),
	s({ trig = "c-" }, {
		t("<C-"),
		i(1),
		t(">"),
	}),
}
