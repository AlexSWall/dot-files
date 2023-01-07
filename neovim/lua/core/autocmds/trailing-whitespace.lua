local whitespace_ft_exclusions_lookup = require('utils').list_to_lookup({
	'',
	'aerial',
	'dapui_console', 'dapui_breakpoints', 'dapui_stacks', 'dapui_watches', 'dap-repl', 'dapui_scopes',
	'toggleterm',
	'help'
})

local all_but_whitespace_ft_exclusions = function(cmd_str)
	return function()
		if not whitespace_ft_exclusions_lookup[vim.bo.filetype] then
			vim.cmd(cmd_str)
		end
	end
end


-- Label trailing whitespace and spaces before tabs as ExtraWhitespace, but not
-- when typing on that line.
vim.api.nvim_create_autocmd('BufWinEnter', {
	callback = all_but_whitespace_ft_exclusions('match ExtraWhitespace /\\s\\+$\\| \\+\\ze\\t/')
})
vim.api.nvim_create_autocmd('InsertEnter', {
	callback = all_but_whitespace_ft_exclusions('match ExtraWhitespace /\\s\\+\\%#\\@<!$\\| \\+\\ze\\t\\%#\\@<!/')
})
vim.api.nvim_create_autocmd('InsertLeave', {
	callback = all_but_whitespace_ft_exclusions('match ExtraWhitespace /\\s\\+$\\| \\+\\ze\\t/')
})
vim.api.nvim_create_autocmd('BufWinLeave', {
	callback = all_but_whitespace_ft_exclusions('call clearmatches()')
})
