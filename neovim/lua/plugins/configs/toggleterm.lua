local M = {}

function M.setup()
	require('toggleterm').setup({
		-- size can be a number or function which is passed the current terminal
		size = function(term)
			if term.direction == 'horizontal' then
				return 15
			elseif term.direction == 'vertical' then
				return vim.o.columns * 0.4
			end
		end,
		open_mapping = [[<c-q>]],
		direction = 'vertical'
	})

	local m = require('utils.keymap').nmap
	m('<Leader>TT', function() require('toggleterm').toggle(0, nil, nil, 'float') end,      'Toggle floating terminal')
	m('<Leader>TL', function() require('toggleterm').toggle(0, nil, nil, 'vertical') end,   'Toggle vertical terminal')
	m('<Leader>TH', function() require('toggleterm').toggle(0, nil, nil, 'horizontal') end, 'Toggle horizontal terminal')
end

return M
