M = {}

function M.setup()
	require('neoscroll').setup({
		-- easing_function = 'quadratic'
		mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zt', 'zz', 'zb'},
	})

	require('neoscroll.config').set_mappings({
		['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '70'}},
		['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '70'}},
		['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '140'}},
		['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '140'}},
		['zt']    = {'zt', {'70'}},
		['zz']    = {'zz', {'70'}},
		['zb']    = {'zb', {'70'}}
	})
end

return M
