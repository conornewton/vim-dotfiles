local modes = {
	["n"] = "NORMAL",
	["no"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "VISUAL LINE",
	["s"] = "SELECT",
	["S"] = "SELECT LINE",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "VISUAL REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MOAR",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
	--Fix these modes
	-- [""] = "V·B",
	-- [""] = "S·B",
}

local function update_mode_colors()
	local current_mode = vim.api.nvim_get_mode().mode
	local mode_color = "%#StatusLineAccent#"
	if current_mode == "n" then
		mode_color = "%#StatuslineAccent#"
	elseif current_mode == "i" or current_mode == "ic" then
		mode_color = "%#StatuslineInsertAccent#"
	elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
		mode_color = "%#StatuslineVisualAccent#"
	elseif current_mode == "R" then
		mode_color = "%#StatuslineReplaceAccent#"
	elseif current_mode == "c" then
		mode_color = "%#StatuslineCmdLineAccent#"
	elseif current_mode == "t" then
		mode_color = "%#StatuslineTerminalAccent#"
	end
	return mode_color
end

local function mode()
	local current_mode = vim.api.nvim_get_mode().mode
	return string.format(" %s ", modes[current_mode]):upper()
end

local function isGit()
	return vim.fn.systemlist("git rev-parse --is-inside-work-tree")[1] == "true"
end

-- TODO disable git information
local function git_branch()
	-- local git = require("nvim-web-devicons").get_icon("branch")
	return " " .. vim.fn.systemlist("git branch --show-current")[1]
end

function _G.StatusLine()
	if isGit() then
		return table.concat({
			"%#Statusline#",
			update_mode_colors(),
			mode(),
			"%#StatusLine#",
			" ",
			git_branch(),
			" ",
			"%{get(b:,'gitsigns_status','')}",
			" %f",
		})
	else
		return table.concat({
			"%#Statusline#",
			update_mode_colors(),
			mode(),
			"%#StatusLine#",
			" ",
			" %f",
		})
	end
end

--TODO: global diagnostics in statusline
--TODO: colourscheme stuff
--TODO: have a build a component function.

vim.api.nvim_set_hl(0, "StatuslineInsertAccent", { fg = "Black", bg = "White" })
vim.api.nvim_set_hl(0, "StatuslineVisualAccent", { fg = "Black", bg = "Orange" })
vim.api.nvim_set_hl(0, "StatuslineCmdLineAccent", { fg = "Black", bg = "Green" })

vim.opt.laststatus = 3
vim.opt.statusline = "%{%v:lua.StatusLine()%}"
