if vim.fn.has('nvim-0.8') ~= 1
then
	print('!!! Neovim v0.8 required; skipping configuration.')
	return
end

-- Neovim v0.9:
-- - Add splitkeep
-- - Add showcmdloc
-- - Add diffopt += linematch:60
-- - Maybe change statuscolumn
-- - Remove editorconfig

require('plugins.lazy')

require('core.options')
require('core.autocmds')
require('core.indentation').setup()
require('core.keymaps')
require('core.misc')
