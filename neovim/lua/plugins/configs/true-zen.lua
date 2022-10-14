M = {}

function M.setup()
	local true_zen = require('true-zen')

	true_zen.setup({
		integrations = {
			tmux = true,
			gitsigns = true,
			limelight = true
		}
	})

	true_zen.after_mode_ataraxis_on = function ()

		vim.opt.showmode = false
		vim.opt.showcmd = false
		vim.opt.scrolloff = 999

		vim.g.number_toggle_on = 0
		vim.opt.relativenumber = false
	end

	true_zen.before_mode_ataraxis_off = function ()
		vim.opt.showmode = true
		vim.opt.showcmd = true
		vim.opt.scrolloff = 3

		vim.g.number_toggle_on = 1
		vim.opt.relativenumber = true
	end

	require('utils.keymap').nmap('<Leader>tz', require("true-zen").ataraxis)
end

return M

