local M = {}

function M.setup()

	require('illuminate').configure({
		delay = 50,
		filetypes_denylist = {
			'TelescopePrompt',
			'git',
			'gitcommit',
			'help',
			'markdown',
			'packer',
		},
	})
end

return M
