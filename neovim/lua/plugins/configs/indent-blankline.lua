local M = {}

function M.setup()

	require('indent_blankline').setup({
		buftype_exclude = {
			'help',
			'nofile',
			'packer',
			'prompt',
			'quickfix',
			'terminal'
		},
		filetype_exclude = {
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
		space_char_blankline = ' ',
		char_highlight_list = { 'IndentBlanklineIndent' }
	})

end

return M
