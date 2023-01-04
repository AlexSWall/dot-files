local M = {}

function M.setup()
	local mark = require('harpoon.mark')
	local ui = require('harpoon.ui')

	local nmap = require('utils.keymap').nmap
	nmap('<Leader><Leader>a', mark.add_file, 'Add a file to harpoon')
	nmap('<Leader>au', ui.toggle_quick_menu, 'Toggle harpoon quick menu')
	nmap('<Leader>al', ui.nav_next, 'Go to next harpoon file')
	nmap('<Leader>ah', ui.nav_prev, 'Go to previous harpoon file')
	nmap('<Leader><Leader>1', function() ui.nav_file(1) end, 'Go to first harpoon file')
	nmap('<Leader><Leader>2', function() ui.nav_file(2) end, 'Go to second harpoon file')
	nmap('<Leader><Leader>3', function() ui.nav_file(3) end, 'Go to third harpoon file')
	nmap('<Leader><Leader>4', function() ui.nav_file(4) end, 'Go to fourth harpoon file')
	nmap('<Leader><Leader>5', function() ui.nav_file(5) end, 'Go to fifth harpoon file')
	nmap('<Leader><Leader>6', function() ui.nav_file(6) end, 'Go to sixth harpoon file')
	nmap('<Leader><Leader>7', function() ui.nav_file(7) end, 'Go to seventh harpoon file')
	nmap('<Leader><Leader>8', function() ui.nav_file(8) end, 'Go to eighth harpoon file')
	nmap('<Leader><Leader>9', function() ui.nav_file(9) end, 'Go to ninth harpoon file')
end

return M
