if vim.fn.has('nvim-0.8') ~= 1
then
	print('!!! Neovim v0.8 required; skipping configuration.')
	return
end

require('plugins.packer')
require('core.settings')
require('core.keymaps')
