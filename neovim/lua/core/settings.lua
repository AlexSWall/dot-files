local opt = vim.opt

-- == Fundamental ==

opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.shada = "'100,<1000,s100,h"
opt.undofile = true  -- Creates undofile at opt.undodir

opt.updatetime = 50

vim.g.mapleader = ' '

-- Make K map to :help
opt.keywordprg = ':help'


-- == Usability ==

opt.ignorecase = true
opt.smartcase = true

opt.foldmethod = 'indent'
opt.foldminlines = 0
opt.foldlevel = 99

opt.splitright = true
opt.splitbelow = true

-- Don't give 'search hit BOTTOM' nor an intro message.
opt.shortmess:append('s')
opt.shortmess:append('I')

-- Add 'yank' (y) to commands that can be repeated with '.'.
opt.cpoptions:append('y')

-- Create vertical vimdiff splits
opt.diffopt:append('vertical')

-- Completion menu options:
-- > Give a menu even if there's only one option.
-- > Don't insert (e.g. complete) a match automatically.
-- > Don't select (e.g. highlight) a match automatically.
opt.completeopt = 'menuone,noinsert,noselect'

-- Toggle relativenumber depending on mode:
--   > off in insert mode
--   > on otherwise
-- (except in specific filetypes)
require('functions.relative-number-toggle').set_number_toggle('enable')

-- 'Format options':
--   t: Auto-wrap text using textwidth
--   c: Auto-wrap comments using textwidth (automatic comment character added)
--   q: Allow formatting of comment paragraphs with 'gq'.
--   j: Remove comment character when joining lines.
--   r: Auto-insert comment character on hitting <Enter> in insert mode
-- Not:
--   o: Auto-insert comment character on hitting 'o' in normal mode
--   a: Auto-format paragraphs when inserting into them.
vim.api.nvim_create_autocmd('BufEnter', {
	callback = function()
		opt.formatoptions = 'tcroqj'
	end
})


-- == Visuals ==

opt.termguicolors = true

opt.cursorline = true
opt.cursorlineopt = 'number'

opt.colorcolumn = { 80, 120 }

opt.listchars = 'eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣'
opt.fillchars = { eob = ' ' }  -- Remove ~ end-of-buffer symbols.

opt.wrap = true
opt.linebreak = true        -- Break between words, not in the middle.
opt.breakindent = true      -- Visually indent wrapped lines.
opt.breakindentopt = 'sbr'  -- Use the 'showbreak' option value to indent.
opt.showbreak = '↪ '        -- Prefix indented lines with '↪ '.

opt.scrolloff = 3
opt.sidescrolloff = 5
opt.signcolumn = 'yes'  -- Avoids buffers shifting.

opt.pumheight = 20
opt.pumblend = 10
