M = {}

function M.setup()
	require('utils.keymap').nmap('<Leader>bd', '<cmd>Sayonara!<CR>')
end

return M
