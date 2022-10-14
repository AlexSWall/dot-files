M = {}

function M.setup()

	local nmap = require('utils.keymap').nmap

	nmap('<F1>', require('dap').step_into)
	nmap('<F2>', require('dap').step_over)
	nmap('<F3>', require('dap').step_out)
	nmap('<F4>', require('dap').continue)

	nmap('<Leader>db', require('dap').toggle_breakpoint)
	nmap('<Leader>dB', function()
		require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
	end)
	nmap('<Leader>dl', function()
		require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
	end)
	nmap('<Leader>dr', function()
		require('dap').repl.open()
	end)
end

return M
