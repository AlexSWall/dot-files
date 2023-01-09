local M = {}

function M.setup()
	require("ts-node-action").setup({})

	local nmap = require('utils.keymap').nmap
	nmap('<Leader>ca', require('ts-node-action').node_action, 'Do a treesitter/code node action')
end

return M
