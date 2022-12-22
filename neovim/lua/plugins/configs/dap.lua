local M = {}

function M.setup()

	local nmap = require('utils.keymap').nmap

	nmap('<F1>', require('dap').step_into, 'Step info')
	nmap('<F2>', require('dap').step_over, 'Step over')
	nmap('<F3>', require('dap').step_out, 'Step out')
	nmap('<F4>', require('dap').continue, 'Continue')

	nmap('<Leader>db', require('dap').toggle_breakpoint, 'Toggle breakpoint')
	nmap('<Leader>dB', function()
		require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
	end, 'Set breakpoint condition')
	nmap('<Leader>dl', function()
		require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
	end, 'Set log message breakpoint')
	nmap('<Leader>dr', function()
		require('dap').repl.open()
	end, 'Open debugging REPL')
end

return M
