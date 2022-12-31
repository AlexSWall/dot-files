local all_but_fts = function(cmd_str, ft_exclusions)
	return function()
		if not ft_exclusions[vim.bo.filetype] then
			vim.cmd(cmd_str)
		end
	end
end

local whitespace_ft_exclusions = require('utils').table_to_lookup({
	'', 'aerial', 'toggleterm', 'help'
})

-- Label trailing whitespace and spaces before tabs as ExtraWhitespace, but not
-- when typing on that line.
vim.api.nvim_create_autocmd('BufWinEnter', {
	callback = all_but_fts('match ExtraWhitespace /\\s\\+$\\| \\+\\ze\\t/', whitespace_ft_exclusions)
})
vim.api.nvim_create_autocmd('InsertEnter', {
	callback = all_but_fts('match ExtraWhitespace /\\s\\+\\%#\\@<!$\\| \\+\\ze\\t\\%#\\@<!/', whitespace_ft_exclusions)
})
vim.api.nvim_create_autocmd('InsertLeave', {
	callback = all_but_fts('match ExtraWhitespace /\\s\\+$\\| \\+\\ze\\t/', whitespace_ft_exclusions)
})
vim.api.nvim_create_autocmd('BufWinLeave', {
	callback = all_but_fts('call clearmatches()', whitespace_ft_exclusions)
})
