local M = {}

function M.setup()
	local true_zen = require('true-zen')

	true_zen.setup({
		integrations = {
			tmux = true,
			twilight = true
		},
		modes = {
			ataraxis = {
				callbacks = {
					open_pos = function()
						vim.opt.showmode = false
						vim.opt.showcmd = false
						vim.opt.scrolloff = 999

						vim.g.number_toggle_on = 0
						vim.opt.relativenumber = false
					end,
					close_pre = function()
						vim.opt.showmode = true
						vim.opt.showcmd = true
						vim.opt.scrolloff = 3

						vim.g.number_toggle_on = 1
						vim.opt.relativenumber = true
					end
				}
			}
		}
	})

	require('utils.keymap').nmap('<Leader>tz', require('true-zen').ataraxis, 'Toggle TrueZen')
end

return M

