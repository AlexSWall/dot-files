local M = {}

function M.setup()
	require('neoscroll').setup({
		-- easing_function = 'quadratic'
		mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zt', 'zz', 'zb'},
	})

	require('neoscroll.config').set_mappings({
		['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '50'}},
		['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '50'}},
		['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '80'}},
		['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '80'}},
		['zt']    = {'zt', {'50'}},
		['zz']    = {'zz', {'50'}},
		['zb']    = {'zb', {'50'}}
	})
end

return M
