local M = {}

function M.setup()
	require('trouble').setup({})

	require('utils.keymap').nmap('<Leader>tr', require('trouble').toggle, 'Toggle diagnostics split (Trouble)')
end

return M
