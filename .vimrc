" == Notes ==
"
" Buffers:
" - A buffer is the in-memory text of a file.
" - A window is a viewport on a buffer.
" - A tab page is a collection of windows.
"
" Commands:
" :e <filename> (open file into new buffer, e.g. `:e src/**/F*Bar.js`)
" :bw (wipe (from RAM))
" <Leader>b[etsv] (open/toggle/-split/|split); then b<Num> switches to buffer (bufexplorer)
" gb - custom keybinding for listing buffers and then going to a buffer quickly
" :mksession! ~/today.ses  ->  vim -S ~/today.ses


" == Prep ==

	set nocompatible  " Break vi compatibility to behave in a more useful way.
	set runtimepath^=~/.vim
	let &packpath=&runtimepath

	" Change vim shell to zsh if current shell is fish.
	if &shell =~# 'fish$'
		set shell=zsh
	endif


" == Plugins ==

	" -- Preamble --

		" In case vim-plug is not installed:
		if empty(glob('~/.vim/autoload/plug.vim'))
			silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
			autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
		endif

		call plug#begin('~/.vim/plug-plugins')


	" -- LSP Plugins --



	" -- Visual Interface Plugins --

		Plug 'mbbill/undotree'  " Browse the undo tree via <Leader>u

			" Fixing bug I seem to get complaining that this isn't defined.
			let g:undotree_CursorLine = 1

		Plug 'kassio/neoterm'  " Create and dismiss a (persistent) terminal

			let g:neoterm_default_mod = 'vertical'
			let g:neoterm_size = 60
			let g:neoterm_autoinsert = 1

		Plug 'sbdchd/neoformat'  " Code auto-formatting

		Plug 'szw/vim-maximizer'  " Maximize and unmaximize a split


	" -- Finders --

		Plug 'junegunn/fzf'  " Gives :FZF[!] --preview=head\ -10\ {}, fzf#run, and fzf#wrap; Ctrl-[XV] to select into split/vsplit
		Plug 'junegunn/fzf.vim'  " Gives :Ag, :Files, :Buffers, :Lines, :Tags

			let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
			let g:fzf_prefer_tmux = 0

			" Ignore file names when searching with Ag
			" Ag command with various options being passed to fzf
			"   > --preview \"<command to run>\"
			"       This gives a preview window to the right; we run preview.sh
			"       and pass it to the file to preview
			"   > --bind \"<command>\"
			"       Toggle preview with ctrl-/
			"   > --delimiter :
			"       Set colon to be the delimiter
			"   > --nth 4..
			"       Ignores file names, somehow
			command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--preview "${HOME}/.vim/plug-plugins/fzf.vim/bin/preview.sh {}" --bind "ctrl-/:toggle-preview" --delimiter : --nth 4..'}, <bang>0)

		Plug 'jlanzarotta/bufexplorer'  " <Leader>b[etsv] (open/toggle/-split/|split); then b<Num> switches to buffer

		Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }  " Adds `:Clap <X>` commands (<Leader>c[bcfglt])

			" For example, `blines`,`commits`,`files`,`grep`,`lines`,`tags`.

			" The bang version of `install-binary` will try to download the
			" prebuilt binary if cargo does not exist.

			" Then run `call :clap#installer#build_all()` if `cargo` exists for
			" full Clap tooling


	" -- Vim-Tmux Interaction --

		Plug 'christoomey/vim-tmux-navigator'  " Adds vim-tmux navigation commands

		Plug 'tpope/vim-tbone'  " Adds Tyank, Tput, etc., and also <Leader>y

		Plug 'benmills/vimux'  " Allows one to send commands when in Tmux (e.g. <Leader>vp, <Leader>vl, etc.)

		Plug 'jtdowney/vimux-cargo', { 'branch': 'main' }  " Adds <Leader>r[cabf] for cargo run/test all/unit test current file/focused

		Plug 'tmux-plugins/vim-tmux'  " .tmux.conf: Syntax highlighting, correct comment string, `K` for `man tmux` jump to word under cursor, `:make`


	" -- Vim-Git Interaction --

		Plug 'airblade/vim-gitgutter'  " Displays git symbols next to lines (]c, [c to navigate)

			" Get rid of <Leader>h-
			let g:gitgutter_map_keys=0
			nnoremap [c <Plug>GitGutterPrevHunk
			nnoremap ]c <Plug>GitGutterNextHunk

			let g:gitgutter_max_signs = 500  " Default value
			set updatetime=100  " Increase speed of updating

			highlight GitGutterAdd    guifg=#009900 ctermfg=2 guibg=#aa0000 ctermbg=20
			highlight GitGutterChange guifg=#bbbb00 ctermfg=3 guibg=#aa0000 ctermbg=20
			highlight GitGutterDelete guifg=#ff2222 ctermfg=1 guibg=#aa0000 ctermbg=20

		Plug 'itchyny/vim-gitbranch'  " Gives `gitbranch#name()`


	" -- Convenience Plugins --

		" -- Manual --

			Plug 'easymotion/vim-easymotion'  " Adds <Leader><Leader>[swef...].

			Plug 'tpope/vim-surround'  " ysiw) cs)] ds] etc.

			Plug 'junegunn/vim-easy-align'  " gaip + =,*=,<space>.

			Plug 'tpope/vim-commentary'  " gcc for line, gc otherwise (cmd-/ remapped too).

			Plug 'andymass/vim-matchup'  " Extends % and adds [g[]zia]%.


		" -- Automatic --

			Plug 'tpope/vim-repeat'  " Enables repeating surrounds and some other plugins.

			Plug 'jiangmiao/auto-pairs'  " Automatically adds and removes paired brackets etc.


	" -- Visuals --

		Plug 'octol/vim-cpp-enhanced-highlight'  " Improves C++ syntax highlighting.

		Plug 'StanAngeloff/php.vim'  " Improves PHP syntax highlighting.

			let g:php_var_selector_is_identifier = 1

		Plug 'neovimhaskell/haskell-vim'

			let g:haskell_enable_quantification   = 1  " Enables highlighting of `forall`.
			let g:haskell_enable_recursivedo      = 1  " Enables highlighting of `mdo` and `rec`.
			let g:haskell_enable_arrowsyntax      = 1  " Enables highlighting of `proc`.
			let g:haskell_enable_pattern_synonyms = 1  " Enables highlighting of `pattern`.
			let g:haskell_enable_typeroles        = 1  " Enables highlighting of type roles.
			let g:haskell_enable_static_pointers  = 1  " Enables highlighting of `static`.
			let g:haskell_backpack                = 1  " Enables highlighting of backpack keywords.

		Plug 'pangloss/vim-javascript'

		Plug 'tbastos/vim-lua'  " Makes Lua syntax highlight not terribly buggy.

		Plug 'blankname/vim-fish'  " Improves vim experience on .fish files

		Plug 'luochen1990/rainbow'  " Rainbow parentheses matching.

			let g:rainbow_active = 1

		Plug 'unblevable/quick-scope'

			" Trigger a highlight in the appropriate direction when pressing these keys:
			let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

			" augroup qs_colors
			" 	autocmd!
			" 	autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
			" 	autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
			" augroup END

			" let g:qs_lazy_highlight = 1
			" let g:qs_delay = 0


	" -- Miscellaneous --

		Plug 'lambdalisue/suda.vim'  " Add SudaRead and SudaWrite for sudo reads and writes

		Plug 'editorconfig/editorconfig-vim'  " Adds the ability to read .editorconfig files (see https://editorconfig.org/)

		" Plug 'tpope/vim-sensible'

			" Manually pasting parts of vim-sensible to remove
			" 'filetype indent on' and other things I later set myself.

			set complete-=i

			set smarttab

			set nrformats-=octal

			if !has('nvim') && &ttimeoutlen == -1
			  set ttimeout
			  set ttimeoutlen=100
			endif

			" Use <C-L> to clear the highlighting of :set hlsearch.
			if maparg('<C-L>', 'n') ==# ''
			  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
			endif

			set laststatus=2
			set ruler
			set wildmenu

			set display+=lastline

			set encoding=utf-8

			if v:version > 703 || v:version == 703 && has("patch541")
			  set formatoptions+=j " Delete comment character when joining commented lines.
			endif

			if has('path_extra')
			  setglobal tags-=./tags tags-=./tags; tags^=./tags;
			endif

			if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
			  set shell=/usr/bin/env\ bash
			endif

			set autoread

			if &history < 1000
			  set history=1000
			endif

			if !empty(&viminfo)
			  set viminfo^=!
			endif

			set sessionoptions-=options
			set viewoptions-=options

			if empty(mapcheck('<C-U>', 'i'))
			  inoremap <C-U> <C-G>u<C-U>
			endif

			if empty(mapcheck('<C-W>', 'i'))
			  inoremap <C-W> <C-G>u<C-W>
			endif

	call plug#end()


