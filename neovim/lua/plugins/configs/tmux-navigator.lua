local M = {}

function M.setup()

	local navigator = require('Navigator')
	navigator.setup()

	local nmap = require('utils.keymap').nmap

	nmap('<M-h>', navigator.left, 'Move to Tmux pane to the left')
	nmap('<M-j>', navigator.down, 'Move to Tmux pane below')
	nmap('<M-k>', navigator.up, 'Move to Tmux pane above')
	nmap('<M-l>', navigator.right, 'Move to Tmux pane to the right')
	nmap('<M-\\>', navigator.previous, 'Move to previous Tmux pane')
end

return M
