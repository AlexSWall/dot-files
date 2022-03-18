
-- Local Aliases
local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

--------------------------------------------------------------------------------
--      General
--------------------------------------------------------------------------------

-- Core Functionality
if vim.opt.shell['_value'] == 'fish' then
	vim.opt.shell = 'zsh'
end

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

-- Improved Usage
opt.ignorecase = true            -- Case-insensitive search when entirely lowercase.
opt.smartcase = true             -- Case-sensitive search when it includes uppercase.

opt.foldmethod = 'indent'
opt.foldminlines = 0
opt.foldlevel = 99

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

g.relative_number_toggle_ignore_list = {
	'',
	'help',
	'NvimTree',
	'Outline',
	'TelescopePrompt',
}                                -- (Used by auto number-toggle below)
g.number_toggle_on = true        -- (Used by set number-toggle below)

opt.colorcolumn = {80, 100, 120}
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
opt.pumblend = 20

-- Status Line
g.StatusLineGit = function()

	if vim.fn.exists('*gitbranch#name') then

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
local file_indentation_configs = {
	['cpp,zsh'] = { 3, 'noexpandtab' },
	['haskell,yaml,python,markdown']  = { 4, 'expandtab' },
}

for k, v in pairs(file_indentation_configs) do
	cmd(string.format(
		'autocmd Filetype %s setlocal ts=%d sw=%d sts=%d %s',
		k, v[1], v[1], v[1], v[2]
	))
end


--------------------------------------------------------------------------------
--      Autocommands
--------------------------------------------------------------------------------

vim.cmd([[
	" Don't auto-comment new lines
	autocmd BufEnter * set fo-=c fo-=r fo-=o

	" Remove colour column for some filetypes
	autocmd FileType text,markdown,html,xhtml setlocal cc=0

	" Add highlighting to trailing whitespace and spaces before tabs, but not
	" when typing on that line.
	highlight ExtraWhitespace guibg=#223E55
	match ExtraWhitespace /\\s\\+$\\| \\+\\ze\\t/

	" Wizardry to prevent errors appearing while typing.
	autocmd BufWinEnter * match ExtraWhitespace /\\s\\+$\\| \\+\\ze\\t/
	autocmd InsertEnter * match ExtraWhitespace /\\s\\+\\%#\\@<!$\\| \\+\\ze\\t\\%#\\@<!/
	autocmd InsertLeave * match ExtraWhitespace /\\s\\+$\\| \\+\\ze\\t/
	autocmd BufWinLeave * call clearmatches()

	" Automatic number-toggle
	function! RelativeNumberToggle(state)

		if index(g:relative_number_toggle_ignore_list, &filetype) >= 0
			" Filetype is on the ignore list
			set norelativenumber
			return
		elseif g:number_toggle_on
		else
			return
		endif

		if a:state == 'on'
			set relativenumber

		elseif a:state == 'off'
			set norelativenumber

		endif
	endfunction

	" Enable/disable number-toggle
	function! SetNumberToggle(state)

		let state = a:state

		if a:state == ''
			if g:number_toggle_on
				let state = 'disable'
			else
				let state = 'enable'
			endif
		endif

		if state == 'enable'
			let g:number_toggle_on = 1
			augroup NumberToggle
				autocmd!
				autocmd BufEnter,FocusGained,InsertLeave * call RelativeNumberToggle('on')
				autocmd BufLeave,FocusLost,InsertEnter   * call RelativeNumberToggle('off')
			augroup END
		elseif state == 'disable'
			let g:number_toggle_on = 0
			augroup NumberToggle
				autocmd!
			augroup END
		endif
	endfunction

	lua vim.fn.SetNumberToggle('enable')

	" Improve terminal usage
	autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
	autocmd TermOpen * startinsert
	autocmd BufLeave term://* stopinsert
]])


--------------------------------------------------------------------------------
--      Miscellaneous
--------------------------------------------------------------------------------

-- Disable unneeded builtin plugins
local disabled_built_ins = { "netrw", "netrwPlugin", "netrwSettings",
	"netrwFileHandlers", "gzip", "zip", "zipPlugin", "tar", "tarPlugin",
	"getscript", "getscriptPlugin", "vimball", "vimballPlugin", "2html_plugin",
	"logipat", "rrhelper", "spellfile_plugin", "matchit" }

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end


--------------------------------------------------------------------------------
--      To Sort
--------------------------------------------------------------------------------

-- Not working:
--    vim.opt.foldtext = 'MyFoldText'
--
-- Alternatively:
--    vim.opt.foldmethod = 'expr'
--    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
--
vim.cmd([[
	function! MyFoldText()
		let line = getline(v:foldstart)

		let nucolwidth = &fdc + &number * &numberwidth
		let windowwidth = winwidth(0) - nucolwidth - 3

		let foldedlinecount = v:foldend - v:foldstart

		let line = strpart(line, 0, windowwidth - 40 - len(foldedlinecount))
		let fillcharcount = windowwidth - len(line) - len(foldedlinecount)

		"return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
		"return '      ' . repeat("-",windowwidth - 9) . '      '
		return ' ' . repeat("-",windowwidth - 9) . ' '
	endfunction
]])

-- Set comment string to // instead of /* */ when suitable.
vim.cmd('autocmd FileType c,cpp,cs,java,javascript,php setlocal commentstring=//\\ %s')

-- Add @ to iskeyword.
-- (Might cause problems? Was commented out.)
-- (Might not be needed? Was originally for coc-css.)
vim.cmd('autocmd FileType scss setl iskeyword+=@-@')

function Dump(o)
	if type(o) == 'table' then
		local str = '{ '
		for k,v in pairs(o) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			str = str .. '['..k..'] = ' .. Dump(v) .. ','
		end
		return str .. '} '
	else
		return tostring(o)
	end
end

vim.g.neoterm_automap_keys = '<F5>'
