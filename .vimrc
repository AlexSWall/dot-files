" Buffers:
" - A buffer is the in-memory text of a file.
" - A window is a viewport on a buffer.
" - A tab page is a collection of windows.
"
" Commands:
" :e <filename> (open file into new buffer, e.g. `:e src/**/F*Bar.js`)
" :ls (list)
" :b <n> (open buffer number, or last buffer if <n> = #)
" :b <filename> (switch to open file buffer)
" :bn (next)
" :bp (previous)
" :bd (delete)
" :bw (wipe (from RAM))
" :sp (split -)
" :vp (vertical split |)
" <Leader>b[etsv] (open/toggle/-split/|split); then b<Num> switches to buffer (bufexplorer)
" gb - custom keybinding for listing buffers and then going to a buffer quickly
" :mksession! ~/today.ses  ->  vim -S ~/today.ses

" Maybe Add:
"   - cscope and/or ctags (maybe via `apt`)?
" Other:
"   - Consider replacing clangd with CCLS? Or compile clangd from source?


" == Prep ==

	set nocompatible  " Break vi compatibility to behave in a more useful way
	set runtimepath^=~/.vim
	let &packpath=&runtimepath


" == Plugins ==

	" -- Preamble --

		" In case vim-plug is not installed:
		if empty(glob('~/.vim/autoload/plug.vim'))
			silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
			autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
		endif

	call plug#begin('~/.vim/plug-plugins')


	" -- Code Comprehension Plugins --

		Plug 'neoclide/coc.nvim', {'branch': 'release'}  " LSP support

			" Use tab for trigger completion with characters ahead and navigate.
			inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
			inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

			function! s:check_back_space() abort
				let col = col('.') - 1
				return !col || getline('.')[col - 1]  =~# '\s'
			endfunction

			" Use <c-space> to trigger completion.
			inoremap <silent><expr> <c-space> coc#refresh()

			" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
			" " position. Coc only does snippet and additional edit on confirm.
			if has('patch8.1.1068')
				" Use `complete_info` if your (Neo)Vim version supports it.
				"inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
			else
				imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
			endif

			" Use `[g` and `]g` to navigate diagnostics
			nmap <silent> [g <Plug>(coc-diagnostic-prev)
			nmap <silent> ]g <Plug>(coc-diagnostic-next)

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

		" Plug 'hyhugh/coc-erlang_ls', {'do': 'yarn install --frozen-lockfile'}

		"Plug 'dense-analysis/ale'  " Linting for many languages

	" -- Visual Interface Plugins --

		Plug 'liuchengxu/vista.vim'  " <Leader>t

			let g:vista#executives = ['coc']
			let g:vista_default_executive = 'coc'
			let g:vista#renderer#enable_icon = 0
			let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

		Plug 'preservim/nerdtree'  " :NERDTreeToggle, or <Leader>nf (remapped)

			let g:NERDTreeStatusline = '%#NonText#'  " No status line in NERDTree split
			let g:NERDTreeShowLineNumbers=1  " enable line numbers
			let g:NERDTreeMinimalUI = 1  " Remove '" Press ? for help' text
			let g:NERDTreeWinSize=31  " The default is 31; this is here for later modification
			let g:NERDTreeMouseMode=2  " Single-click to toggle directory nodes, double-click to open non-directory nodes.
			let g:NERDTreeCreatePrefix='silent keepalt keepjumps'

			" Ignore certain files by name in NERDTree.
			set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*
			let NERDTreeRespectWildIgnore=1

			autocmd FileType nerdtree setlocal nonumber relativenumber  " use relative line numbers

			" Start up nerdtree for empty vim instances
			autocmd StdinReadPre * let s:std_in=1
			autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

			" NERDTress File highlighting
			function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
				exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
				exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
			endfunction

			" Examples
			call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
			call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
			call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')

		" Plug 'Xuyuanp/nerdtree-git-plugin'  " Adds git flag visuals to nerdtree

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
			command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

		Plug 'jlanzarotta/bufexplorer'  " <Leader>b[etsv] (open/toggle/-split/|split); then b<Num> switches to buffer

		Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }  " Adds `:Clap <X>` commands (<Leader>c[bcfglt])

			" For example, `blines`,`commits`,`files`,`grep`,`lines`,`tags` 

			" The bang version of `install-binary` will try to download the prebuilt binary if cargo does not exist.

			" Then run `call :clap#installer#build_all()` if `cargo` exists for full Clap tooling


	" -- Vim-Tmux Interaction --

		Plug 'christoomey/vim-tmux-navigator'  " Adds ctrl-[hjkl\]

		Plug 'tpope/vim-tbone'  " Adds Tyank, Tput, etc., and also <Leader>y

		Plug 'benmills/vimux'  " Allows one to send commands when in Tmux (e.g. <Leader>vp, <Leader>vl, etc.)

		Plug 'jtdowney/vimux-cargo', { 'branch': 'main' }  " Adds <Leader>r[cabf] for cargo run/test all/unit test current file/focused

		Plug 'tmux-plugins/vim-tmux-focus-events'  " restores Focus{Gained,Lost} events for vim inside tmux

		Plug 'tmux-plugins/vim-tmux'  " .tmux.conf: Syntax highlighting, correct comment string, `K` for `man tmux` jump to word under cursor, `:make`


	" -- Vim-Git Interaction --

		Plug 'airblade/vim-gitgutter'  " Displays git symbols next to lines (]c, [c to navigate)

			" Get rid of <Leader>h-
			let g:gitgutter_map_keys=0
			nmap [c <Plug>GitGutterPrevHunk
			nmap ]c <Plug>GitGutterNextHunk

		Plug 'itchyny/vim-gitbranch'  " Gives `gitbranch#name()`


	" -- Convenience Plugins --

		" -- Manual --

			Plug 'easymotion/vim-easymotion'  " Adds <Leader><Leader>[swef...]

			Plug 'tpope/vim-surround'  " ysiw) cs)] ds] etc.

			Plug 'junegunn/vim-easy-align'  " gaip + =,*=,<space>,

			Plug 'tpope/vim-commentary'  " gcc for line, gc otherwise (cmd-/ remapped too)

			Plug 'andymass/vim-matchup'  " Extends % and adds [g[]zia]%


		" -- Automatic --

			Plug 'tpope/vim-repeat'  " Enables repeating surrounds and some other plugins

			" Plug 'jiangmiao/auto-pairs'  " Automatically adds and removes paired brackets etc.

			" Plug 'tpope/vim-endwise'  " Automatically add endings

				" let g:endwise_no_mappings = v:true  " disable mapping to not break coc.nvim


	" -- Colours --

		Plug 'octol/vim-cpp-enhanced-highlight'  " improves C++ syntax highlighting

		Plug 'StanAngeloff/php.vim'  " improves PHP syntax highlighting
			let g:php_var_selector_is_identifier = 1

		Plug 'neovimhaskell/haskell-vim'
			let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
			let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
			let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
			let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
			let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
			let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
			let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

		Plug 'pangloss/vim-javascript'

		Plug 'tbastos/vim-lua'  " Makes Lua syntax highlight not terribly buggy

		Plug 'luochen1990/rainbow'  " Rainbow parentheses matching
		let g:rainbow_active = 1


	" -- Miscellaneous --

		" Plug 'tpope/vim-sensible'

			" Manually pasting parts of vim-sensible to remove 'filetype indent on' and other things I later set myself

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

			if &listchars ==# 'eol:$'
			  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
			endif

			if v:version > 703 || v:version == 703 && has("patch541")
			  set formatoptions+=j " Delete comment character when joining commented lines
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

			if &tabpagemax < 50
			  set tabpagemax=50
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


