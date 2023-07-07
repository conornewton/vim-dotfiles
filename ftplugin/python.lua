function getCellBoundaries(buf)
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
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
	local cells = getCellBoundaries(0)

	for i = 1, #cells - 1 do
		if current_line >= cells[i] and current_line < cells[i + 1] then
			vim.api.nvim_win_set_cursor(0, { cells[i + 1], 0 })
		end
	end
end

-- Need to do this differently beacuse cells gives the line number of the beginning of each cell
function gotoPrevCell()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local cells = getCellBoundaries(0)
	table.insert(cells, vim.api.nvim_buf_line_count(0) + 1)

	for i = 2, #cells - 1 do
		if current_line >= cells[i] and current_line < cells[i + 1] then
			vim.api.nvim_win_set_cursor(0, { cells[i - 1], 0 })
		end
	end
end

function getCellLines()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local cells = getCellBoundaries(0)
	table.insert(cells, vim.api.nvim_buf_line_count(0) + 1)

	for i = 1, #cells - 1 do
		if current_line >= cells[i] and current_line < cells[i + 1] then
			return vim.api.nvim_buf_get_lines(0, cells[i], cells[i + 1] - 1, false), cells[i]
		end
	end
end

function JupyterStart()
	vim.fn.jobstart("python -m jupyter qtconsole &> /dev/null &")
	--wait until jupyter is open...
	--what is the better way of doing this???
	vim.wait(1000)
	vim.api.nvim_command("JupyterConnect")
end

Jy = {
	jobid = nil,
	pybufid = nil,
	bufid = nil,
	winid = nil,
	-- Used for printing output
	codebufid = nil,
	codeline = nil,
}

local ns = vim.api.nvim_create_namespace("jy")

function Jy:Buffer()
	self.bufid = vim.api.nvim_create_buf(true, true)
end

function Jy:Jupyter()
	Jy:Buffer() -- Open buffer
	-- Write all output to a buffer?
	self.jobid = vim.fn.jobstart("python -m jupyter console --simple-prompt", {
		on_stdout = function(_, data)
			vim.api.nvim_buf_set_lines(self.bufid, -1, -1, false, data)
			if self.codebufid and self.codeline then
				-- TODO: make this be removed properly
				vim.api.nvim_buf_set_extmark(
					self.codebufid,
					ns,
					self.codeline - 1,
					0,
					{ virt_text = { data }, sign_text = "✓", hl_group = "Comment" }
				)
				self.codebufid = nil
				self.codeline = nil
			end
		end,
		on_stderr = function(_, data)
			print("Error: " .. data)
		end,
	})
	vim.notify("Jupyter Launched")
end

function Jy:ShowOutput()
	vim.cmd("vsplit")
	self.winid = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(self.winid, self.bufid)
end

function Jy:HideOutput()
	vim.api.nvim_win_close(self.winid)
end

-- Don't let this be run twice at once...
function Jy:SendLines()
	local line = vim.api.nvim_get_current_line()
	self.codebufid = vim.api.nvim_get_current_buf()
	self.codeline = vim.api.nvim_win_get_cursor(0)[1]

	if self.jobid ~= nil then
		vim.api.nvim_chan_send(self.jobid, line .. "\n")
	end
end

function Jy:SendCell()
	local lines, cellline = getCellLines()

	self.codebufid = vim.api.nvim_get_current_buf()
	self.codeline = cellline

	if self.jobid ~= nil then
		vim.api.nvim_chan_send(self.jobid, table.concat(lines, "\n"))
	end
end

function Jy:Close()
	vim.fn.jobstop(self.jobid)
	vim.api.nvim_buf_delete(self.bufid, {})
end

-- Render a markdown cell
function Jy:MarkdownCell() end

-- Render an image
function Jy:ImageCell() end

function Jy:Interactive()
	self.pybufid = vim.api.nvim_get_current_buf()
	-- Create Buffer to output cells to
	self.bufid = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_buf_set_name(self.bufid, "Interactive Python")
	vim.api.nvim_buf_set_option(self.bufid, "buftype", "nofile")

	-- Open split to show ouput
	vim.cmd("vsplit")
	self.winid = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(self.winid, self.bufid)
	vim.api.nvim_win_set_option(self.winid, "number", false)

	-- Update interactive window cells on save
	-- vim.api.nvim_create_autocmd()
	Jy:InteractiveDrawCells()
	vim.api.nvim_create_autocmd("BufWritePost", {
		callback = function()
			Jy:InteractiveDrawCells()
		end,
	})
end

function Jy:InteractiveDrawCells()
	vim.api.nvim_buf_set_lines(self.bufid, 0, -1, false, {}) -- Do i need to do this?
	vim.api.nvim_buf_clear_namespace(self.bufid, ns, 0, -1)

	local cells = getCellBoundaries(self.pybufid)
	table.insert(cells, vim.api.nvim_buf_line_count(0) + 1)
	for i = 1, #cells - 1 do
		local lines = vim.api.nvim_buf_get_lines(self.pybufid, cells[i], cells[i + 1] - 1, false)
		vim.api.nvim_buf_set_lines(self.bufid, -1, -1, false, { "[" .. i .. "]" })

		-- Make this size of the buffer
		vim.api.nvim_buf_set_lines(
			self.bufid,
			-1,
			-1,
			false,
			{ "------------------------------------------------------------------------------" }
		)
		vim.api.nvim_buf_set_lines(self.bufid, -1, -1, false, lines) -- Strip whitespace?
		vim.api.nvim_buf_set_lines(
			self.bufid,
			-1,
			-1,
			false,
			{ "------------------------------------------------------------------------------" }
		)
	end
end

vim.api.nvim_create_user_command("PythonInteractive", "lua Jy:Interactive()", {})

-- Jy:Jupyter()
-- vim.api.nvim_set_keymap("n", "\\r", "lua Jy:SendLines()", {})

-- TODO:
-- Cache cell content. Including, output, lines, input...
-- Highlight python code. Do i need to create a syntax file to do this?

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
	command! OpenJupyter  lua JupyterStart()
]])

vim.cmd([[
	nnoremap ]s <cmd>GotoNextCell <cr>zz
	nnoremap [s <cmd>GotoPrevCell <cr>zz
]])

-- TODO:
-- How to switch conda environment inside neovim
-- Is this to do with the environment more generally?
-- How to send code to jupyter console..
--
-- How does vscode extension do this??
-- -- How does it get output?
