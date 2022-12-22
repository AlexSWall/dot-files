local M = {}

function M.setup()

	vim.g.tmux_navigator_no_mappings = 1

	local nmap = require('utils.keymap').nmap

	nmap('<M-h>', ':TmuxNavigateLeft<CR>', 'Move to Tmux pane to the left')
	nmap('<M-j>', ':TmuxNavigateDown<CR>', 'Move to Tmux pane below')
	nmap('<M-k>', ':TmuxNavigateUp<CR>', 'Move to Tmux pane above')
	nmap('<M-l>', ':TmuxNavigateRight<CR>', 'Move to Tmux pane to the right')
	nmap('<M-\\>', ':TmuxNavigatePrevious<CR>', 'Move to previous Tmux pane')
end

return M
