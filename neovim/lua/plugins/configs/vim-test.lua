M = {}

function M.setup()

	vim.g['test#strategy'] = 'neovim'

	local nmap = require('utils.keymap').nmap

	nmap('<Leader>tt', '<cmd>TestNearest<CR>')
	nmap('<Leader>tf', '<cmd>TestFile<CR>')
	nmap('<Leader>ts', '<cmd>TestSuite<CR>')
	nmap('<Leader>tl', '<cmd>TestLast<CR>')
	nmap('<Leader>tv', '<cmd>TestVisit<CR>')
end

return M

