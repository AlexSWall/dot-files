if vim.fn.has('nvim-0.9') ~= 1
then
	print('!!! Neovim v0.9 required; skipping configuration.')
	return
end

-- Must be before any keybindings which make use of <Leader>.
vim.g.mapleader = ' '

require('plugins.lazy')

require('core.options')
require('core.autocmds')
require('core.indentation').setup()
require('core.keymaps')
require('core.misc')
