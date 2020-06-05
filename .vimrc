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

		Plug 'hyhugh/coc-erlang_ls', {'do': 'yarn install --frozen-lockfile'}


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

		Plug 'Xuyuanp/nerdtree-git-plugin'  " Adds git flag visuals to nerdtree

		Plug 'mbbill/undotree'  " Browse the undo tree via <Leader>u


	" -- Finders --

		Plug 'junegunn/fzf'  " Gives :FZF[!] --preview=head\ -10\ {}, fzf#run, and fzf#wrap; Ctrl-[XV] to select into split/vsplit
		Plug 'junegunn/fzf.vim'  " Gives :Ag, :Files, :Buffers, :Lines, :Tags

			" Open fzf in a Tmux pane if Tmux is being used (`man fzf-tmux`), and in a vim window if not
			if exists('$TMUX')
				let g:fzf_layout = { 'tmux': '-p90%,60%' }
			else
				let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
			endif

		Plug 'jlanzarotta/bufexplorer'  " <Leader>b[etsv] (open/toggle/-split/|split); then b<Num> switches to buffer

		Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }  " Adds `:Clap <X>` commands (<Leader>c[bcfglt])

			" For example, `blines`,`commits`,`files`,`grep`,`lines`,`tags` 

			" The bang version of `install-binary` will try to download the prebuilt binary if cargo does not exist.

			" Then run `call :clap#installer#build_all()` if `cargo` exists for full Clap tooling

		Plug 'mileszs/ack.vim'  " :Ack[!] [options] {pattern} [{directories}]; use `<Leader>a`

			let g:ackprg = 'ag --vimgrep'  " Use ag for :Ack


	" -- Vim-Tmux Interaction --

		Plug 'christoomey/vim-tmux-navigator'  " Adds ctrl-[hjkl\]

		Plug 'tpope/vim-tbone'  " Adds Tyank, Tput, etc., and also <Leader>y

		Plug 'benmills/vimux'  " Allows one to send commands when in Tmux (e.g. <Leader>vp, <Leader>vl, etc.)

		Plug 'jtdowney/vimux-cargo'  " Adds <Leader>r[cabf] for cargo run/test all/unit test current file/focused

		Plug 'tmux-plugins/vim-tmux-focus-events'  " restores Focus{Gained,Lost} events for vim inside tmux

		Plug 'tmux-plugins/vim-tmux'  " .tmux.conf: Syntax highlighting, correct comment string, `K` for `man tmux` jump to word under cursor, `:make`


	" -- Vim-Git Interaction --

		Plug 'airblade/vim-gitgutter'  " Displays git symbols next to lines (]c, [c to navigate)

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

			Plug 'jiangmiao/auto-pairs'  " Automatically adds and removes paired brackets etc.

			Plug 'tpope/vim-endwise'  " Automatically add endings

				let g:endwise_no_mappings = v:true  " disable mapping to not break coc.nvim


	" -- Colours --

		Plug 'crusoexia/vim-monokai'

		Plug 'octol/vim-cpp-enhanced-highlight'  " improves C++ syntax highlighting in vim

		Plug 'tbastos/vim-lua'  " Makes Lua syntax highlight not terribly buggy

		Plug 'luochen1990/rainbow'  " Rainbow parentheses matching
		let g:rainbow_active = 1

	" -- Miscellaneous --

		Plug 'tpope/vim-sensible'


	call plug#end()


" == General setup . ==

	" Set update time for gitgutter, swap file, etc.
	set updatetime=1000

	" Hide, instead of unloading, abandoned buffers
	set hidden

	" Set the closest the cursor can get to the top/bottom before scrolling
	set scrolloff=3

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

	function! StatuslineGit()
		let l:branchname = gitbranch#name()
		return strlen(l:branchname) > 0 ? '  '.l:branchname.' ' : ''
	endfunction

	set statusline=%#Visual#%{StatuslineGit()}%#StatusLineNC#\ %f\ \ %y\ \ %{&fileencoding?&fileencoding:&encoding}:%{&fileformat}\ \ %h%w%m%r%=%12.(%l,%c%V%)\ 

	colorscheme monokai
	set t_Co=256
	set termguicolors
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
	set showbreak=↪>\       " What to show to indent wrapped lines
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
	"autocmd Filetype cpp        setlocal ts=2 sw=2 sts=2 expandtab

	" -- Tab = 3 Spaces --

	" -- Tab = 4 Spaces --


" == Key Mappings ==

	" -- In-built --

		" Set <Leader> to be <Space>
		let mapleader = " "

		nnoremap ; :
		vnoremap ; :
		nnoremap : ;
		vnoremap : ;

		" Convenience <Leader> maps
		nnoremap <Leader>w :w<CR>
		nnoremap <Leader><Leader>w :w!<CR>
		nnoremap <Leader>q :q<CR>
		nnoremap <Leader><Leader>q :q!<CR>

		" List buffers and prepare to move to one
		nnoremap gb :ls<cr>:b<space>

		" Fast movement with leader key
		nnoremap <Leader>h 10h
		nnoremap <Leader>j 10j
		nnoremap <Leader>k 10k
		nnoremap <Leader>l 10l


	" -- Plugins --

		" -- Ack (<Leader>a) --

			nnoremap <Leader>a :Ack!<Space>


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


		" -- Easymotion --

			" <Leader><Leader>[swef...]


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
