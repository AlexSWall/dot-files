local M = {}

function M.setup()
	require('aerial').setup({
		highlight_mode = 'last',
		layout = {
			min_width = 27
		},
		keymaps = {
			["<CR>"] = "actions.scroll",
			["<C-y>"] = "actions.jump",
		}
	})
	require('utils.keymap').nmap(
		'<Leader>s',
		function()
			require('aerial').toggle({
				focus = false,
				direction = 'right'
			})
		end,
		'Toggle symbols outline'
	)
end

return M
