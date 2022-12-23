local M = {}

function M.setup()

	require('bufferline').setup({
		options = {
			mode = 'tabs',
			separator_style = 'slant',
			show_duplicate_prefix = false,
			offsets = {
				{
					filetype = 'NvimTree',
					text = 'File Explorer',
					text_align = 'center',
					separator = true
				}
			}
		},
		highlights = require('plugins.configs.vscode').bufferline_highlights()
	})
end

return M
