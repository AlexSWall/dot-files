local M = {}

function M.setup()

	local dapui = require('dapui')
	dapui.setup({})

	local l = require('dap').listeners

	-- Arbitrary unique key.
	local unique_key = 'dapui_config'
	l.after.event_initialized[unique_key] = dapui.open
end

return M
