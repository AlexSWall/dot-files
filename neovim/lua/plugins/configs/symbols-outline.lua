local M = {}

function M.setup()

	vim.g.symbols_outline = {
		show_guides = false,
		show_symbol_details = false,
	}

	require('utils.keymap').nmap('<Leader>s', require('symbols-outline').toggle_outline, 'Toggle symbols outline')
end

return M
