M = {}

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

	local nmap = require('utils.keymap').nmap
	nmap('<Leader>TT', function() require('toggleterm').toggle(0, nil, nil, 'float') end)
	nmap('<Leader>TL', function() require('toggleterm').toggle(0, nil, nil, 'vertical') end)
	nmap('<Leader>TH', function() require('toggleterm').toggle(0, nil, nil, 'horizontal') end)
end

return M
