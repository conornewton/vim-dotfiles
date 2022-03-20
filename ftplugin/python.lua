function getCellBoundaries()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local b = {}

	for i, line in ipairs(lines) do
		if line == "# %%" then
			table.insert(b, i)
		end
	end

	return b
end

function gotoNextCell()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local cells = getCellBoundaries()

	for i = 1, #cells - 1 do
		if current_line >= cells[i] and current_line < cells[i + 1] then
			vim.api.nvim_win_set_cursor(0, { cells[i + 1], 0 })
		end
	end
end

-- Need to do this differently beacuse cells gives the line number of the beginning of each cell
function gotoPrevCell()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local cells = getCellBoundaries()
	table.insert(cells, vim.api.nvim_buf_line_count(0) + 1)

	for i = 2, #cells - 1 do
		if current_line >= cells[i] and current_line < cells[i + 1] then
			vim.api.nvim_win_set_cursor(0, { cells[i - 1], 0 })
		end
	end
end

vim.cmd([[
	" Run current file
	nnoremap <buffer> <silent> <localleader>R :JupyterRunFile<CR>
	nnoremap <buffer> <silent> <localleader>I :PythonImportThisFile<CR>

	" Change to directory of current file
	nnoremap <buffer> <silent> <localleader>d :JupyterCd %:p:h<CR>

	" Send a selection of lines
	nnoremap <buffer> <silent> <leader>r :JupyterSendCell<CR>
	nnoremap <buffer> <silent> <localleader>E :JupyterSendRange<CR>
	nmap     <buffer> <silent> <localleader>e <Plug>JupyterRunTextObj
	vmap     <buffer> <silent> <localleader>e <Plug>JupyterRunVisual

	" Debugging maps
	nnoremap <buffer> <silent> <localleader>b :PythonSetBreak<CR>
]])

vim.cmd([[
	command! GotoNextCell lua gotoNextCell()
	command! GotoPrevCell lua gotoPrevCell()
]])

vim.cmd([[
	nnoremap [s <cmd>GotoNextCell <cr>
	nnoremap ]s <cmd>GotoPrevCell <cr>
]])
