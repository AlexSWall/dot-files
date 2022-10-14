
-- Local Aliases
local cmd = vim.cmd
local g = vim.g
local opt = vim.opt


--------------------------------------------------------------------------------
--      General
--------------------------------------------------------------------------------

-- Core Functionality
opt.mouse = 'a'                  -- Enable mouse support.
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.encoding = 'utf-8'

opt.completeopt = 'menuone,'     -- Give a menu even if there's only one option.
					 .. 'noinsert,'   -- Don't insert (e.g. complete) a match automatically.
                .. 'noselect'    -- Don't select (e.g. highlight) a match automatically.

cmd('filetype on')               -- Set the 'filetype' option on loading a file..
cmd('filetype plugin on')        -- Look for filetype-specific setup in ./ftplugin/.

opt.tabpagemax = 50              -- Increase maximum number of tabs to 50.
opt.cpoptions:append('y')        -- Add 'yank' (y) to commands that can be repeated with '.'.

opt.viminfo = "'100,<1000,s100,h"
opt.keywordprg = ':help'         -- Make K map to :help

vim.g.mapleader = ' '

-- Improved Usage
opt.ignorecase = true            -- Case-insensitive search when entirely lowercase.
opt.smartcase = true             -- Case-sensitive search when it includes uppercase.

opt.foldmethod = 'indent'
opt.foldminlines = 0
opt.foldlevel = 99

-- Toggle relativenumber depending on mode:
--   > off in insert mode
--   > on otherwise
-- (except in specific filetypes)
require("functions.relative-number-toggle").set_number_toggle("enable")


--------------------------------------------------------------------------------
--     Visuals
--------------------------------------------------------------------------------

-- Performance
opt.updatetime = 100             -- Milliseconds to wait for trigger 'document_highlight'
opt.lazyredraw = true            -- Faster scrolling

-- Practical
opt.termguicolors = true         -- Enable 24-bit RGB colors.

opt.number = true
opt.relativenumber = true

opt.colorcolumn = { 80, 120 }
opt.splitright = true
opt.splitbelow = true

opt.list = false
opt.listchars = 'eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣'

opt.wrap = true
opt.linebreak = true             -- Break between words, not in the middle.
opt.breakindent = true           -- Visually indent wrapped lines.
opt.breakindentopt = 'sbr'       -- Visually indent with the 'showbreak' option value.
opt.showbreak = '↪ '             -- What to show to indent wrapped lines.

opt.scrolloff = 3
opt.sidescrolloff = 5
opt.signcolumn = 'yes'           -- Always show signcolumn to avoid buffers shifting

opt.pumheight = 20               -- Pop-up menu height

-- Aesthetic
opt.pumblend = 10

opt.cursorline    = true
opt.cursorlineopt = 'number'

-- Status Line
g.StatusLineGit = function()

	if vim.fn.exists('*gitbranch#name') ~= 0 then

		local branch_name = vim.fn['gitbranch#name']()

		if string.len(branch_name) > 0 then
			return '  ' .. branch_name .. ' '
		end
	end

	return ''
end

opt.statusline = '%#StatusLine# %{StatusLineGit()} %f %y'
                 .. ' %{&fileencoding?&fileencoding:&encoding}:%{&fileformat}'
                 .. ' %h%w%m%r'
                 .. ' %#StatusLineNC#%=-%12.(%#StatusLine#'
                 .. ' %l,%c%V%) '

opt.fillchars = 'stl:-,stlnc:-'  -- Fill status line with hyphens

opt.cmdheight = 0

-- Miscellaneous
opt.shortmess:append('s')        -- Don't give 'search hit BOTTOM' etc.
opt.shortmess:append('I')        -- No intro message
opt.diffopt:append('vertical')   -- Create vertical vimdiff splits
vim.g.netrw_banner = 0


--------------------------------------------------------------------------------
--      Indentation
--------------------------------------------------------------------------------

