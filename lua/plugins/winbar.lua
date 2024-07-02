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
        errors = " %#LspDiagnosticsSignError# " .. count["errors"]
    end
    if count["warnings"] ~= 0 then
        warnings = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
    end
    if count["hints"] ~= 0 then
        hints = " %#LspDiagnosticsSignHint# " .. count["hints"]
    end
    if count["info"] ~= 0 then
        info = " %#LspDiagnosticsSignInformation#󰌵 " .. count["info"]
    end

    return errors .. warnings .. hints .. info .. "%#Normal#"
end

-- TODO find better icon
-- This can be replaced by a built-in feature?
local function modifiedIndicator()
    if vim.bo.modified == true then
        return "[+]"
    else
        return ""
    end
end

local function winbarDisabled()
    return vim.bo.filetype == "neo-tree"
end

function _G.WinBar()
    local icon = devicons.get_icon(vim.fn.expand("%"), vim.fn.expand("%:e"))
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

-- Change winbar highlight groups?

vim.api.nvim_create_autocmd("BufWinEnter", {
    callback = function ()
        -- check if winbar should be disabled for buffer
        if winbarDisabled() then
            vim.opt_local.winbar = nil
        else
            vim.opt_local.winbar = "%{%v:lua.WinBar()%}"
        end
    end
})
