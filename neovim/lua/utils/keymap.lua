M = {}

M.keymap = vim.keymap.set

M.map = function(mode, shortcut, command)
	vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true })
end

M.map_expr = function(mode, shortcut, command)
	vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true, expr = true })
end

M.nmap      = function(shortcut, command) require('utils.keymap').map(     'n', shortcut, command) end
M.nmap_expr = function(shortcut, command) require('utils.keymap').map_expr('n', shortcut, command) end
M.imap      = function(shortcut, command) require('utils.keymap').map(     'i', shortcut, command) end
M.vmap      = function(shortcut, command) require('utils.keymap').map(     'v', shortcut, command) end
M.vmap_expr = function(shortcut, command) require('utils.keymap').map_expr('v', shortcut, command) end
M.tmap      = function(shortcut, command) require('utils.keymap').map(     't', shortcut, command) end
M.xmap      = function(shortcut, command) require('utils.keymap').map(     'x', shortcut, command) end

return M
