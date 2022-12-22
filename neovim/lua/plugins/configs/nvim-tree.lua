local M = {}

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
	nmap('<Leader>nf', require('nvim-tree').toggle, 'Toggle nvim-tree')
	nmap('<Leader>nv', require('nvim-tree').find_file, 'Go to current file in nvim-tree')
	nmap('<Leader>nh', function() require('nvim-tree').resize('-10') end, 'Reduce nvim-tree width')
	nmap('<Leader>nl', function() require('nvim-tree').resize('+10') end, 'Increase nvim-tree width')
	nmap('<Leader>nc', require('nvim-tree.actions.tree-modifiers.collapse-all').fn, 'Collapse all nvim-tree folders')
	nmap('<Leader>na', function() require('nvim-tree.actions.tree-modifiers.collapse-all').fn(true) end,
	     'Collapse all nvim-tree folders except current file\'s hierarchy')
end

return M
