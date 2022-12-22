local M = {}

function M.setup()
	require('utils.keymap').nmap('<Leader>bd', '<cmd>Sayonara!<CR>', 'Delete buffer, preserve split')
end

return M
