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
--
local open = io.open

local function dump_file(filename)
	local file = io.open(filename, "r")
	return file:read("*a")
end

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
		t({ "\\begin{theorem}", "\t" }),
		i(1),
		t({ "", "\\end{theorem}" }),
	}),
	s("cor", {
		t({ "\\begin{corollary}", "\t" }),
		i(1),
		t({ "", "\\end{corollary}" }),
	}),
	s("lem", {
		t({ "\\begin{lemma}", "\t" }),
		i(1),
		t({ "", "\\end{lemma}" }),
	}),
	s("thm", {
		t({ "\\begin{thm}", "\t" }),
		i(1),
		t({ "", "\\end{thm}" }),
	}),
	s("prop", {
		t({ "\\begin{prop}", "\t" }),
		i(1),
		t({ "", "\\end{prop}" }),
	}),
	s("defn", {
		t({ "\\begin{defn}", "\t" }),
		i(1),
		t({ "", "\\end{defn}" }),
	}),
	s("ex", {
		t({ "\\begin{ex}", "\t" }),
		i(1),
		t({ "", "\\end{ex}" }),
	}),
	s("eq", {
		t({ "\\begin{equation}", "\t" }),
		i(1),
		t({ "", "\\end{equation}" }),
	}),
	s("eqs", {
		t({ "\\begin{equation*}", "\t" }),
		i(1),
		t({ "", "\\end{equation*}" }),
	}),
	s("prf", {
		t({ "\\begin{proof}", "\t" }),
		i(1),
		t({ "", "\\end{proof}" }),
	}),
	s("ass", {
		t({ "\\begin{assumption}", "\t" }),
		i(1),
		t({ "", "\\end{assumption}" }),
	}),
	s("it", {
		t({ "\\begin{itemize}", "\t\\item " }),
		i(1),
		t({ "", "\\end{itemize}" }),
	}),
	s("enum", {
		t({ "\\begin{enumerate}", "\t\\item " }),
		i(1),
		t({ "", "\\end{enumerate}" }),
	}),
	s("env", {
		t("\\begin{"),
		i(1),
		t({ "}", "\t" }),
		i(0),
		t({ "", "\\end{" }),
		rep(1),
		t("}"),
	}),
	s("s", {
		t("\\{"),
		i(1),
		t("\\}"),
		i(0),
	}),
	s("algo", {
		t({ "\\begin{algorithm}[h]", "\\SetAlgoLined", "\\caption{" }),
		i(1),
		t({ "}", "" }),
		t("\\label{alg:"),
		i(2),
		t({ "}", "" }),
		i(3),
		t({ "", "\\end{algorithm}" }),
		i(0),
	}),
	s("img", {
		t({ "\\begin{figure}[h]", "\\centering", "\\caption{" }),
		i(1),
		t({ "}", "" }),
		t("\\label{fig:"),
		i(2),
		t({ "}", "" }),
		t("\\caption{"),
		i(3),
		t({ "}", "" }),
		t("\\includegraphics[width=\\textwidth]{"),
		i(4),
		t({ "}", "" }),
		i(5),
		t({ "", "\\end{figure}" }),
		i(0),
	}),
	-- s("fr", fmt("\\frac{{ }}{{ }}{ }", { i(1), i(2), i(0) })),
	s("ve", t({ "\\varepsilon" })),
	s("ep", t({ "\\epsilon" })),
	s("fr", { t("\\frac{"), i(1), t("}"), t("{"), i(2), t("}"), i(0) }),

	-- Load snippet from file
	s("templates/header", t(vim.split(dump_file("/home/cn15588/.config/nvim/snippets/templates/latex"), "\n"))),
}
