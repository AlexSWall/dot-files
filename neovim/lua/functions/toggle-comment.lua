local M = {}

function M.toggle_comment()
	local U = require('Comment.utils')
	local A = require('Comment.api')
	local FT = require('Comment.ft')

	-- Current line info.
	local current_line = vim.api.nvim_get_current_line()
	local pos = vim.api.nvim_win_get_cursor(0)

	-- Setup.
	local padding = true
	local ctx = {
		ctype = U.ctype.linewise,
		range = { srow = pos[1], scol = pos[2], erow = pos[1], ecol = pos[2] }
	}
	local cstr = FT.calculate(ctx) or vim.bo.commentstring
	local ll, rr = U.unwrap_cstr(cstr)

	-- Useful primitives.
	local cs_width = #ll + (padding and 1 or 0)
	local is_commented = U.is_commented(ll, rr, padding)
	local toggle_current_line = A.locked('toggle.linewise.current')

	-- Toggle.
	toggle_current_line('')

	-- Move cursor.
	pos[2] = pos[2] + (is_commented(current_line) and -cs_width or cs_width)
	pos[2] = (pos[2] < 0) and 0 or pos[2]
	vim.api.nvim_win_set_cursor(0, pos)
end

return M
