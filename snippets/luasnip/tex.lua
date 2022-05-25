local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local types = require("luasnip.util.types")
-- local conds = require("luasnip.extras.expand_conditions")

local rec_ls
rec_ls = function()
	return sn(
		nil,
		c(1, {
			-- Order is important, sn(...) first would cause infinite loop of expansion.
			t(""),
			sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
		})
	)
end

ls.snippets.tex = {
	s("ls", {
		t({ "\\begin{itemize}", "\t\\item " }),
		i(1),
		d(2, rec_ls, {}),
		t({ "", "\\end{itemize}" }),
	}),
	s("al", {
		t({ "\\begin{align*}", "\t" }),
		i(1),
		t({ "", "\\end{align*}" }),
	}),
	s("thm", {
		t({ "\\begin{thm}", "\t" }),
		i(1),
		t({ "", "\\end{thm}" }),
	}),
	s("cor", {
		t({ "\\begin{cor}", "\t" }),
		i(1),
		t({ "", "\\end{cor}" }),
	}),
	s("lem", {
		t({ "\\begin{lemma}", "\t" }),
		i(1),
		t({ "", "\\end{lemma}" }),
	}),
	-- s("fr", fmt("\\frac{{ }}{{ }}{ }", { i(1), i(2), i(0) })),
	s("env", {
		t("\\begin{"),
		i(1),
		t({ "}", "\t" }),
		i(0),
		t({ "", "\\end{" }),
		rep(1),
		t("}"),
	}),
	-- s("sm", fmt("sum_{{ }}^{{ }}{}", { i(1), i(2), i(0) })),
}
