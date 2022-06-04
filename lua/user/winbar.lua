local devicons = require("nvim-web-devicons")

--TODO: hide winbar for special windows.
local function lsp()
	local count = {}
	local levels = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	-- TODO fix here
	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count["errors"] ~= 0 then
		errors = " %#LspDiagnosticsSignError# " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = " %#LspDiagnosticsSignHint# " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = " %#LspDiagnosticsSignInformation# " .. count["info"]
	end

	return errors .. warnings .. hints .. info .. "%#Normal#"
end

-- TODO find better icon
local function modifiedIndicator()
	if vim.bo.modified == true then
		return "[+]"
	else
		return ""
	end
end

function _G.WinBar()
	local icon = devicons.get_icon(vim.fn.expand("%"), vim.fn.expand("%:e"))
	-- if vim.fn.expand("%") == "NvimTree_1" then
	-- 	return ""
	-- end
	if icon == nil then
		return "%f"
	end
	return table.concat({
		"   ",
		icon,
		" ",
		"%f ",
		modifiedIndicator(),
		lsp(),
	})
end

vim.opt.winbar = "%{%v:lua.WinBar()%}"
