local M = {}

function M.setup()

	local dapui = require('dapui')

	local l = require('dap').listeners
	l.after.event_initialized['dapui_config'] = dapui.open
	l.before.event_terminated['dapui_config'] = dapui.close
	l.before.event_exited['dapui_config']     = dapui.close
end

return M
