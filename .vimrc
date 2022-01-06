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


	" -- Code Comprehension Plugins --

		" Plug 'neoclide/coc.nvim', {'branch': 'release'}  " LSP support

		" 	" Use tab for trigger completion with characters ahead and navigate.
		" 	inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
		" 	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

		" 	function! s:check_back_space() abort
		" 		let col = col('.') - 1
		" 		return !col || getline('.')[col - 1]  =~# '\s'
		" 	endfunction

		" 	" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
		" 	" position. Coc only does snippet and additional edit on confirm.
		" 	if has('patch8.1.1068')
		" 		" Use `complete_info` if your (Neo)Vim version supports it.
		" 		"inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
		" 	else
		" 		imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
		" 	endif

		" Plug 'liuchengxu/vista.vim'  " <Leader>t

		" 	let g:vista#executives = ['coc']
		" 	let g:vista_default_executive = 'coc'
		" 	let g:vista#renderer#enable_icon = 0
		" 	let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]


	" -- Visual Interface Plugins --

		Plug 'preservim/nerdtree'  " :NERDTreeToggle, or <Leader>nf (remapped).

			let g:NERDTreeStatusline = '%#NonText#'  " No status line in NERDTree split.
			let g:NERDTreeShowLineNumbers=1          " Enable line numbers.
			let g:NERDTreeMinimalUI = 1              " Remove '" Press ? for help' text.
			let g:NERDTreeWinSize=31                 " The default is 31; this is here for later
			                                         "     modification.
			let g:NERDTreeMouseMode=2                " Single-click to toggle directory nodes,
			                                         "     double-click to open non-directory nodes.
			let g:NERDTreeCreatePrefix='silent keepalt keepjumps'

			" Ignore certain files by name in NERDTree.
			set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*
			let NERDTreeRespectWildIgnore=1

			autocmd FileType nerdtree setlocal nonumber relativenumber  " Use relative line numbers

			" NERDTree file highlighting
			"function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
			"	exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
			"	exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
			"endfunction

			" Examples
			"call NERDTreeHighlightFile('md',   'blue',   'none', '#3366FF', '#151515')
			"call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow',  '#151515')
			"call NERDTreeHighlightFile('styl', 'cyan',   'none', 'cyan',    '#151515')

		Plug 'mbbill/undotree'  " Browse the undo tree via <Leader>u

			" Fixing bug I seem to get complaining that this isn't defined.
			let g:undotree_CursorLine = 1

		" Plug 'monkoose/fzf-hoogle.vim'  " Gives :Hoogle


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
			nmap [c <Plug>GitGutterPrevHunk
			nmap ]c <Plug>GitGutterNextHunk

			let g:gitgutter_max_signs = 500  " Default value
			set updatetime=100  " Increase speed of updating

			highlight GitGutterAdd    guifg=#009900 ctermfg=2
			highlight GitGutterChange guifg=#bbbb00 ctermfg=3
			highlight GitGutterDelete guifg=#ff2222 ctermfg=1

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

			" Plug 'jiangmiao/auto-pairs'  " Automatically adds and removes paired brackets etc.

			" Plug 'tpope/vim-endwise'  " Automatically add endings.

				" let g:endwise_no_mappings = v:true  " disable mapping to not break coc.nvim.


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

			set incsearch
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

		" Remove 'insert mode -> command mode' lag after pressing escape.
		"set noesckeys

		" Store temporary files in a central spot.
		"let &backupdir = $HOME . '/.vim/backup//'
		"let &directory = $HOME . '/.vim/swapfiles//'

		" Don't pass messages to |ins-completion-menu|?
		set shortmess-=c

		" Always show the signcolumn, otherwise it would shift the text each
		" time diagnostics appear/become resolved.
		set signcolumn=yes

		" Add 'yank' (y) to commands that can be repeated with '.'.
		set cpoptions+=y

		" highlight all search results.
		set hlsearch

		"  Do case-insensitive search.
		set ignorecase

		" Show incremental search results as you type.
		set incsearch

		" Change from default of menu,preview
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
	set notermguicolors
	let g:monokai_term_italic = 1
	let g:monokai_gui_italic = 1

	hi MatchParen cterm=italic gui=italic

	syntax enable
	filetype on          " The 'filetype' option gets set on loading a file.
	filetype plugin on   " Can use ~/.vim/ftplugin/ to add filetype-specific setup.
	" filetype indent on " Can change the indentation depending on filetype.
	filetype indent off  " Fix annoying auto-indent bug.

	set number relativenumber

	" Automatically toggle relativenumber when leaving/entering insert mode.
	augroup numbertoggle
		autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
		autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
	augroup END

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
	autocmd Filetype markdown   setlocal ts=4 sw=4 sts=4 expandtab


