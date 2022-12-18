M = {}

function M.setup()

	vim.g['test#strategy'] = 'neovim'

	local nmap = require('utils.keymap').nmap

	nmap('<Leader>tt', '<cmd>TestNearest<CR>', 'Run test nearest cursor')
	nmap('<Leader>tf', '<cmd>TestFile<CR>', 'Run tests for current file')
	nmap('<Leader>ts', '<cmd>TestSuite<CR>', 'Run test suite')
	nmap('<Leader>tl', '<cmd>TestLast<CR>', 'Run the last test run')
	nmap('<Leader>tv', '<cmd>TestVisit<CR>', 'Open last run test in current buffer')
end

return M

