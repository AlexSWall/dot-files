local M = {}

local relative_number_toggle_ignore_list_lookup = require('utils').list_to_lookup({
	'',
	'aerial',
	'dapui_console', 'dapui_breakpoints', 'dapui_stacks', 'dapui_watches', 'dap-repl', 'dapui_scopes',
	'DressingInput',
	'fzf',
	'help',
	'NvimTree',
	'Outline',
	'toggleterm',
	'TelescopePrompt',
	'Trouble',
	'tsplayground'
})

local number_toggle_on = true

local relative_number_toggle = function(state)

	if relative_number_toggle_ignore_list_lookup[vim.bo.filetype]
		-- or require('true-zen.ataraxis').running
	then
		-- We're never setting the number or relative number in these cases.
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false

	else
		vim.opt_local.number = true

		if number_toggle_on == false then
			-- Skip toggle

		elseif state == 'on' then
			vim.opt_local.relativenumber = true

		elseif state == 'off' then
			vim.opt_local.relativenumber = false
		end
	end
end

function M.set_number_toggle(state)

	if state == 'enable' then

		number_toggle_on = true

		local numToggleGrp = vim.api.nvim_create_augroup('NumberToggle', { clear = true })

		vim.api.nvim_create_autocmd({'BufEnter', 'FocusGained', 'InsertLeave'}, {
			callback = function() relative_number_toggle('on') end,
			group = numToggleGrp
		})

		vim.api.nvim_create_autocmd({'BufLeave', 'FocusLost', 'InsertEnter'}, {
			callback = function() relative_number_toggle('off') end,
			group = numToggleGrp
		})

	elseif state == 'disable' then

		number_toggle_on = false

		vim.api.nvim_create_augroup('NumberToggle', { clear = true })

	end
end

return M
