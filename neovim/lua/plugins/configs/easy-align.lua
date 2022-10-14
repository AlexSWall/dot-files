M = {}

function M.setup()

	local nmap = require('utils.keymap').nmap
	local xmap = require('utils.keymap').xmap

	-- Interactive visual mode (e.g. vipga).
	xmap('ga', '<Plug>(EasyAlign)')

	-- Interactive for a motion/text object (e.g. gaip).
	nmap('ga', '<Plug>(EasyAlign)')
end

return M
