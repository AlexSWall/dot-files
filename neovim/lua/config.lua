if vim.fn.has('nvim-0.7') ~= 1
then
	print('!!! Neovim v0.7 required; skipping configuration.')
	return
end

require('core.settings')
require('plugins._vim-plug')
require('plugins.plugin-config')
require('core.keymaps')
require('core.colourscheme')
