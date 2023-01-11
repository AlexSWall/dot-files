require('core.autocmds.colour-column')
require('core.autocmds.terminal')
require('core.autocmds.trailing-whitespace')

-- Set comment string to // instead of /* */ when suitable.
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'c,cpp,cs,java,javascript,php',
	command = 'setlocal commentstring=//\\ %s'
})

vim.api.nvim_create_autocmd('BufEnter', {
	callback = function()
		-- 'Format options':
		--   t: Auto-wrap text using textwidth
		--   c: Auto-wrap comments using textwidth (automatic comment character added)
		--   q: Allow formatting of comment paragraphs with 'gq'.
		--   j: Remove comment character when joining lines.
		--   r: Auto-insert comment character on hitting <Enter> in insert mode
		--   o: Auto-insert comment character on hitting 'o' in normal mode
		--   a: Auto-format paragraphs when inserting into them.
		vim.opt.formatoptions = 'tcroqj'
	end
})

-- relativenumber = not in_insert_mode, unless ignored filetype.
require('functions.relative-number-toggle').set_number_toggle('enable')
