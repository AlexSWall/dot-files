local M = {}

function M.setup()
	local nmap = require('utils.keymap').nmap

	nmap('<cmd>SidewaysLeft<CR>', '<Leader><Leader>h', 'Move to previous function argument')
	nmap('<Leader><Leader>l', '<cmd>SidewaysRight<CR>', 'Move to next function argument')
end

return M
