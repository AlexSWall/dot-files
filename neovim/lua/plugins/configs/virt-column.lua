local M = {}

local virt_column_ignore_list_lookup = require('utils').list_to_lookup({
	'',
	'aerial',
	'dapui_console', 'dapui_breakpoints', 'dapui_stacks', 'dapui_watches', 'dap-repl', 'dapui_scopes',
	'DressingInput',
	'help',
	'NvimTree',
	'Outline',
	'toggleterm',
	'TelescopePrompt',
	'Trouble',
	'tsplayground'
})

-- Disable colour column for some filetypes
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead', 'BufEnter' }, {
	callback = function()
		local filetype = vim.api.nvim_get_option_value('filetype', { scope = 'local' })
		if not filetype or virt_column_ignore_list_lookup[filetype] then
			vim.opt_local.colorcolumn = ''
		end
	end
})

function M.setup()
	require('virt-column').setup()
end

return M
