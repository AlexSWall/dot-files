M = {}

function M.setup()
	require('nvim-tree').setup({
		view = {
			width = 30,
		},
		hijack_cursor = true,
		filters = {
			custom = {
				'^.*\\.pyc$'
			}
		}
	})

	local nmap = require('utils.keymap').nmap
	nmap('<Leader>nf', require('nvim-tree').toggle)
	nmap('<Leader>nv', require('nvim-tree').find_file)
	nmap('<Leader>nh', function() require('nvim-tree').resize('-10') end)
	nmap('<Leader>nl', function() require('nvim-tree').resize('+10') end)
	nmap('<Leader>nc', require('nvim-tree.actions.tree-modifiers.collapse-all').fn)
	nmap('<Leader>na', function() require('nvim-tree.actions.tree-modifiers.collapse-all').fn(true) end)
end

return M
