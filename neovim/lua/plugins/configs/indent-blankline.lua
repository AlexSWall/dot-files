local M = {}

function M.setup()

	require('ibl').setup({
		indent = {
			tab_char = '│',  -- For left-aligned, instead use '▏'
			-- Highlight = 'hl-IblIndent'
		},
		exclude = {
			filetypes = {
				'',
				'alpha',
				'checkhealth',
				'dapui_console', 'dapui_breakpoints', 'dapui_stacks', 'dapui_watches', 'dap-repl', 'dapui_scopes',
				'help',
				'lspinfo',
				'man',
				'mason',
				'NvimTree'
			},
			buftypes = {
				'help',
				'nofile',
				'packer',
				'prompt',
				'quickfix',
				'terminal'
			}
		}
	})

end

return M
