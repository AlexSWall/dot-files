local M = {}

function M.setup()

	local dapui = require('dapui')
	dapui.setup({
		layouts = {
			{
				elements = {
					-- Elements can be strings or table with id and size keys.
					{ id = 'console',     size = 0.25 },
					{ id = 'watches',     size = 0.25 },
					{ id = 'breakpoints', size = 0.20 },
					{ id = 'stacks',      size = 0.30 },
				},
				size = 40,
				position = 'left',
			},
			{
				elements = {
					{ id = 'scopes', size = 0.60 },
					{ id = 'repl',   size = 0.40 },
				},
				size = 0.30,
				position = 'bottom',
			},
		},
	})

	local l = require('dap').listeners

	-- Arbitrary unique key.
	local unique_key = 'dapui_config'
	l.after.event_initialized[unique_key] = dapui.open
end

return M
