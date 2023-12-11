local M = {}

function M.setup()
	require('virt-column').setup({
		char = '│',
		highlight = 'VirtualColumn',
		exclude = {
			filetypes = {
				'',
				'aerial',
				'dapui_console', 'dapui_breakpoints', 'dapui_stacks',
				'dapui_watches', 'dap-repl', 'dapui_scopes',
				'DressingInput',
				'help',
				'NvimTree',
				'Outline',
				'toggleterm',
				'TelescopePrompt',
				'Trouble',
				'tsplayground'
			}
		}
	})
end

return M
