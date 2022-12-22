local M = {}

function M.setup()

	vim.g.undotree_SetFocusWhenToggle = 1

	local nmap = require('utils.keymap').nmap

	nmap('<Leader>u', ':UndotreeToggle<CR>', 'Toggle undotree')
end

return M
