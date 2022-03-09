--[[ Notes

	:bw

		Wipe all buffers from RAM.

	<Leader>b[etsv]

		Open/Toggle/-split/|split

		Then, b<Num> switches to buffer (bufexplorer)

	gb

		Custom keybinding for listing buffers and then going to a buffer quickly

	:mksession! ~/today.ses

		Saves session.

	vim -S ~/today.ses

		Load a session.

	--]]


-- Prep

	-- Change vim shell to zsh if current shell is fish.
	if vim.opt.shell['_value'] == 'fish' then
		vim.opt.shell = 'zsh'
	end


-- Plugins

	local Plug = vim.fn['plug#']

	vim.call('plug#begin', '~/.config/nvim/plug-plugins')

	-- LSP Plugins --

		Plug 'neovim/nvim-lspconfig'
		Plug 'williamboman/nvim-lsp-installer'


	-- Visual Interface Plugins

		Plug 'mbbill/undotree'  -- Browse the undo tree via <Leader>u

			-- Fixing bug I seem to get complaining that this isn't defined.
			vim.g.undotree_CursorLine = 1

		Plug 'kassio/neoterm'  -- Create and dismiss a (persistent) terminal

			vim.g.neoterm_default_mod = 'vertical'
			vim.g.neoterm_size = 60
			vim.g.neoterm_autoinsert = 1

		Plug 'sbdchd/neoformat'  -- Code auto-formatting

		Plug 'szw/vim-maximizer'  -- Maximize and unmaximize a split


	-- Finders

		Plug 'junegunn/fzf'  -- Gives :FZF[!] --preview=head\ -10\ {}, fzf#run, and fzf#wrap; Ctrl-[XV] to select into split/vsplit
		Plug 'junegunn/fzf.vim'  -- Gives :Ag, :Files, :Buffers, :Lines, :Tags

			vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }
			vim.g.fzf_prefer_tmux = 0

			-- Ignore file names when searching with Ag
			--   > command!
			--	      This allows us to redefine a command, here 'Ag'.
			--	      Without the !, we'd get an error for redefining it, as we'd
			--	      only be allowed to define a command for the first time.
			--	  > -bang
			--	      Allows us to add a ! to the end of the command (e.g. 'Ag!')
			--	      This is then passed as a boolean later via '<bang>0'.
			--	  > -nargs=*
			--	      Allows for any number of arguments to be passed; these are
			--	      passed later via '<q-args>'.
			--	  > Ag call fzf#vim#ag(...)
			--	      We are defining the command Ag, and it'll simply call the
			--	      function fzf#vim#ag with the arguments we passed to this
			--	      command (quoted) followed by some options and then whether
			--	      a bang was provided.
			--
			-- Ag command with various options being passed to fzf
			--   > --preview \"<command to run>\"
			--       This gives a preview window to the right; we run preview.sh
			--       and pass it to the file to preview
			--   > --bind \"<command>\"
			--       Toggle preview with ctrl-/
			--   > --delimiter :
			--       Set colon to be the delimiter
			--   > --nth 4..
			--       Ignores file names, somehow
			vim.cmd([[
			command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--preview "${HOME}/.vim/plug-plugins/fzf.vim/bin/preview.sh {}" --bind "ctrl-/:toggle-preview" --delimiter : --nth 4..'}, <bang>0)
			]])

		Plug 'jlanzarotta/bufexplorer'  -- <Leader>b[etsv] (open/toggle/-split/|split); then b<Num> switches to buffer


	-- Vim-Tmux Interaction

		Plug 'christoomey/vim-tmux-navigator'  -- Adds vim-tmux navigation comma

		Plug 'tpope/vim-tbone'  -- Adds Tyank, Tput, etc., and also <Leader>y

		Plug 'benmills/vimux'  -- Allows one to send commands when in Tmux (e.g. <Leader>vp, <Leader>vl, etc.)

		Plug('jtdowney/vimux-cargo', { branch = 'main' })  -- Adds <Leader>r[cabf] for cargo run/test all/unit test current file/focused

		Plug 'tmux-plugins/vim-tmux'  -- .tmux.conf: Syntax highlighting, correct comment string, `K` for `man tmux` jump to word under cursor, `:make`


	-- Vim-Git Interaction

		Plug 'airblade/vim-gitgutter'  -- Displays git symbols next to lines (]c, [c to navigate)

			vim.g.gitgutter_max_signs = 500
			vim.opt.updatetime = 100

			-- Get rid of <Leader>h-
			vim.g.gitgutter_map_keys = 0

			vim.cmd([[
			highlight GitGutterAdd    guifg=#009900 ctermfg=2 guibg=#aa0000 ctermbg=20
			highlight GitGutterChange guifg=#bbbb00 ctermfg=3 guibg=#aa0000 ctermbg=20
			highlight GitGutterDelete guifg=#ff2222 ctermfg=1 guibg=#aa0000 ctermbg=20
			]])

		Plug 'itchyny/vim-gitbranch'  -- Gives `gitbranch#name()`


	-- Convenience Plugins

		-- Manual

			Plug 'easymotion/vim-easymotion'  -- Adds <Leader><Leader>[swef...].

			Plug 'tpope/vim-surround'  -- ysiw) cs)] ds] etc.

			Plug 'junegunn/vim-easy-align'  -- gaip + =,*=,<space>.

			Plug 'tpope/vim-commentary'  -- gcc for line, gc otherwise (cmd-/ remapped too).

			Plug 'andymass/vim-matchup'  -- Extends % and adds [g[]zia]%.


		-- Automatic

			Plug 'tpope/vim-repeat'  -- Enables repeating surrounds and some other plugins.

			Plug 'jiangmiao/auto-pairs'  -- Automatically adds and removes paired brackets etc.


	-- Visuals

		Plug 'octol/vim-cpp-enhanced-highlight'  -- Improves C++ syntax highlighting.

		Plug 'StanAngeloff/php.vim'  -- Improves PHP syntax highlighting.

			vim.g.php_var_selector_is_identifier = 1

		Plug 'neovimhaskell/haskell-vim'

			vim.g.haskell_enable_quantification   = 1  -- Enables highlighting of `forall`.
			vim.g.haskell_enable_recursivedo      = 1  -- Enables highlighting of `mdo` and `rec`.
			vim.g.haskell_enable_arrowsyntax      = 1  -- Enables highlighting of `proc`.
			vim.g.haskell_enable_pattern_synonyms = 1  -- Enables highlighting of `pattern`.
			vim.g.haskell_enable_typeroles        = 1  -- Enables highlighting of type roles.
			vim.g.haskell_enable_static_pointers  = 1  -- Enables highlighting of `static`.
			vim.g.haskell_backpack                = 1  -- Enables highlighting of backpack keywords.

		Plug 'pangloss/vim-javascript'

		Plug 'tbastos/vim-lua'  -- Makes Lua syntax highlight not terribly buggy.

		Plug 'blankname/vim-fish'  -- Improves vim experience on .fish files

		Plug 'luochen1990/rainbow'  -- Rainbow parentheses matching.

			vim.g.rainbow_active = 1

		Plug 'unblevable/quick-scope'

			-- Trigger a highlight in the appropriate direction when pressing these keys:
			vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}

			-- augroup qs_colors
				-- autocmd!
				-- autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
				-- autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
			-- augroup END

			-- let g:qs_lazy_highlight = 1
			-- let g:qs_delay = 0


	-- Miscellaneous

		Plug 'lambdalisue/suda.vim'  -- Add SudaRead and SudaWrite for sudo reads and writes

		Plug 'editorconfig/editorconfig-vim'  -- Adds the ability to read .editorconfig files (see https://editorconfig.org/)


	vim.call('plug#end')


-- LSP Support

	local lsp_installer = require "nvim-lsp-installer"

	local servers = {
		'bashls',        -- bash
		'clangd',        -- C, C++
		'cmake',         -- CMake
		'cssls',         -- CSS
		'dockerls',      -- Docker
		'erlangls',      -- Erlang
		'hls',           -- Haskell
		'html',          -- HTML
		'intelephense',  -- PHP
		'pyright',       -- Python
		--'remark_ls',     -- Markdown
		'rust_analyzer', -- Rust
		'sumneko_lua',   -- Lua
		'taplo',         -- Toml
		'texlab',        -- LaTeX
		'tsserver',      -- Typescript, Javascript
		'vimls',         -- Vimscript
		'yamlls'         -- Yaml
	}

	-- Install any LSP servers we want which aren't installed.
	for _, name in pairs(servers) do
		local server_is_found, server = lsp_installer.get_server(name)
		if server_is_found and not server:is_installed() then
			print("Installing " .. name)
			server:install()
		end
	end

	lsp_installer.on_server_ready(function(server)

		-- Default options used for setting up all servers
		local opts = {
			--on_attach = on_attach,
		}

		if server.name == 'sumneko_lua' then
			opts.settings = {
				Lua = {
					diagnostics = { globals = {  'vim' } }
					}
				}
			end

		server:setup(opts)
	end)


-- General Setup

	-- To Sort; from vim-sensible

		vim.opt.smarttab = true

		vim.opt.laststatus = 2
		vim.opt.ruler = true
		vim.opt.wildmenu = true

		vim.opt.display = vim.opt.display + 'lastline'

		vim.opt.encoding = 'utf-8'

		vim.opt.autoread = true

		-- Delete comment character when joining commented lines.
		vim.opt.formatoptions = vim.opt.formatoptions + 'j'


	-- General

		-- Set update time for gitgutter, swap file, etc.
		vim.opt.updatetime = 1000

		-- Hide, instead of unloading, abandoned buffers.
		vim.opt.hidden = true

		-- Set the closest the cursor can get to the top/bottom before scrolling.
		vim.opt.scrolloff = 3

		-- Set the closest the cursor can get to the left/right before scrolling.
		vim.opt.sidescrolloff = 5

		-- Increase maximum number of tabs to 50.
		vim.opt.tabpagemax = 50

		-- Always show the signcolumn, otherwise it would shift the text each
		-- time diagnostics appear/become resolved.
		vim.opt.signcolumn = 'yes'

		-- Add 'yank' (y) to commands that can be repeated with '.'.
		vim.opt.cpoptions = vim.opt.cpoptions + 'y'

		-- highlight all search results.
		vim.opt.hlsearch = true

		-- Do case-insensitive search...
		vim.opt.ignorecase = true
		--
		-- ...unless we enter upper-case letters.
		vim.opt.smartcase = true

		-- Show incremental search results as you type.
		vim.opt.incsearch = true

		-- Add vertical to the vimdiff options, initially internal,filler,closeoff.
		vim.opt.diffopt = vim.opt.diffopt + 'vertical'

		-- Change from default of menu,preview
		--
		-- These settings require one to explicitly choose a competion, and
		-- otherwise will not autocomplete. This is desirable if the correct option
		-- is not there.
		--
		-- - menuone:  On trying to autocomplete (C-Space), give a menu (even if
		--             there's only one option.
		-- - noinsert: Do not select any text for a match until it's selected from
		--             the menu.
		-- - noselect: Don't select a match in the menu, require the user to select
		--             one from the menu.
		--
		vim.opt.completeopt = 'menuone,noinsert,noselect'

		-- Fold based on indentation.
		vim.opt.foldmethod = 'indent'
		vim.opt.foldminlines = 0
		vim.opt.foldlevel = 99

		-- Default split positions.
		vim.opt.splitbelow = true
		vim.opt.splitright = true

		vim.opt.viminfo = "'100,<1000,s100,h"
			-- '100  = Remember marks for the last 100 edited files.
			-- <1000 = Limit the number of lines saved for each register to 1000 lines.
			--         If a register contains more than 1000 lines, only the first 1000
			--         lines are saved.
			-- s100  = Skip registers with more than 100KB of text.
			-- h     = Disable search highlighting when vim starts.

		-- Allow backspacing over all of these.
		vim.opt.backspace = 'indent,eol,start'

		-- Preserve line ending currently existing in a file.
		vim.opt.fixendofline = false

	-- Input --

		-- Enable mouse in all modes
		vim.opt.mouse = 'a'

	-- Misc. --

		-- View keyword help in vimrc with K.
		vim.opt.keywordprg = ':help'

		-- Create no backup files nor swapfiles, ever.
		vim.opt.backup = false
		vim.opt.writebackup = false
		vim.opt.swapfile = false

		-- Remove netrw banner
		vim.g.netrw_banner = 0


-- Visuals

	vim.g.StatusLineGit = function()

		if vim.fn.exists('*gitbranch#name') then

			local branch_name = vim.fn['gitbranch#name']()

			if string.len(branch_name) > 0 then
				return '  ' .. branch_name .. ' '
			end
		end

		return ''
	end

	vim.opt.statusline = "%#StatusLine# %{StatusLineGit()} %f %y %{&fileencoding?&fileencoding:&encoding}:%{&fileformat} %h%w%m%r %#StatusLineNC#%=-%12.(%#StatusLine# %l,%c%V%) "
	-- Use hyphens to fill the statusline of current and non-current windows
	vim.opt.fillchars = vim.opt.fillchars + 'stl:-'
	vim.opt.fillchars = vim.opt.fillchars + 'stlnc:-'

	-- colorscheme codedark
	vim.cmd('colorscheme monokai')
	vim.cmd('set t_Co=256')
	vim.opt.termguicolors = true
	vim.g.monokai_term_italic = 1
	vim.g.monokai_gui_italic = 1

	vim.cmd('highlight MatchParen cterm=italic gui=italic')

	vim.cmd('syntax enable')
	vim.cmd('filetype on')          -- The 'filetype' option gets set on loading a file.
	vim.cmd('filetype plugin on')   -- Can use ~/.vim/ftplugin/ to add filetype-specific setup.
	vim.cmd('filetype indent on')   -- Can change the indentation depending on filetype.
	-- filetype indent off  -- Fix annoying auto-indent bug.

	vim.opt.number = true
	vim.opt.relativenumber = true

	vim.opt.wrap = true             -- Wrap lines (default).
	vim.opt.list = false            -- Don't show invisible characters (default).
	vim.opt.linebreak = true        -- Break between words, not in the middle of words.
	vim.opt.breakindent = true      -- Visually indent wrapped lines.
	vim.opt.breakindentopt = 'sbr'  -- Visually indent with the 'showbreak' option value.
	vim.opt.showbreak = '↪ '        -- What to show to indent wrapped lines.

	-- Ensure we show the number of matches for '/'.
	-- vim.opt.shortmess = string.gsub(vim.opt.shortmess, 'S', '')
	vim.cmd('set shortmess-=S')


	-- Sets which characters to show in the place of whitespace when using `:set
	-- list`.
	vim.opt.listchars = 'eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣'
	--set list

	-- Display a coloured column at 80, 100, and 120 characters.
	vim.opt.colorcolumn = {80, 100, 120}

	-- Syntax highlighting in markdown.
	vim.g.markdown_fenced_languages = {'html', 'python', 'vim'}

	-- Add highlighting to trailing whitespace and spaces before tabs, but not
	-- when typing on that line.
	vim.cmd('highlight ExtraWhitespace ctermbg=darkblue guibg=darkblue')
	vim.cmd('match ExtraWhitespace /\\s\\+$\\| \\+\\ze\\t/')

	-- Wizardry to prevent errors appearing while typing.
	vim.cmd('autocmd BufWinEnter * match ExtraWhitespace /\\s\\+$\\| \\+\\ze\\t/')
	vim.cmd('autocmd InsertEnter * match ExtraWhitespace /\\s\\+\\%#\\@<!$\\| \\+\\ze\\t\\%#\\@<!/')
	vim.cmd('autocmd InsertLeave * match ExtraWhitespace /\\s\\+$\\| \\+\\ze\\t/')
	vim.cmd('autocmd BufWinLeave * call clearmatches()')


	-- Automatically toggle relativenumber when leaving/entering insert mode.
	--
	-- Add a function for toggling it on/off
	vim.cmd([[
	function! SetNumberToggle(state)
		if a:state == 'enable'
			augroup NumberToggle
				autocmd!
				autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
				autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
			augroup END
		elseif a:state == 'disable'
			augroup NumberToggle
				autocmd!
			augroup END
		endif
	endfunction
	]])
	--
	-- Turn it on
	vim.fn.SetNumberToggle('enable')

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
	-- Not working:
	--vim.opt.foldtext = 'MyFoldText'


-- Indentation

	vim.opt.autoindent = true
	vim.opt.cindent = true
	vim.cmd('set cinkeys-=0#')

	-- Defaults
	vim.opt.expandtab = false
	vim.opt.shiftwidth = 3
	vim.opt.tabstop = 3
	vim.opt.softtabstop = 3

	-- Tab = 2 Spaces --
	--autocmd Filetype json       setlocal ts=2 sw=2 sts=2 noexpandtab
	--autocmd Filetype yaml       setlocal ts=2 sw=2 sts=2 expandtab

	-- Tab = 3 Spaces --
	vim.cmd('autocmd Filetype cpp        setlocal ts=3 sw=3 sts=3 noexpandtab')
	vim.cmd('autocmd Filetype zsh        setlocal ts=3 sw=3 sts=3 noexpandtab')

	-- Tab = 4 Spaces --
	vim.cmd('autocmd Filetype haskell    setlocal ts=4 sw=4 sts=4 expandtab')
	vim.cmd('autocmd Filetype yaml       setlocal ts=4 sw=4 sts=4 expandtab')
	vim.cmd('autocmd Filetype python     setlocal ts=4 sw=4 sts=4 expandtab')
	vim.cmd('autocmd Filetype markdown   setlocal ts=4 sw=4 sts=4 expandtab')


-- Key Mappings

	-- Set <Leader> to be <Space>.
	vim.g.mapleader = ' '

	-- Key Mapping Helpers

		function map(mode, shortcut, command)
			vim.api.nvim_set_keymap(mode, shortcut, command,
				{ noremap = true, silent = true })
		end

		function map_expr(mode, shortcut, command)
			vim.api.nvim_set_keymap(mode, shortcut, command,
				{ noremap = true, silent = true, expr = true })
		end

		function nmap(shortcut, command)
			map('n', shortcut, command)
		end

		function nmap_expr(shortcut, command)
			map_expr('n', shortcut, command)
		end

		function imap(shortcut, command)
			map('i', shortcut, command)
		end

		function imap_expr(shortcut, command)
			map_expr('i', shortcut, command)
		end

		function vmap(shortcut, command)
			map('v', shortcut, command)
		end

		function vmap_expr(shortcut, command)
			map_expr('v', shortcut, command)
		end

		function tmap(shortcut, command)
			map('t', shortcut, command)
		end

		function xmap(shortcut, command)
			map('x', shortcut, command)
		end

	-- In-Built

		-- Fundamental

			-- Swap ':' and ';'.
			-- We need these to not be silent, so keymap manually.
			vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })
			vim.api.nvim_set_keymap('v', ';', ':', { noremap = true })
			vim.api.nvim_set_keymap('n', ':', ';', { noremap = true })
			vim.api.nvim_set_keymap('v', ':', ';', { noremap = true })

			-- Set <Esc> to its normal job when in terminal mode (which can be
			-- emulated using Ctrl-\ Ctrl-n), instead of closing the terminal
			-- (except in fzf terminal; see autocmds).
			tmap('<Esc>', '<C-\\><C-n>')

			-- Write and quit.
			nmap('<leader>w', ':w<CR>')
			nmap('<Leader><Leader>w', ':w!<CR>')
			nmap('<Leader><Leader><Leader>w', ':w!!<CR>')
			nmap('<Leader>W', ':SudaWrite<CR>')
			nmap('<Leader>q', ':q<CR>')
			nmap('<Leader><Leader>q', ':q!<CR>')

			-- Move up and down via gj and gk by default unless a count is given.
			nmap_expr('j', '(v:count == 0 ? \'gj\' : \'j\')')
			nmap_expr('k', '(v:count == 0 ? \'gk\' : \'k\')')

			-- Keep n and N centred and unfolded
			nmap('n', 'nzzzv')
			nmap('N', 'Nzzzv')

		-- Navigation

			-- Same Buffer

				-- Fast up-down movement.
				nmap('<Leader>j', '10j')
				nmap('<Leader>k', '10k')

				-- Set <Leader>N to search for the next instance of the word under
				-- the cursor; much easier to do than *
				nmap('<Leader>N', '*')

				-- While in visual mode, use <Leader>/ to search for the selected text.
				-- vmap('<Leader>/', 'y/\V<C-R>=escape(@",'/\')<CR><CR>')
				vmap('<Leader>n', '*')

			-- Buffers --

				-- 'Previous' and 'next' Buffers.
				nmap('<Leader>h', ':bprev<CR>')
				nmap('<Leader>l', ':bnext<CR>')

				-- Go to most recent buffer.
				nmap('<Leader>bb', ':b#<CR>')

			-- Splits --

				-- Quickly create splits.
				nmap('<Leader>-', ':sp<CR>')
				nmap('<Leader><Bar>', ':vs<CR>')

			-- Tabs --

				-- Open in new tab.
				nmap('<Leader>z', ':tab sp<CR>')

				-- Switch between vim tabs.
				nmap('<Leader>1', '1gt')
				nmap('<Leader>2', '2gt')
				nmap('<Leader>3', '3gt')
				nmap('<Leader>4', '4gt')
				nmap('<Leader>5', '5gt')
				nmap('<Leader>6', '6gt')
				nmap('<Leader>7', '7gt')
				nmap('<Leader>8', '8gt')
				nmap('<Leader>9', '9gt')

			-- Files --

				-- Edit .vimrc
				nmap('<Leader>ve', ':e ~/.config/nvim/lua/config.lua<CR>')

				-- Reload .vimrc
				nmap('<Leader>vr', ':so ~/.config/nvim/lua/config.lua<CR>')

				-- Allow gf to edit non-existent files too
				nmap('gf', ':edit <cfile><CR>')

		-- Convenience

			-- Easy pasting previous yank (normal + visual).
			nmap('<Leader>p', '"0p')
			vmap('<Leader>p', '"0p')
			nmap('<Leader>P', '"0P')
			vmap('<Leader>P', '"0p')

			-- Reselect visual selection after indenting.
			vmap('<', '<gv')
			vmap('>', '>gv')

			-- Leak cursor in final location after visual yank.
			vmap('y', 'myy`y')
			vmap('Y', 'myY`y')

			-- Redo last macro.
			nmap('<Leader>.', '@@')

			-- Run q macro easily.
			-- This allows for qq<macro recording>q followed by Q.
			-- Overwrites initial Q mapping, which starts Ex mode.
			nmap('Q', '@q')
			vmap('Q', ':norm @q<CR>')

			-- Toggle paste
			nmap('<Leader>tp', ':set paste!<CR>')

			-- :noh shortcut
			nmap('<Leader>no', ':noh<CR>')

		-- Complex Functionality

			-- Use <Leader>d etc. to yank text into the yank register before
			-- deleting it.
			nmap('<Leader>dd', 'dd:let @0=@"<CR>')
			nmap('<Leader>D', 'D:let @0=@"<CR>')
			vmap('<Leader>d', 'd:let @0=@"<CR>')

			-- Move highlighted text (in visual mode) up and down using J and K.
			vmap('J', ":m '>+1<CR>gv=gv")
			vmap('K', ":m '<-2<CR>gv=gv")

			-- Repeat a macro 5000 times or until failure.
			nmap_expr('<Leader>Q', '"5000@" .. nr2char(getchar()) .. "\\<ESC>"')

			-- Reformat the entire file while leaving view position the same.
			--
			-- To do this, this key mapping creates two marks, q and w, to set
			-- current location and top row of view respectively, then formats the
			-- entire file, and finally moves back to the location of the cursor
			-- mark while setting the top of the view to the same place as before.
			-- This therefore overwrites marks q and w.
			--
			nmap('<Leader>=', 'mqHmwgg=G`wzt`q')

			-- Disable GUI for multi-line copying of vim contents by an external
			-- program.
			nmap('<Leader>0',
			     ':GitGutterDisable<CR>' ..
			     ':set nonumber norelativenumber nolinebreak nobreakindent signcolumn=no showbreak= <CR>' ..
			     ':call SetNumberToggle(\'disable\')<CR>')
			--
			-- Reenable GUI
			nmap('<Leader><Leader>0',
			     ':GitGutterEnable<CR>' ..
			     ':set number relativenumber linebreak breakindent signcolumn=yes showbreak=↪\\ <CR>' ..
			     ':call SetNumberToggle(\'enable\')<CR>')

		-- Visual

			nmap('<Leader><Leader>l', ':highlight ExtraWhitespace ctermbg=darkblue guibg=darkblue<CR>')
			nmap('<Leader><Leader>L', ':highlight ExtraWhitespace NONE<CR>')

		-- Misc

			--	Make Y behave like other capitals (default in Neovim 6.0+)
			nmap('Y', 'y$')


	-- Plugins

		-- Bufexplorer (<Leader>b[etsv])

			-- By default, adds:
			--    <Leader>b[etsv]  (open/toggle/-split/|split); then b<Num> switches to buffer


		-- Clap (<Leader>c[bcfgt])

			nmap('<Leader>cb', ':Clap blines<CR>')
			nmap('<Leader>cc', ':Clap commits<CR>')
			nmap('<Leader>cf', ':Clap files<CR>')
			nmap('<Leader>cg', ':Clap grep<CR>')
			nmap('<Leader>cl', ':Clap lines<CR>')
			nmap('<Leader>cg', ':Clap tags<CR>')


		-- Easy Align

			-- Start interactive EasyAlign in visual mode (e.g. vipga).
			xmap('ga', '<Plug>(EasyAlign)')

			-- Start interactive EasyAlign for a motion/text object (e.g. gaip).
			nmap('ga', '<Plug>(EasyAlign)')


		-- Easymotion

			-- By default, adds:
			--    <Leader><Leader>[swef...]


		-- FZF (<Leader>f[abfgl], <Leader>f![abfgl])

			-- (:FZF = :Files)
			nmap('<Leader>fa', ':Ag<CR>')
			nmap('<Leader>fb', ':BLines<CR>')
			nmap('<Leader>ff', ':GFiles<CR>')
			nmap('<Leader>fg', ':Files<CR>')
			nmap('<Leader>fl', ':Lines<CR>')
			nmap('<Leader>fr', ':Rg<CR>')

			nmap('<Leader>f!a', ':Ag!<CR>')
			nmap('<Leader>f!b', ':BLines!<CR>')
			nmap('<Leader>f!f', ':GFiles!<CR>')
			nmap('<Leader>f!g', ':Files!<CR>')
			nmap('<Leader>f!l', ':Lines!<CR>')
			nmap('<Leader>f!r', ':Rg!<CR>')

			-- Use <Ctrl-x><Ctrl-f> while in insert mode to auto-complete the path
			-- that the cursor is currently on using fzf.
			imap_expr('<C-x><C-f>', 'fzf#vim#complete#path(' ..
						 '"find . -path \'*/\\.*\' -prune -o -print \\| sed \'1d;s:^..::\'",' ..
						 'fzf#wrap({\'dir\': expand(\'%:p:h\')}))')

			-- inoremap <expr> <C-x><C-f> fzf#vim#complete#path(
			-- 	\ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
			-- 	\ fzf#wrap({'dir': expand('%:p:h')}))

		-- FZF-Hoogle

			nmap('<Leader>fh', ':Hoogle<CR>')


		-- Gitgutter

			-- Commented out to not conflict with <Leader>h...
			-- nunmap <Leader>hp
			-- nunmap <Leader>hu
			-- nunmap <Leader>hs

			-- Add floating preview window for <Leader>gg
			vim.g.gitgutter_preview_win_floating = 1

			nmap('[c', ':GitGutterPrevHunk<CR>')
			nmap(']c', ':GitGutterNextHunk<CR>')
			nmap('<Leader>gh', ':GitGutterPrevHunk<CR>')
			nmap('<Leader>gl', ':GitGutterNextHunk<CR>')
			nmap('<Leader>gg', ':GitGutterPreviewHunk<CR>')
			nmap('<Leader>gu', ':GitGutterUndoHunk<CR>')


		-- Lspconfig

			nmap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
			nmap('gh', '<cmd>lua vim.lsp.buf.hover()<CR>')
			nmap('gH', '<cmd>lua vim.lsp.buf.code_action()<CR>')
			nmap('gD', '<cmd>lua vim.lsp.buf.implementation()<CR>')
			nmap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
			nmap('gr', '<cmd>lua vim.lsp.buf.references()<CR>')
			nmap('gR', '<cmd>lua vim.lsp.buf.rename()<CR>')


		-- Maximizer (<Leader>m)

			nmap('<Leader>m', ':MaximizerToggle!<CR>')


		-- Neoformat (<Leader>F)

			nmap('<Leader>F', ':Neoformat prettier<CR>')


		-- Neoterm (Ctrl-q)

			nmap('<C-q>', ':Ttoggle<CR>')
			imap('<C-q>', '<Esc>:Ttoggle<CR>')
			tmap('<C-q>', '<C-\\><C-n>:Ttoggle<CR>')


		-- Tbone (<Leader>y)

			-- Functions

				-- Not currently working...
				-- getpos returns [0, 0, 0, 0]?

				 -- function tmux_load_buffer()
					-- -- Selection start and end arrays
					-- -- 2nd and 3rd entries of the array are the line number and column number.
					-- local s_start = vim.fn.getpos("'<")
					-- local s_end   = vim.fn.getpos("'>")
					-- print(dump(s_start))
					-- local start_line, start_col = s_start[2], s_start[3]
					-- local   end_line,   end_col =   s_end[2],   s_end[3]

					-- -- Get the lines from the start line to the end line, and remove the line
					-- -- contents before the start column and after the end column.
					-- local lines = vim.fn.getline(start_line, end_line)
					-- print(dump(lines))
					-- lines[1]      = string.sub(lines[1], start_col)
					-- lines[#lines] = string.sub(lines[#lines], 0, end_col)

					-- -- Write the resulting line contents to a temporary file, load it into the
					-- -- tmux buffer, and then delete the temporary file.
					-- local tempfile = vim.fn.tempname()
					-- vim.fn.writefile(lines, tempfile, 'a')
					-- vim.fn.system('tmux load-buffer ' .. tempfile)
					-- vim.fn.delete(tempfile)
				-- end

				 vim.cmd([[
					function! s:tmux_load_buffer()
						let [lnum1, col1] = getpos("'<")[1:2]
						let [lnum2, col2] = getpos("'>")[1:2]
						let lines = getline(lnum1, lnum2)
						let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
						let lines[0] = lines[0][col1 - 1:]
						let tempfile = tempname()
						call writefile(lines, tempfile, "a")
						call system('tmux load-buffer '.tempfile)
						call delete(tempfile)
					endfunction

					vnoremap <silent> <Leader>y :call <sid>tmux_load_buffer()<CR>
				 ]])

			-- tmux_load_buffer()
			-- vmap_expr('<Leader>y', 'v:lua.tmux_load_buffer()')
			-- vim.api.nvim_buf_set_keymap(0, 'v', '<Leader>y', 'v:lua.tmux_load_buffer()', { noremap = true, silent = true, expr = true })

			-- vim.cmd('vnoremap <silent> <Leader>y :call <sid>tmux_load_buffer()<CR>')
			-- vim.cmd('vnoremap <silent> <Leader>y :call tmux_load_buffer()<CR>')


		-- Tmux Navigator (Alt-[hjkl])

			vim.g.tmux_navigator_no_mappings = 1

			nmap('<M-h>', ':TmuxNavigateLeft<CR>')
			nmap('<M-j>', ':TmuxNavigateDown<CR>')
			nmap('<M-k>', ':TmuxNavigateUp<CR>')
			nmap('<M-l>', ':TmuxNavigateRight<CR>')
			nmap('<M-\\>', ':TmuxNavigatePrevious<CR>')


		-- Undotree (<Leader>u)

			nmap('<Leader>u', ':UndotreeToggle<CR>')


		-- Vimux (<Leader><Leader>v[rli])

			-- Prompt for a command to run.
			nmap('<Leader><Leader>vr', ':VimuxPromptCommand<CR>')

			-- Prompt for rereun last command.
			nmap('<Leader><Leader>vl', ':VimuxRunLastCommand<CR>')

			-- Inspect runner pane.
			nmap('<Leader><Leader>vi', ':VimuxInspectRunner<CR>')


-- Hooks

	-- Allow one to exit fzf using <Esc>
	--autocmd! TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
	vim.cmd('autocmd! FileType fzf tnoremap <buffer> <Esc> <Esc>')

	-- Disable Rainbow bracket matching for Lua, as it messes up comments of the
	-- form [[ ... ' ... ]].
	vim.cmd('autocmd FileType lua :RainbowToggleOff')
	vim.cmd('autocmd FileType php :RainbowToggleOff')

	-- Set comment string to // instead of /* */ when suitable.
	vim.cmd('autocmd FileType c,cpp,cs,java,javascript,php setlocal commentstring=//\\ %s')

	-- Add @ to iskeyword.
	-- (Might cause problems? Was commented out.)
	-- (Might not be needed? Was originally for coc-css.)
	vim.cmd('autocmd FileType scss setl iskeyword+=@-@')

	vim.cmd([[
	function! s:attempt_select_last_file() abort
		let l:previous=expand('#:t')
		if l:previous !=# ''
			call search('\v<' . l:previous . '>')
		endif
	endfunction
	]])

	-- Help debug syntax by providing `:call SynGroup()` to get the syntax group.
	vim.cmd([[
	function! SynGroup()
		let l:s = synID(line('.'), col('.'), 1)
		echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
	endfun
	]])


-- Helpers

	function dump(o)
		if type(o) == 'table' then
			local s = '{ '
			for k,v in pairs(o) do
				if type(k) ~= 'number' then k = '"'..k..'"' end
				s = s .. '['..k..'] = ' .. dump(v) .. ','
			end
			return s .. '} '
		else
			return tostring(o)
		end
	end
