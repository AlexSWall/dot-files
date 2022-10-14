M = {}

function M.setup()
	local nmap = require('utils.keymap').nmap

	nmap('<Leader><Leader>h', '<cmd>SidewaysLeft<CR>')
	nmap('<Leader><Leader>l', '<cmd>SidewaysRight<CR>')
end

return M