" == General setup ==

	" -- General --

		" Set update time for gitgutter, swap file, etc.
		set updatetime=1000

		" Hide, instead of unloading, abandoned buffers.
		set hidden

		" Set the closest the cursor can get to the top/bottom before scrolling.
		set scrolloff=3

		" Set the closest the cursor can get to the left/right before scrolling.
		set sidescrolloff=5

		" Increase maximum number of tabs to 50.
		set tabpagemax=50

		" Always show the signcolumn, otherwise it would shift the text each
		" time diagnostics appear/become resolved.
		set signcolumn=yes

		" Add 'yank' (y) to commands that can be repeated with '.'.
		set cpoptions+=y

		" highlight all search results.
		set hlsearch

		" Do case-insensitive search...
		set ignorecase
		"
		" ...unless we enter upper-case letters.
		set smartcase

		" Show incremental search results as you type.
		set incsearch

		" Add vertical to the vimdiff options, initially internal,filler,closeoff.
		set diffopt+=vertical

		" Change from default of menu,preview
		"
		" These settings require one to explicitly choose a competion, and
		" otherwise will not autocomplete. This is desirable if the correct option
		" is not there.
		"
		" - menuone:  On trying to autocomplete (C-Space), give a menu (even if
		"             there's only one option.
		" - noinsert: Do not select any text for a match until it's selected from
		"             the menu.
		" - noselect: Don't select a match in the menu, require the user to select
		"             one from the menu.
		"
		set completeopt=menuone,noinsert,noselect

		" Fold based on indentation.
		set foldmethod=indent
		set foldminlines=0
		set foldlevel=99

		" Default split positions.
		set splitbelow
		set splitright

		set viminfo='100,<1000,s100,h
			" '100  = Remember marks for the last 100 edited files.
			" <1000 = Limit the number of lines saved for each register to 1000 lines.
			"         If a register contains more than 1000 lines, only the first 1000
			"         lines are saved.
			" s100  = Skip registers with more than 100KB of text.
			" h     = Disable search highlighting when vim starts.

		" Allow backspacing over all of these.
		set backspace=indent,eol,start

		" Preserve line ending currently existing in a file.
		set nofixendofline

	" -- Input --

		" Enable mouse in all modes
		set mouse=a
		if !has('nvim')
			set ttymouse=xterm2
		endif

	" -- Misc. --

		" View keyword help in vimrc with K.
		set keywordprg=:help

		" Create no backup files nor swapfiles, ever.
		set nobackup nowritebackup
		set noswapfile

		" Remove netrw banner
		let g:netrw_banner=0


