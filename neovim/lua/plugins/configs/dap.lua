local M = {}

function M.setup_python_dap()
	require('dap-python').setup('~/.local/share/nvim/dap_servers/debugpy/bin/python')
end

function M.setup_dap_keymaps()
	local nmap = require('utils.keymap').nmap
	local xmap = require('utils.keymap').xmap
	local dap = require('dap')
	local dapui = require('dapui')
	local input = function(prompt) return vim.fn.input(prompt) end

	-- Control debugging flow. (i,o,u,s,h)
	nmap({ '<F1>', '<Leader>di' }, dap.step_into, 'Step info')
	nmap({ '<F2>', '<Leader>do' }, dap.step_over, 'Step over')
	nmap({ '<F3>', '<Leader>du' }, dap.step_out, 'Step out')
	nmap({ '<F4>', '<Leader>ds' }, dap.continue, 'Continue/Start')
	nmap({ '<F5>', '<Leader>dh' }, dap.run_to_cursor, "Continue to cursor ('here')")

	-- Execution control. (p,x)
	nmap('<Leader>dp', dap.pause, 'Pause an executing thread')
	nmap('<Leader>dx', dap.terminate, 'Terminate a debugging session')

	-- Breakpoints. (b,B,r,l,C)
	nmap('<Leader>db', dap.toggle_breakpoint, 'Toggle breakpoint')
	nmap('<Leader>dB', function()
		dap.set_breakpoint(input('Breakpoint condition: '))
	end, 'Set breakpoint condition')
	nmap('<Leader>dr', function()
		dap.set_breakpoint()
		dap.continue()
	end, 'Set breakpoint and begin debugging.')
	nmap('<Leader>dC', dap.clear_breakpoints, 'Clear breakpoints')

	-- Navigation. (hjk)
	nmap('<Leader>dk', dap.up, 'Go up a debugging frame')
	nmap('<Leader>dj', dap.down, 'Go down a debugging frame')
	nmap('<Leader>dl', dap.focus_frame, 'Go to the current debugger line for the current frame')

	-- Logging. (L)
	nmap('<Leader>dL', function()
		dap.set_breakpoint(nil, nil, input('Log point message: '))
	end, 'Set log message breakpoint')

	-- UI. (t)
	nmap('<Leader>d<Space>', function()
		dapui.toggle()
	end, 'Toggle debugging REPL')

	-- Evaluate an expression (e)
	xmap('<Leader>de', dapui.eval, 'Evaluation the highlighted expression')
	nmap('<Leader>de', function()
		dapui.eval(input('Expression to evaluate: '))
	end, 'Evaluate an expression')
end

function M.setup_dap_visuals()

	local signs = {
		DapBreakpoint          = { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' },
		DapBreakpointCondition = { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' },
		DapBreakpointRejected  = { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' },
		DapLogPoint            = { text = '', texthl = 'DapLogPoint',   linehl = '',   numhl = '' },
		DapStopped             = { text = '', texthl = 'DapStopped',    linehl = 'debugPC', numhl = '' },
	}

	for name, opts in pairs(signs) do
		vim.fn.sign_define(name, opts)
	end
end

function M.setup()
	-- Notes:
	-- - Type any expressions (e.g. a variable name) in the Watches buffer to watch

	M.setup_dap_keymaps()
	M.setup_python_dap()
	M.setup_dap_visuals()

end

return M
