" == Prep ==

	set nocompatible  " Break vi compatibility to behave in a more useful way

" " == Plugins ==

	" In case vim-plug is not installed:
	if empty(glob('~/.vim/autoload/plug.vim'))
		silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif

	call plug#begin('~/.vim/plug-plugins')

	" -- Interface Plugins --

	Plug 'preservim/nerdtree'  " :NERDTreeToggle, or <Leader>f (remapped)

		let g:NERDTreeStatusline = '%#NonText#'  " No status line in NERDTree split
		let NERDTreeShowLineNumbers=1  " enable line numbers
		let NERDTreeMinimalUI = 1  " Remove '" Press ? for help' text
		autocmd FileType nerdtree setlocal nonumber relativenumber  " use relative line numbers

		" Start up nerdtree for empty vim instances
		autocmd StdinReadPre * let s:std_in=1
		autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

	Plug 'Xuyuanp/nerdtree-git-plugin'  " Adds git flag visuals to nerdtree

	Plug 'neoclide/coc.nvim', {'branch': 'release'}  " LSP support

	Plug 'hyhugh/coc-erlang_ls', {'do': 'yarn install --frozen-lockfile'}

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
			inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
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

	Plug 'benmills/vimux'  " Allows one to send commands (e.g. <Leader>vp, <Leader>vl, etc.)
	Plug 'jtdowney/vimux-cargo'  " Adds <Leader>r[cabf] for cargo run/test all/unit test current file/focused

	Plug 'mileszs/ack.vim'  " :Ack [options] {pattern} [{directories}]
	let g:ackprg = 'ag --vimgrep'  " Use ag for :Ack

	Plug 'jlanzarotta/bufexplorer'  " <Leader>b[etsv] (open/toggle/-split/|split); then b<Num> switches to buffer

	" -- Plumming --

	Plug 'tpope/vim-tbone'  " Adds Tyank, Tput, etc.

	Plug 'tmux-plugins/vim-tmux-focus-events'  " restores Focus{Gained,Lost} events for vim inside tmux

	" -- Convenience Plugins --

	Plug 'easymotion/vim-easymotion'  " Adds <Leader><Leader>[swef...]

	Plug 'christoomey/vim-tmux-navigator'  " Adds ctrl-[hjkl\]

	Plug 'tpope/vim-surround'  " cs]{

	Plug 'tpope/vim-repeat'  " Enables repeating surrounds and some other plugins

	Plug 'jiangmiao/auto-pairs'  " Automatically adds and removes paired brackets etc.

	Plug 'junegunn/vim-easy-align'  " gaip + =,*=,<space>,

	Plug 'tmux-plugins/vim-tmux'  " Improves editting of .tmux.conf

	Plug 'tpope/vim-commentary'  " gcc for line, gc otherwise (cmd-/ remapped too)

	Plug 'andymass/vim-matchup'  " Extends % and adds [g[]zia]%

	Plug 'tpope/vim-endwise'  " Automatically add endings
	let g:endwise_no_mappings = v:true  " disable mapping to not break coc.nvim

	" -- Visuals --

	Plug 'crusoexia/vim-monokai'

	"Plug 'dense-analysis/ale'  " Linting for many languages

	Plug 'octol/vim-cpp-enhanced-highlight'  " improves C++ syntax highlighting in vim

	Plug 'airblade/vim-gitgutter'  " displays git symbols next to lines

	Plug 'luochen1990/rainbow'  " Rainbow parentheses matching
	let g:rainbow_active = 1

	call plug#end()

" == General setup . ==

	" Set update time for gitgutter, swap file, etc.
	set updatetime=1000

	" Hide, instead of unloading, abandoned buffers
	set hidden

	"set cmdheight=1

	" Don't pass messages to |ins-completion-menu| ?
	set shortmess-=c

	" Always show the signcolumn, otherwise it would shift the text each time
	" diagnostics appear/become resolved.
	set signcolumn=yes

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

	" Default split positions
	set splitbelow
	set splitright

" == Visuals ==

	colorscheme monokai
	set t_Co=256
	set termguicolors
	let g:monokai_term_italic = 1
	let g:monokai_gui_italic = 1

	hi MatchParen cterm=italic gui=italic

	syntax enable
	filetype on  " The 'filetype' option gets set on loading a file
	filetype plugin on  " Can use ~/.vim/ftplugin/ to add filetype-specific setup
	filetype indent on  " Can change the indentation depending on filetype

	set number relativenumber

	set wrap                " Wrap lines (default)
	set nolist              " Don't show invisible characters (default)
	set linebreak           " Break between words, not in the middle of words
	set breakindent         " Visually indent wrapped lines
	set breakindentopt=sbr  " Visually indent with the 'showbreak' option value
	set showbreak=↪>\       " What to show to indent wrapped lines

" == Indentation ==

	set autoindent
	set cindent cinkeys-=0#

	" Defaults
	set noexpandtab
	set shiftwidth=3
	set softtabstop=3
	set tabstop=3

	" -- Tab = 2 Spaces --
	"autocmd Filetype json       setlocal ts=2 sw=2 sts=2 noexpandtab
	"autocmd Filetype cpp        setlocal ts=2 sw=2 sts=2 expandtab

	" -- Tab = 3 Spaces --

	" -- Tab = 4 Spaces --

" == Key Mappings ==

	" Set <Leader> to be <Space>
	let mapleader = " "

	nnoremap ; :
	vnoremap ; :
	nnoremap : ;
	vnoremap : ;

	" Toggle NERDTree with <Leader>f
	nnoremap <Leader>f :NERDTreeToggle<CR>

	" Find current file being editted in NERDTree with <Leader>v
	nnoremap <silent> <Leader>v :NERDTreeFind<CR>

	" Prompt for a command to run
	nnoremap <Leader>vr :VimuxPromptCommand<CR>

	" Prompt for rereun last command
	nnoremap <Leader>vl :VimuxRunLastCommand<CR>

	" Inspect runner pane
	nnoremap <Leader>vi :VimuxInspectRunner<CR>

	" Fast movement with leader key
	nnoremap <Leader>h 10h
	nnoremap <Leader>j 10j
	nnoremap <Leader>k 10k
	nnoremap <Leader>l 10l

	" Convenience <Leader> maps
	nnoremap <Leader>w :w<CR>
	nnoremap <Leader>q :q<CR>

	" -- Coc key-mappings --

	" Use `[g` and `]g` to navigate diagnostics
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

" == Hooks == 

	augroup vimrc_hooks
		 au!
		 autocmd bufwritepost .vimrc source ~/.vimrc  " Source .vimrc after writing .vimrc
	augroup END
