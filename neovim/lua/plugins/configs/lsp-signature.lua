M = {}

function M.setup()
	require('lsp_signature').setup({
		hint_enable = true,
		hint_prefix = '',
		hint_scheme = 'Hint',
		floating_window_above_cur_line = false,
		transparency = 5,
		floating_window = false,
		floating_window_off_x = 1,
		floating_window_off_y = 1
	})
end

return M
