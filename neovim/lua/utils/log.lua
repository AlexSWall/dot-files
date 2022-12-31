local M = {}

function M._echo_multiline(msg)
	for _, s in ipairs(vim.fn.split(msg, "\n")) do
		vim.cmd("echom '" .. s:gsub("'", "''") .. "'")
	end
end

function M.info(msg)
	vim.cmd("echohl Directory")
	M._echo_multiline(msg)
	vim.cmd("echohl None")
end

function M.warn(msg)
	vim.cmd("echohl WarningMsg")
	M._echo_multiline(msg)
	vim.cmd("echohl None")
end

function M.err(msg)
	vim.cmd("echohl ErrorMsg")
	M._echo_multiline(msg)
	vim.cmd("echohl None")
end

return M
