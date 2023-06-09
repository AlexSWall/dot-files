local M = {}

function M.setup()
	local is_in_tmux = (os.getenv('TMUX') ~= nil)

	if not is_in_tmux then
		require('neoscroll').setup({
			-- easing_function = 'quadratic'
			mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zt', 'zz', 'zb'},
		})

		require('neoscroll.config').set_mappings({
			['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '35'}},
			['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '35'}},
			['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '70'}},
			['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '70'}},
			['zt']    = {'zt', {'35'}},
			['zz']    = {'zz', {'35'}},
			['zb']    = {'zb', {'35'}}
		})
	end
end

return M