" == Visuals ==

	function! StatuslineGit()
		" Check whether vim-gitbranch is loaded (which gives gitbranch#name())
		" before continuing.
		if exists("*gitbranch#name")
			let l:branchname = gitbranch#name()
			return strlen(l:branchname) > 0 ? '  ' . l:branchname . ' ' : ''
		else
			return ''
		endif
	endfunction

	set statusline=%#StatusLine#\ %{StatuslineGit()}\ %f\ %y\ %{&fileencoding?&fileencoding:&encoding}:%{&fileformat}\ %h%w%m%r\ %#StatusLineNC#%=-%12.(%#StatusLine#\ %l,%c%V%)\ 
	set fillchars+=stl:-
	set fillchars+=stlnc:-

	" colorscheme codedark
	colorscheme monokai
	set t_Co=256
	set termguicolors
	let g:monokai_term_italic = 1
	let g:monokai_gui_italic = 1

	hi MatchParen cterm=italic gui=italic

	syntax enable
	filetype on          " The 'filetype' option gets set on loading a file.
	filetype plugin on   " Can use ~/.vim/ftplugin/ to add filetype-specific setup.
	filetype indent on   " Can change the indentation depending on filetype.
	" filetype indent off  " Fix annoying auto-indent bug.

	set number relativenumber

	" Automatically toggle relativenumber when leaving/entering insert mode.
	"
	" Add a function for toggling it on/off
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
	"
	" Turn it on
	call SetNumberToggle('enable')

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
	"set foldtext=MyFoldText()

	set wrap                " Wrap lines (default).
	set nolist              " Don't show invisible characters (default).
	set linebreak           " Break between words, not in the middle of words.
	set breakindent         " Visually indent wrapped lines.
	set breakindentopt=sbr  " Visually indent with the 'showbreak' option value.
	set showbreak=↪\        " What to show to indent wrapped lines.
	set shortmess-=S        " Ensure we show the number of matches for '/'.

	" Sets which characters to show in the place of whitespace when using `:set
	" list`.
	set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
	"set list

	" Display a coloured column at 100 characters.
	set colorcolumn=80,100,120

	" Syntax highlighting in markdown.
	let g:markdown_fenced_languages = ['html', 'python', 'vim']

	" Add highlighting to trailing whitespace and spaces before tabs, but not
	" when typing on that line.
	highlight ExtraWhitespace ctermbg=darkblue guibg=darkblue
	match ExtraWhitespace /\s\+$\| \+\ze\t/

	" Wizardry to prevent errors appearing while typing.
	autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
	autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$\| \+\ze\t\%#\@<!/
	autocmd InsertLeave * match ExtraWhitespace /\s\+$\| \+\ze\t/
	autocmd BufWinLeave * call clearmatches()


