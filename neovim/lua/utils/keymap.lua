local M = {}

M.keymap = vim.keymap.set

M.map = function(mode, shortcut, command, desc)
	vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true, desc = desc })
end

M.map_expr = function(mode, shortcut, command, desc)
	vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true, expr = true, desc = desc })
end

M.nmap      = function(shortcut, command, desc) require('utils.keymap').map(     'n', shortcut, command, desc) end
M.nmap_expr = function(shortcut, command, desc) require('utils.keymap').map_expr('n', shortcut, command, desc) end
M.imap      = function(shortcut, command, desc) require('utils.keymap').map(     'i', shortcut, command, desc) end
M.vmap      = function(shortcut, command, desc) require('utils.keymap').map(     'v', shortcut, command, desc) end
M.vmap_expr = function(shortcut, command, desc) require('utils.keymap').map_expr('v', shortcut, command, desc) end
M.tmap      = function(shortcut, command, desc) require('utils.keymap').map(     't', shortcut, command, desc) end
M.xmap      = function(shortcut, command, desc) require('utils.keymap').map(     'x', shortcut, command, desc) end

return M
