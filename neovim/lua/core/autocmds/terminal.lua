-- Improve terminal visuals and go to insert mode automatically.
vim.api.nvim_create_autocmd('TermOpen', {
	callback = function()
		vim.opt_local.listchars = ''
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.cursorline = false
		vim.cmd('startinsert')
	end
})

-- Automatically go to insert mode when entering terminal buffer.
vim.api.nvim_create_autocmd('BufEnter', {
	pattern = 'term://*',
	command = 'startinsert'
})

-- Automatically leave insert mode when leaving terminal buffer.
vim.api.nvim_create_autocmd('BufLeave', {
	pattern = 'term://*',
	command = 'stopinsert'
})
