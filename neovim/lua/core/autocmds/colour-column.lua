-- Remove colour column for some filetypes
vim.api.nvim_create_autocmd('FileType', {
	pattern = {
		'', 'aerial', 'help', 'html', 'markdown', 'text', 'toggleterm', 'xhtml'
	},
	callback = function()
		vim.opt_local.colorcolumn = ''
	end
})