" == General setup . ==

	" Set update time for gitgutter, swap file, etc.
	set updatetime=1000

	" Hide, instead of unloading, abandoned buffers
	set hidden

	" Set the closest the cursor can get to the top/bottom before scrolling
	set scrolloff=3
	" Set the closest the cursor can get to the left/right before scrolling
	set sidescrolloff=5

	" Don't pass messages to |ins-completion-menu| ?
	set shortmess-=c

	" Always show the signcolumn, otherwise it would shift the text each time
	" diagnostics appear/become resolved.
	set signcolumn=yes

	" A yank command can be redone with '.'
	set cpoptions+=y

	" View keyword help with K
	set keywordprg=:help

	" highlight all search results
	set hlsearch

	"  Do case-insensitive search
	set ignorecase

	" Show incremental search results as you type
	set incsearch

	" -- Input --

	" Enable mouse resizing splits
	set mouse=n
	if !has('nvim')
		set ttymouse=xterm2
	endif

	" -- Usability --

	" Allow backspacing over all of these
	set backspace=indent,eol,start

	" -- Misc. --

	" Fold based on indentation
	set foldmethod=indent
	set foldminlines=0

	" Default split positions
	set splitbelow
	set splitright


" == Visuals ==

	function! StatuslineGit()
		" Check whether vim-gitbranch is loaded (which gives gitbranch#name()) before continuing.
		if exists("*gitbranch#name")
			let l:branchname = gitbranch#name()
			return strlen(l:branchname) > 0 ? '  '.l:branchname.' ' : ''
		else
			return ''
		endif
	endfunction

	set statusline=%#Visual#%{StatuslineGit()}%#StatusLineNC#\ %f\ \ %y\ \ %{&fileencoding?&fileencoding:&encoding}:%{&fileformat}\ \ %h%w%m%r%=%12.(%l,%c%V%)\ 

	colorscheme monokai
	set t_Co=256
	set notermguicolors
	let g:monokai_term_italic = 1
	let g:monokai_gui_italic = 1

	hi MatchParen cterm=italic gui=italic

	syntax enable
	filetype on  " The 'filetype' option gets set on loading a file
	filetype plugin on  " Can use ~/.vim/ftplugin/ to add filetype-specific setup
	" filetype indent on  " Can change the indentation depending on filetype
	filetype indent off  " Fix annoying auto-indent bug

	set number relativenumber

	set wrap                " Wrap lines (default)
	set nolist              " Don't show invisible characters (default)
	set linebreak           " Break between words, not in the middle of words
	set breakindent         " Visually indent wrapped lines
	set breakindentopt=sbr  " Visually indent with the 'showbreak' option value
	set showbreak=↪\        " What to show to indent wrapped lines
	set shortmess-=S        " Ensure we show the number of matches for '/'


