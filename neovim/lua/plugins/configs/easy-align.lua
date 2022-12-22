local M = {}

function M.setup()

	local nmap = require('utils.keymap').nmap
	local xmap = require('utils.keymap').xmap

	-- Interactive visual mode (e.g. vipga).
	xmap('ga', '<Plug>(EasyAlign)', 'EasyAlign in visual mode (e.g. `vipga`)')

	-- Interactive for a motion/text object (e.g. gaip).
	nmap('ga', '<Plug>(EasyAlign)', 'EasyAlign motion (e.g. `gaip`)')
end

return M
