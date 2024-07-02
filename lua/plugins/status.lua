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

local function nofile()
    return vim.bo.buftype == "nofile"
end

local function componentMode()
    return table.concat({
        "%#Statusline#",
        update_mode_colors(),
        mode(),
        "%#StatusLine#",
    })
end

local function componentGit()
    return table.concat({
        " ",
        git_branch(),
        " ",
        "%{get(b:,'gitsigns_status','')}",
    })
end

local function componentFilepath()
    return table.concat({
        " %f"
    })
end

local function componentLspInfo()

end

local function componentVirtualEnvironment()

end

function _G.StatusLine()
    local status_line_components = {}

    table.insert(status_line_components, componentMode())

    if isGit() then
        table.insert(status_line_components, componentGit())
    end

    if not nofile() then
        table.insert(status_line_components, componentFilepath())
    end

    return table.concat(status_line_components)
end

--TODO: global diagnostics in statusline
--TODO: colourscheme stuff
--TODO: have a build a component function.

vim.api.nvim_set_hl(0, "StatuslineInsertAccent", { fg = "Black", bg = "White" })
vim.api.nvim_set_hl(0, "StatuslineVisualAccent", { fg = "Black", bg = "Orange" })
vim.api.nvim_set_hl(0, "StatuslineCmdLineAccent", { fg = "Black", bg = "Green" })

vim.opt.laststatus = 3 --global status line
vim.opt.statusline = "%{%v:lua.StatusLine()%}"
