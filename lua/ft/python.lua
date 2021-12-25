local M = {}

function M.getCellBoundaries()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local b = {}

	for i, line in ipairs(lines) do
		if line == "# %%" then
			table.insert(b, i)
		end
	end

	return b
end

function M.gotoNextCell()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local cells = M.getCellBoundaries()

	for i = 1, #cells - 1 do
		if current_line >= cells[i] and current_line < cells[i + 1] then
			vim.api.nvim_win_set_cursor(0, { cells[i + 1], 0 })
		end
	end
end

-- Need to do this differently beacuse cells gives the line number of the beginning of each cell
function M.gotoPrevCell()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local cells = M.getCellBoundaries()
	table.insert(cells, vim.api.nvim_buf_line_count(0) + 1)

	for i = 2, #cells - 1 do
		if current_line >= cells[i] and current_line < cells[i + 1] then
			vim.api.nvim_win_set_cursor(0, { cells[i - 1], 0 })
		end
	end
end
return M
