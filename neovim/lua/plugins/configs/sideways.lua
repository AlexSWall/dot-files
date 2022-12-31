local M = {}

function M.setup()
	local nmap = require('utils.keymap').nmap

	nmap('<Leader><Leader>h', '<cmd>SidewaysLeft<CR>', 'Move to previous function argument')
	nmap('<Leader><Leader>l', '<cmd>SidewaysRight<CR>', 'Move to next function argument')
end

return M
