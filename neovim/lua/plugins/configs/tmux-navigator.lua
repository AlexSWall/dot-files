M = {}

function M.setup()

	vim.g.tmux_navigator_no_mappings = 1

	local nmap = require('utils.keymap').nmap

	nmap('<M-h>', ':TmuxNavigateLeft<CR>')
	nmap('<M-j>', ':TmuxNavigateDown<CR>')
	nmap('<M-k>', ':TmuxNavigateUp<CR>')
	nmap('<M-l>', ':TmuxNavigateRight<CR>')
	nmap('<M-\\>', ':TmuxNavigatePrevious<CR>')
end

return M
