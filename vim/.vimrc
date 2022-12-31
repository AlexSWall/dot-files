set nocompatible  " Break vi compatibility to behave in a more useful way.
set runtimepath^=~/.vim
let &packpath=&runtimepath

" Change vim shell to zsh if current shell is fish.
if &shell =~# 'fish$'
	set shell=zsh
endif

" == Tpope Sensible == 

set complete-=i

set smarttab

if &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

set laststatus=2
set ruler
set wildmenu

set display+=lastline

set encoding=utf-8

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines.
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


" == General setup ==

" -- General --

" Set update time for gitgutter, swap file, etc.
set updatetime=100

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
set signcolumn=no

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

" Make Y behave like other capitals (default in Neovim 6.0+)
nnoremap Y y$

" Set comment string to // instead of /* */ when suitable.
autocmd FileType c,cpp,cs,java,javascript,php setlocal commentstring=//\ %s


" == Visuals ==

set statusline=%#StatusLine#\ %f\ %y\ %{&fileencoding?&fileencoding:&encoding}:%{&fileformat}\ %h%w%m%r\ %#StatusLineNC#%=-%12.(%#StatusLine#\ %l,%c%V%)\ 
set fillchars+=stl:-
set fillchars+=stlnc:-

try
    colorscheme monokai
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme pablo
endtry

set t_Co=256
set termguicolors

hi MatchParen cterm=italic gui=italic

syntax enable
filetype on          " The 'filetype' option gets set on loading a file.
filetype plugin on   " Can use ~/.vim/ftplugin/ to add filetype-specific setup.
filetype indent on   " Can change the indentation depending on filetype.

set number
set relativenumber

set wrap                " Wrap lines (default).
set nolist              " Don't show invisible characters (default).
set linebreak           " Break between words, not in the middle of words.
set breakindent         " Visually indent wrapped lines.
set breakindentopt=sbr  " Visually indent with the 'showbreak' option value.
set showbreak=>\        " What to show to indent wrapped lines.
set shortmess-=S        " Ensure we show the number of matches for '/'.

" Sets which characters to show in the place of whitespace when using `:set
" list`.
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
"set list

" Display a coloured column at 100 characters.
set colorcolumn=80,100,120

" Add highlighting to trailing whitespace and spaces before tabs, but not
" when typing on that line.

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
autocmd Filetype python     setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype markdown   setlocal ts=4 sw=4 sts=4 expandtab


" == Key Mappings ==

" Set <Leader> to be <Space>.
let mapleader = " "

" -- In-built --

" -- Fundamental --

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

" While in visual mode, use <Leader>/ to search for the selected text.
vnoremap <silent> <Leader>/ y/\V<C-R>=escape(@",'/\')<CR><CR>

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

" Leave cursor in final location after visual yank.
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
	\ :set nonumber norelativenumber nolinebreak nobreakindent showbreak= <CR>
"
" Re-enable GUI
nnoremap <silent> <Leader><Leader>0
	\ :set number relativenumber linebreak breakindent showbreak=>\ <CR>
