local M = {}

function M.setup()
	require('treesj').setup({
		use_default_keymaps = false
	})

	local nmap = require('utils.keymap').nmap
	nmap('<Leader>ct', require('treesj').toggle, 'Toggle a split/join of a block of code')
	nmap('<Leader>cs', require('treesj').join, 'Join a block of code')
	nmap('<Leader>cj', require('treesj').split, 'Split a block of code')
end

return M