-- Indentation strategy
cmd('filetype indent on')        -- Change indentation depending on filetype.
opt.autoindent = true            -- Copy indent to next line.
                                 -- (doesn't interfere with `filetype indent on`)

opt.smartindent = false          -- Interferes with `filetype indent on`
opt.cindent = false              -- Interferes with `filetype indent on`

-- Default indentation
opt.expandtab = false            -- Use tabs instead of spaces
opt.shiftwidth = 3               -- Shift 3 spaces when tab
opt.tabstop = 3                  -- 1 tab == 3 spaces
opt.softtabstop = 3              -- 1 tab == 3 spaces

-- Filetype-specific indentation

local set_filetype_indentation = function(filetypes, tab_width, expand_tab)
	vim.api.nvim_create_autocmd('Filetype', {
		pattern = filetypes,
		callback = function()
			vim.opt_local.tabstop     = tab_width
			vim.opt_local.shiftwidth  = tab_width
			vim.opt_local.softtabstop = tab_width
			vim.opt_local.expandtab   = expand_tab
		end
	})
end

set_filetype_indentation('cpp,zsh', 3, false)
set_filetype_indentation('haskell,yaml,python,markdown', 4, true)


--------------------------------------------------------------------------------
--      Autocommands
--------------------------------------------------------------------------------

-- Format options:
--   t: Auto-wrap text using textwidth
--   c: Auto-wrap comments using textwidth (automatic comment character added)
--   q: Allow formatting of comment paragraphs with 'gq'.
--   j: Remove comment character when joining lines.
-- Not:
--   r: Auto-insert comment character on hitting <Enter> in insert mode
--   o: Auto-insert comment character on hitting 'o' in normal mode
--   a: Auto-format paragraphs when inserting into them.
vim.api.nvim_create_autocmd('BufEnter', {
	callback = function()
		opt.formatoptions = 'tcqj'
	end
})

-- Remove colour column for some filetypes
vim.api.nvim_create_autocmd('FileType', {
	pattern = {'help', 'text', 'markdown', 'html', 'xhtml'},
	callback = function()
		vim.opt_local.colorcolumn = '0'
	end
})

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

local table_to_lookup = function(tbl)
	local ret = {}
	for _, v in pairs(tbl) do
		ret[v] = true
	end
	return ret
end

local all_but_fts = function(cmd_str, ft_exclusions)
	return function()
		if not ft_exclusions[vim.bo.filetype] then
			vim.cmd(cmd_str)
		end
	end
end

local whitespace_ft_exclusions = table_to_lookup({
	''
})

-- Label trailing whitespace and spaces before tabs as ExtraWhitespace, but not
-- when typing on that line.
vim.api.nvim_create_autocmd('BufWinEnter', {
	callback = all_but_fts('match ExtraWhitespace /\\s\\+$\\| \\+\\ze\\t/', whitespace_ft_exclusions)
})
vim.api.nvim_create_autocmd('InsertEnter', {
	callback = all_but_fts('match ExtraWhitespace /\\s\\+\\%#\\@<!$\\| \\+\\ze\\t\\%#\\@<!/', whitespace_ft_exclusions)
})
vim.api.nvim_create_autocmd('InsertLeave', {
	callback = all_but_fts('match ExtraWhitespace /\\s\\+$\\| \\+\\ze\\t/', whitespace_ft_exclusions)
})
vim.api.nvim_create_autocmd('BufWinLeave', {
	callback = all_but_fts('call clearmatches()', whitespace_ft_exclusions)
})

-- Set comment string to // instead of /* */ when suitable.
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'c,cpp,cs,java,javascript,php',
	command = 'setlocal commentstring=//\\ %s'
})


--------------------------------------------------------------------------------
--      Performance
--------------------------------------------------------------------------------

local disable_distribution_plugins = function()
  vim.g.loaded_gzip = 1
  vim.g.loaded_tar = 1
  vim.g.loaded_tarPlugin = 1
  vim.g.loaded_zip = 1
  vim.g.loaded_zipPlugin = 1
  vim.g.loaded_getscript = 1
  vim.g.loaded_getscriptPlugin = 1
  vim.g.loaded_vimball = 1
  vim.g.loaded_vimballPlugin = 1
  vim.g.loaded_matchit = 1
  vim.g.loaded_matchparen = 1
  vim.g.loaded_2html_plugin = 1
  vim.g.loaded_logiPat = 1
  vim.g.loaded_rrhelper = 1
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_netrwSettings = 1
  vim.g.loaded_netrwFileHandlers = 1
end

disable_distribution_plugins()