" == Indentation ==

	set autoindent
	set nocindent cinkeys-=0#

	" Defaults
	set noexpandtab
	set shiftwidth=3
	set softtabstop=3
	set tabstop=3

	" -- Tab = 2 Spaces --
	"autocmd Filetype json       setlocal ts=2 sw=2 sts=2 noexpandtab
	" autocmd Filetype yaml       setlocal ts=2 sw=2 sts=2 expandtab

	" -- Tab = 3 Spaces --
	autocmd Filetype cpp        setlocal ts=3 sw=3 sts=3 noexpandtab
	autocmd Filetype zsh        setlocal ts=3 sw=3 sts=3 noexpandtab

	" -- Tab = 4 Spaces --
	autocmd Filetype haskell    setlocal ts=4 sw=4 sts=4 expandtab
	autocmd Filetype yaml       setlocal ts=4 sw=4 sts=4 expandtab


" == Key Mappings ==

	" -- In-built --

		" Set <Leader> to be <Space>
		let mapleader = " "

		" Swap : and ;
		nnoremap ; :
		vnoremap ; :
		nnoremap : ;
		vnoremap : ;

		" Set <Esc> to its normal job when in terminal mode, instead of C-\,C-n
		tnoremap <Esc> <C-\><C-n>

		" Convenience <Leader> maps
		nnoremap <Leader>w :w<CR>
		nnoremap <Leader><Leader>w :w!<CR>
		nnoremap <Leader>q :q<CR>
		nnoremap <Leader><Leader>q :q!<CR>

		" Switch between vim tabs
		nnoremap <leader>1 1gt
		nnoremap <leader>2 2gt
		nnoremap <leader>3 3gt
		nnoremap <leader>4 4gt
		nnoremap <leader>5 5gt
		nnoremap <leader>6 6gt
		nnoremap <leader>7 7gt
		nnoremap <leader>8 8gt
		nnoremap <leader>9 9gt

		" List buffers and prepare to move to one
		nnoremap gb :ls<cr>:b<space>

		" Previous and next Buffers
		nnoremap <Leader>h :bprev<CR>
		nnoremap <Leader>l :bnext<CR>

		" Fast up-down movement
		nnoremap <Leader>j 10j
		nnoremap <Leader>k 10k

		nnoremap <Leader>z :tab sp<CR>

	" -- Plugins --

		" -- Bufexplorer (<Leader>b[etsv]) --

			" <Leader>b[etsv] (open/toggle/-split/|split); then b<Num> switches to buffer


		" -- Clap (<Leader>c[bcfgt]) --

			nnoremap <Leader>cb :Clap blines<CR>
			nnoremap <Leader>cc :Clap commits<CR>
			nnoremap <Leader>cf :Clap files<CR>
			nnoremap <Leader>cg :Clap grep<CR>
			nnoremap <Leader>cl :Clap lines<CR>
			nnoremap <Leader>cg :Clap tags<CR>


		" -- Coc ([g,]g) --

			" Use `[g` and `]g` to navigate diagnostics
			nmap <silent> [g <Plug>(coc-diagnostic-prev)
			nmap <silent> ]g <Plug>(coc-diagnostic-next)

			" Formatting selected code.
			xmap <leader>f  <Plug>(coc-format-selected)
			nmap <leader>f  <Plug>(coc-format-selected)


		" -- Easy Align --

			" Start interactive EasyAlign in visual mode (e.g. vipga)
			xmap ga <Plug>(EasyAlign)

			" Start interactive EasyAlign for a motion/text object (e.g. gaip)
			nmap ga <Plug>(EasyAlign)


		" -- Easymotion --

			" <Leader><Leader>[swef...]


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

			" nunmap <Space>hp
			" nunmap <Space>hu
			" nunmap <Space>hs


		" -- NERDTree (<Leader>n[fv], -) --

			" Toggle NERDTree with <Leader>f
			nnoremap <silent> <Leader>nf :NERDTreeToggle<CR>

			" Find current file being editted in NERDTree with <Leader>v
			nnoremap <silent> <Leader>nv :NERDTreeFind<CR>

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

			vnoremap <silent> <leader>y :call <sid>tmux_load_buffer()<CR>


		" -- Tmux Navigator (Alt-[hjkl]) --

			let g:tmux_navigator_no_mappings = 1

			nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
			nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
			nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
			nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
			nnoremap <silent> <M-\> :TmuxNavigatePrevious<cr>


		" -- Undotree (<Leader>u) --

			nnoremap <Leader>u :UndotreeToggle<CR>


		" -- Vimux (<Leader>v[rli]) --

			" Prompt for a command to run
			nnoremap <Leader>vr :VimuxPromptCommand<CR>

			" Prompt for rereun last command
			nnoremap <Leader>vl :VimuxRunLastCommand<CR>

			" Inspect runner pane
			nnoremap <Leader>vi :VimuxInspectRunner<CR>


		" -- Vista (<Leader>t) --

			nnoremap <Leader>t :Vista!!<CR>


" == Hooks == 

	augroup vimrc_hooks
		 au!
		 autocmd bufwritepost .vimrc source ~/.vimrc  " Source .vimrc after writing .vimrc
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

	" Disable Rainbow bracket matching for Lua: it messes up comments of the form [[ ... ' ... ]]
	autocmd FileType lua :RainbowToggleOff
	autocmd FileType php :RainbowToggleOff

	" Get coc-css to add @ to iskeyword
	autocmd FileType scss setl iskeyword+=@-@

	function! SynGroup()
		let l:s = synID(line('.'), col('.'), 1)
		echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
	endfun
