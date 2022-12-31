require('core.autocmds.colour-column')
require('core.autocmds.terminal')
require('core.autocmds.trailing-whitespace')

-- Set comment string to // instead of /* */ when suitable.
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'c,cpp,cs,java,javascript,php',
	command = 'setlocal commentstring=//\\ %s'
})
