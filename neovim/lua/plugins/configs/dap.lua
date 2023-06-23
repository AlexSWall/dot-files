local M = {}

function M.setup_python_dap()
	require('dap-python').setup('~/.local/share/nvim/dap_servers/debugpy/bin/python')
end

function M.setup_cpp_dap()
	require('dap').adapters.codelldb = M.get_codelldb_adapter()
	require('dap').configurations.cpp = {
		{
			type = 'codelldb',
			request = 'launch',
			program = function()
				return vim.fn.input('Path to executable: ', vim.fn.getcwd()..'/', 'file')
			end,
			--program = '${fileDirname}/${fileBasenameNoExtension}',
			cwd = '${workspaceFolder}',
			terminal = 'integrated'
		}
	}
end

function M.get_codelldb_adapter()
	local lldb_extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/'
	local code_lldb_port_num = '13000'
	return {
		type = 'server',
		host = '127.0.0.1',
		port = code_lldb_port_num,
		executable = {
			command = lldb_extension_path .. 'adapter/codelldb',
			args = { '--liblldb', lldb_extension_path .. 'lldb/lib/liblldb.dylib', '--port', code_lldb_port_num }
		},
		command = '',  -- Remove for clarity
		name = '',  -- Remove for clarity
	}
end

function M.setup_rust_dap_keymaps()
	local dap = require('dap')

	-- Dap-specific overrides.
	local map = function(lhs, rhs, desc)
		vim.keymap.del('n', lhs)  -- Delete original mapping.
		vim.keymap.set('n', lhs, rhs, { buffer = vim.api.nvim_get_current_buf(), desc = desc })
	end

	local start_or_continue = function()
		if dap.session() then
			dap.continue()
		else
			require('rust-tools').debuggables.debuggables()
		end
	end

	map('<Leader>ds', start_or_continue, 'Continue/Start Rust')
	map('<Leader>dr', function()
		dap.set_breakpoint()
		start_or_continue()
	end, 'Set breakpoint and begin debugging Rust.')
end

function M.setup_dap_keymaps()
	local nmap = require('utils.keymap').nmap
	local xmap = require('utils.keymap').xmap
	local dap = require('dap')
	local dapui = require('dapui')
	local input = function(prompt) return vim.fn.input(prompt) end

	-- Control debugging flow. (i,o,u,s,h)
	nmap({ '<F1>', '<Leader>di' }, dap.step_into, 'Step into')
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
		dapui.toggle({ reset = true })
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
	M.setup_dap_visuals()

	M.setup_python_dap()
	M.setup_cpp_dap()
end

return M