" == Key Mappings ==

	" -- In-built --

		" Set <Leader> to be <Space>.
		let mapleader = " "

		" Swap ':' and ';'.
		nnoremap ; :
		vnoremap ; :
		nnoremap : ;
		vnoremap : ;

		" Set <Esc> to its normal job when in terminal mode, instead of
		" 'C-\,C-n'.
		tnoremap <Esc> <C-\><C-n>

		" Write and quit.
		nnoremap <Leader>w :w<CR>
		nnoremap <Leader><Leader>w :w!<CR>
		nnoremap <Leader><Leader><Leader>w :w!!<CR>
		nnoremap <Leader>q :q<CR>
		nnoremap <Leader><Leader>q :q!<CR>

		" Open in new tab.
		nnoremap <Leader>z :tab sp<CR>

		" Quickly create splits.
		nnoremap <Leader>- :sp<CR>
		nnoremap <Leader><Bar> :vs<CR>

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

		" List buffers and prepare to move to one.
		nnoremap gb :ls<CR>:b<space>

		" 'Previous' and 'next' Buffers.
		nnoremap <Leader>h :bprev<CR>
		nnoremap <Leader>l :bnext<CR>

		" Go to most recent buffer.
		nnoremap <Leader>bb :b#<CR>

		" Fast up-down movement.
		nnoremap <Leader>j 10j
		nnoremap <Leader>k 10k

		" Easy pasting previous yank.
		nnoremap <Leader>p "0p
		nnoremap <Leader>P "0P
		" Include this when pasting in visual mode (e.g. over selected text)
		vnoremap <Leader>p "0p
		vnoremap <Leader>P "0p

		" Redo last macro.
		nnoremap <Leader>. @@

		" Run q macro easily.
		" This allows for qq<macro recording>q followed by Q.
		" Overwrites initial Q mapping, which starts Ex mode.
		nnoremap Q @q
		vnoremap Q :norm @q<CR>

		" Toggle GUI for multi-line copying of vim contents by external program.
		nnoremap <Leader>0 :set nonumber norelativenumber nolinebreak nobreakindent signcolumn=no showbreak= <CR>:GitGutterDisable<CR>
		nnoremap <Leader><Leader>0 :set number relativenumber linebreak breakindent signcolumn=yes showbreak=↪\ <CR>:GitGutterEnable<CR>

		" Quickly toggle fold.
		nnoremap <Leader>t za
		nnoremap <Leader>T zA

		" Toggle 'paste' setting with.
		nnoremap <Leader>tp :set paste!<CR>

		" Create two marks, q and w, to set current location and top row of view
		" respectively, then format the entire file, and finally move back to the
		" location of the cursor mark while setting the top of the view to the
		" same place as before.
		" This therefore overwrites marks q and w.
		nnoremap <Leader>= mqHmwgg=G`wzt`q

		" Move highlighted text (in visual mode) up and down using J and K.
		vnoremap J :m '>+1<CR>gv=gv
		vnoremap K :m '<-2<CR>gv=gv

		" Remove highlighting.
		nnoremap <Leader>no :noh<CR>


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


		" -- Coc ([g,]g) --

			" Use `[g` and `]g` to navigate diagnostics.
			nmap <Leader>[ <Plug>(coc-diagnostic-prev)
			nmap <Leader>] <Plug>(coc-diagnostic-next)

			" Use <c-space> to trigger completion.
			inoremap <silent><expr> <c-space> coc#refresh()

			" GoTo code navigation.
			nmap <silent> gd <Plug>(coc-definition)
			nmap <silent> gy <Plug>(coc-type-definition)
			nmap <silent> gi <Plug>(coc-implementation)
			nmap <silent> gr <Plug>(coc-references)

			" Use K to show documentation in preview window.
			nnoremap <silent> K :call <SID>show_documentation()<CR>

			function! s:show_documentation()
				if (index(['vim','help'], &filetype) >= 0)
					execute 'h '.expand('<cword>')
				else
					call CocAction('doHover')
				endif
			endfunction

			" Remap for rename current word.
			nmap <Leader>rn <Plug>(coc-rename)

			" Easily toggle diagnostics.
			nnoremap <Leader>ct :call CocAction('diagnosticToggle')<CR>

			" Formatting selected code.
			xmap <Leader>f=  <Plug>(coc-format-selected)
			nmap <Leader>f=  <Plug>(coc-format-selected)

			" Use <Leader>gs to switch between hpp and cpp.
			function! s:EditAlternate()
				let l:alter = CocRequest('clangd', 'textDocument/switchSourceHeader', {'uri': 'file://' . expand("%:p")})

				" Remove file:// from response.
				let l:alter = substitute(l:alter, "file://", "", "")

				execute 'edit ' . l:alter
			endfunction

			autocmd FileType cpp nnoremap <silent> <Leader>gs :call <SID>EditAlternate()<CR>


		" -- Easy Align --

			" Start interactive EasyAlign in visual mode (e.g. vipga).
			xmap ga <Plug>(EasyAlign)

			" Start interactive EasyAlign for a motion/text object (e.g. gaip).
			nmap ga <Plug>(EasyAlign)


		" -- Easymotion --

			" By default, adds:
			"    <Leader><Leader>[swef...]


		" -- FZF (<Leader>f[abfgl], <Leader>f![abfgl]) --

			" (:FZF = :Files)
			nnoremap <Leader>fa :Ag<CR>
			nnoremap <Leader>fb :BLines<CR>
			nnoremap <Leader>ff :Files<CR>
			nnoremap <Leader>fg :GFiles<CR>
			nnoremap <Leader>fl :Lines<CR>

			nnoremap <Leader>f!a :Ag!<CR>
			nnoremap <Leader>f!b :BLines!<CR>
			nnoremap <Leader>f!f :Files!<CR>
			nnoremap <Leader>f!g :GFiles!<CR>
			nnoremap <Leader>f!l :Lines!<CR>


		" -- FZF-Hoogle --

			nnoremap <Leader>fh :Hoogle<CR>


		" -- Gitgutter --

			" Commented out to not conflict with <Leader>h...
			" nunmap <Leader>hp
			" nunmap <Leader>hu
			" nunmap <Leader>hs


		" -- NERDTree (<Leader>n[fv], -) --

			" Toggle NERDTree with <Leader>nf.
			nnoremap <silent> <Leader>nf :NERDTreeToggle<CR>

			" Find current file being editted in NERDTree with <Leader>nv.
			nnoremap <silent> <Leader>nv :NERDTreeFind<CR>

			" Press - in command mode to go up one directory.
			" For some reason this currently isn't working...
			nnoremap <silent> - :silent edit <C-R>=empty(expand('%')) ? '.' : fnameescape(expand('%:p:h'))<CR><CR>


		" -- Tbone (<Leader>y) --

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

			nnoremap <Leader>u :UndotreeToggle<CR>


		" -- Vimux (<Leader>v[rli]) --

			" Prompt for a command to run.
			nnoremap <Leader>vr :VimuxPromptCommand<CR>

			" Prompt for rereun last command.
			nnoremap <Leader>vl :VimuxRunLastCommand<CR>

			" Inspect runner pane.
			nnoremap <Leader>vi :VimuxInspectRunner<CR>


		" -- Vista (<Leader>t) --

			nnoremap <Leader>t :Vista!!<CR>


" == Hooks ==

	augroup vimrc_hooks
		 au!
		" Source .vimrc after writing .vimrc.
		 autocmd bufwritepost .vimrc source ~/.vimrc
	augroup END

	function! s:attempt_select_last_file() abort
		let l:previous=expand('#:t')
		if l:previous !=# ''
			call search('\v<' . l:previous . '>')
		endif
	endfunction

	if has('autocmd')
		augroup WincentNERDTree
			autocmd!
			autocmd User NERDTreeInit call s:attempt_select_last_file()
		augroup END
	endif

	" Disable Rainbow bracket matching for Lua, as it messes up comments of the
	" form [[ ... ' ... ]].
	autocmd FileType lua :RainbowToggleOff
	autocmd FileType php :RainbowToggleOff

	" Set comment string to // instead of /* */ when suitable.
	autocmd FileType c,cpp,cs,java,javascript setlocal commentstring=//\ %s

	" Get coc-css to add @ to iskeyword.
	" (Might cause problems? Was commented out.)
	autocmd FileType scss setl iskeyword+=@-@

	" Help debug syntax by providing `:call SynGroup()` to get the syntax
	" group.
	function! SynGroup()
		let l:s = synID(line('.'), col('.'), 1)
		echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
	endfun