" == Indentation ==

	set autoindent
	set nocindent cinkeys-=0#

	" Defaults
	set noexpandtab shiftwidth=3 tabstop=3 softtabstop=3

	" -- Tab = 2 Spaces --
	"autocmd Filetype json       setlocal ts=2 sw=2 sts=2 noexpandtab
	" autocmd Filetype yaml       setlocal ts=2 sw=2 sts=2 expandtab

	" -- Tab = 3 Spaces --
	autocmd Filetype cpp        setlocal ts=3 sw=3 sts=3 noexpandtab
	autocmd Filetype zsh        setlocal ts=3 sw=3 sts=3 noexpandtab

	" -- Tab = 4 Spaces --
	autocmd Filetype haskell    setlocal ts=4 sw=4 sts=4 expandtab
	autocmd Filetype yaml       setlocal ts=4 sw=4 sts=4 expandtab
	autocmd Filetype python      setlocal ts=4 sw=4 sts=4 expandtab
	autocmd Filetype markdown   setlocal ts=4 sw=4 sts=4 expandtab


" == Key Mappings ==

	" Set <Leader> to be <Space>.
	let mapleader = " "

	" -- In-built --

		" -- Fundamental --

			" Swap ':' and ';'.
			nnoremap ; :
			vnoremap ; :
			nnoremap : ;
			vnoremap : ;

			" Set <Esc> to its normal job when in terminal mode (which can be
			" emulated using Ctrl-\ Ctrl-n), instead of closing the terminal
			" (except in fzf terminal; see autocmds).
			tnoremap <Esc> <C-\><C-n>

			" Write and quit.
			nnoremap <Leader>w :w<CR>
			nnoremap <Leader><Leader>w :w!<CR>
			nnoremap <Leader><Leader><Leader>w :w!!<CR>
			nnoremap <Leader>W :SudaWrite<CR>
			nnoremap <Leader>q :q<CR>
			nnoremap <Leader><Leader>q :q!<CR>

			" Move up and down via gj and gk by default unless a count is given.
			noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
			noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

			" Keep n and N centred and unfolded
			nnoremap <silent> n nzzzv
			nnoremap <silent> N Nzzzv


		" -- Navigation --

			" -- Same Buffer --

				" Fast up-down movement.
				nnoremap <Leader>j 10j
				nnoremap <Leader>k 10k

				" Set <Leader>N to search for the next instance of the word under
				" the cursor; much easier to do than *
				nnoremap <silent> <Leader>N *

				" While in visual mode, use <Leader>/ to search for the selected text.
				vnoremap <silent> <Leader>/ y/\V<C-R>=escape(@",'/\')<CR><CR>
				vnoremap <silent> <Leader>n *

			" -- Buffers --

				" 'Previous' and 'next' Buffers.
				nnoremap <Leader>h :bprev<CR>
				nnoremap <Leader>l :bnext<CR>

				" Go to most recent buffer.
				nnoremap <Leader>bb :b#<CR>

			" -- Splits --

				" Quickly create splits.
				nnoremap <Leader>- :sp<CR>
				nnoremap <Leader><Bar> :vs<CR>

			" -- Tabs --

				" Open in new tab.
				nnoremap <Leader>z :tab sp<CR>

				" Switch between vim tabs.
				nnoremap <Leader>1 1gt
				nnoremap <Leader>2 2gt
				nnoremap <Leader>3 3gt
				nnoremap <Leader>4 4gt
				nnoremap <Leader>5 5gt
				nnoremap <Leader>6 6gt
				nnoremap <Leader>7 7gt
				nnoremap <Leader>8 8gt
				nnoremap <Leader>9 9gt

			" -- Files --

				" Edit .vimrc
				nnoremap <Leader>ve :e ~/.vimrc<CR>

				" Reload .vimrc
				nnoremap <Leader>vr :so ~/.vimrc<CR>

				" Allow gf to edit non-existent files too
				noremap gf :edit <cfile><CR>


		" -- Convenience --

			" Easy pasting previous yank (normal + visual).
			nnoremap <Leader>p "0p
			vnoremap <Leader>p "0p
			nnoremap <Leader>P "0P
			vnoremap <Leader>P "0p

			" Reselect visual selection after indenting.
			vnoremap < <gv
			vnoremap > >gv

			" Leak cursor in final location after visual yank.
			vnoremap y myy`y
			vnoremap Y myY`y

			" Redo last macro.
			nnoremap <Leader>. @@

			" Run q macro easily.
			" This allows for qq<macro recording>q followed by Q.
			" Overwrites initial Q mapping, which starts Ex mode.
			nnoremap Q @q
			vnoremap Q :norm @q<CR>

			" Toggle paste
			nnoremap <silent> <Leader>tp :set paste!<CR>

			" :noh shortcut
			nnoremap <silent> <Leader>no :noh<CR>


		" -- Complex Functionality --

			" Use <Leader>d etc. to yank text into the yank register before
			" deleting it.
			nnoremap <silent> <Leader>dd dd:let @0=@"<CR>
			nnoremap <silent> <Leader>D D:let @0=@"<CR>
			vnoremap <silent> <Leader>d d:let @0=@"<CR>

			" Move highlighted text (in visual mode) up and down using J and K.
			vnoremap J :m '>+1<CR>gv=gv
			vnoremap K :m '<-2<CR>gv=gv

			" Repeat a macro 5000 times or until failure.
			nnoremap <silent> <expr> <Leader>Q "5000@" . nr2char(getchar()) . "\<ESC>"

			" Reformat the entire file while leaving view position the same.
			"
			" To do this, this key mapping creates two marks, q and w, to set
			" current location and top row of view respectively, then formats the
			" entire file, and finally moves back to the location of the cursor
			" mark while setting the top of the view to the same place as before.
			" This therefore overwrites marks q and w.
			"
			nnoremap <Leader>= mqHmwgg=G`wzt`q

			" Disable GUI for multi-line copying of vim contents by an external
			" program.
			nnoremap <silent> <Leader>0
				\ :set nonumber norelativenumber nolinebreak nobreakindent signcolumn=no showbreak= <CR>
				\:GitGutterDisable<CR>
				\:call SetNumberToggle('disable')<CR>
			"
			" Reenable GUI
			nnoremap <silent> <Leader><Leader>0
				\ :set number relativenumber linebreak breakindent signcolumn=yes showbreak=↪\ <CR>
				\:GitGutterEnable<CR>
				\:call SetNumberToggle('enable')<CR>


		" -- Misc --

			" Make Y behave like other capitals (default in Neovim 6.0+)
			nnoremap Y y$


	" -- Plugins --

		" -- Bufexplorer (<Leader>b[etsv]) --
			" By default, adds:
			"    <Leader>b[etsv]  (open/toggle/-split/|split); then b<Num> switches to buffer


		" -- Clap (<Leader>c[bcfgt]) --

			nnoremap <Leader>cb :Clap blines<CR>
			nnoremap <Leader>cc :Clap commits<CR>
			nnoremap <Leader>cf :Clap files<CR>
			nnoremap <Leader>cg :Clap grep<CR>
			nnoremap <Leader>cl :Clap lines<CR>
			nnoremap <Leader>cg :Clap tags<CR>


		" -- Easy Align --

			" Start interactive EasyAlign in visual mode (e.g. vipga).
			xnoremap ga <Plug>(EasyAlign)

			" Start interactive EasyAlign for a motion/text object (e.g. gaip).
			nnoremap ga <Plug>(EasyAlign)


		" -- Easymotion --

			" By default, adds:
			"    <Leader><Leader>[swef...]


		" -- FZF (<Leader>f[abfgl], <Leader>f![abfgl]) --

			" (:FZF = :Files)
			nnoremap <Leader>fa :Ag<CR>
			nnoremap <Leader>fb :BLines<CR>
			nnoremap <Leader>ff :GFiles<CR>
			nnoremap <Leader>fg :Files<CR>
			nnoremap <Leader>fl :Lines<CR>
			nnoremap <Leader>fr :Rg<CR>

			nnoremap <Leader>f!a :Ag!<CR>
			nnoremap <Leader>f!b :BLines!<CR>
			nnoremap <Leader>f!f :GFiles!<CR>
			nnoremap <Leader>f!g :Files!<CR>
			nnoremap <Leader>f!l :Lines!<CR>
			nnoremap <Leader>f!r :Rg!<CR>

			" Use <Ctrl-x><Ctrl-f> while in insert mode to auto-complete the path
			" that the cursor is currently on using fzf.
			inoremap <expr> <C-x><C-f> fzf#vim#complete#path(
				\ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
				\ fzf#wrap({'dir': expand('%:p:h')}))


		" -- FZF-Hoogle --

			nnoremap <Leader>fh :Hoogle<CR>


		" -- Gitgutter --

			" Commented out to not conflict with <Leader>h...
			" nunmap <Leader>hp
			" nunmap <Leader>hu
			" nunmap <Leader>hs

			" Add floating preview window for <Leader>gg
			let g:gitgutter_preview_win_floating = 1

			nnoremap <Leader>gh :GitGutterPrevHunk<CR>
			nnoremap <Leader>gl :GitGutterNextHunk<CR>
			nnoremap <Leader>gg :GitGutterPreviewHunk<CR>
			nnoremap <Leader>gu :GitGutterUndoHunk<CR>


		" -- Maximizer (<Leader>m) --

			nnoremap <Leader>m :MaximizerToggle!<CR>


		" -- Neoformat (<Leader>F) --

			nnoremap <Leader>F :Neoformat prettier<CR>


		" -- Neoterm (Ctrl-q) --

			nnoremap <C-q> :Ttoggle<CR>
			inoremap <C-q> <Esc>:Ttoggle<CR>
			tnoremap <C-q> <C-\><C-n>:Ttoggle<CR>


		" -- Tbone (<Leader>y) --

			" -- Functions --

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


		" -- Tmux Navigator (Alt-[hjkl]) --

			let g:tmux_navigator_no_mappings = 1

			nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
			nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
			nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
			nnoremap <silent> <M-l> :TmuxNavigateRight<CR>
			nnoremap <silent> <M-\> :TmuxNavigatePrevious<CR>


		" -- Undotree (<Leader>u) --

			nnoremap <silent> <Leader>u :UndotreeToggle<CR>


		" -- Vimux (<Leader><Leader>v[rli]) --

			" Prompt for a command to run.
			nnoremap <silent> <Leader><Leader>vr :VimuxPromptCommand<CR>

			" Prompt for rereun last command.
			nnoremap <silent> <Leader><Leader>vl :VimuxRunLastCommand<CR>

			" Inspect runner pane.
			nnoremap <silent> <Leader><Leader>vi :VimuxInspectRunner<CR>


" == Hooks ==

	function! s:attempt_select_last_file() abort
		let l:previous=expand('#:t')
		if l:previous !=# ''
			call search('\v<' . l:previous . '>')
		endif
	endfunction

	" Allow one to exit fzf using <Esc>
	if has('nvim')
		" autocmd! TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
		autocmd! FileType fzf tnoremap <buffer> <Esc> <Esc>
	endif

	" Disable Rainbow bracket matching for Lua, as it messes up comments of the
	" form [[ ... ' ... ]].
	autocmd FileType lua :RainbowToggleOff
	autocmd FileType php :RainbowToggleOff

	" Set comment string to // instead of /* */ when suitable.
	autocmd FileType c,cpp,cs,java,javascript,php setlocal commentstring=//\ %s

	" Add @ to iskeyword.
	" (Might cause problems? Was commented out.)
	" (Might not be needed? Was originally for coc-css.)
	autocmd FileType scss setl iskeyword+=@-@

	" Help debug syntax by providing `:call SynGroup()` to get the syntax
	" group.
	function! SynGroup()
		let l:s = synID(line('.'), col('.'), 1)
		echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
	endfun
