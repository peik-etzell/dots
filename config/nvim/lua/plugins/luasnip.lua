return {
	{
		"saadparwaiz1/cmp_luasnip",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				-- install jsregexp (optional!).
				build = (not jit.os:find("Windows"))
						and "echo -e 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
					or nil,
				config = function()
					require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets/" })
				end,
				keys = {
					{ "<Tab>", "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", "i" },
					{ "<C-l>", ':lua require("luasnip").jump(1)<CR>', "s" },
					{ "<C-h>", ':lua require("luasnip").jump(-1)<CR>', "s" },
				},
			},
		},
	},
}
