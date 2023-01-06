local M = {}

function M.setup()

	require('indent_blankline').setup({
		buftype_exclude = { 'help', 'packer' },
		filetype_exclude = { 'alpha', 'mason' },
		space_char_blankline = ' ',
		char_highlight_list = { 'IndentBlanklineIndent' }
	})

end

return M
