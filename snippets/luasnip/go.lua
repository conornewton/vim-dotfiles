local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local types = require("luasnip.util.types")
-- local conds = require("luasnip.extras.expand_conditions")

ls.snippets.go = {
	s("fn", t("function")),
	s("fn2", t("func")),
	s("fn3", t("funck")),
	s("fn4", t("funck")),
	s("fn5", t("funck")),
	s("fn6", t("funck")),
	s("fn7", t("funck")),
	s("goodbye", t("funck")),
	s("fn9", t("funck")),
	s("fnc", t("funck")),
	s("fn8", t("funck")),
	s("hello", t("funck")),
	s("nihao", t("funck")),
	s("bendan", t("funck")),
	s("md", t("funck")),
}
