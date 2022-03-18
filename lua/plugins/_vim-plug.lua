local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plug-plugins')

-- Meta --

Plug 'nvim-lua/plenary.nvim'
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

-- LSP Plugins --

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'


-- Completion

Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-cmdline'

Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'onsails/lspkind-nvim'

Plug 'folke/lua-dev.nvim'

Plug 'ray-x/lsp_signature.nvim'


-- Visual Interface Plugins

Plug 'kyazdani42/nvim-tree.lua'

Plug 'mbbill/undotree'  -- Browse the undo tree via <Leader>u

	vim.g.undotree_SetFocusWhenToggle = 1

Plug 'kassio/neoterm'  -- Create and dismiss a (persistent) terminal

	vim.g.neoterm_default_mod = 'vertical'
	vim.g.neoterm_size = 60
	vim.g.neoterm_autoinsert = 1

Plug 'sbdchd/neoformat'  -- Code auto-formatting

Plug 'szw/vim-maximizer'  -- Maximize and unmaximize a split

Plug 'simrat39/symbols-outline.nvim'

	vim.g.symbols_outline = {
		show_guides = false,
		show_symbol_details = false,
	}


-- Finders

Plug 'nvim-telescope/telescope.nvim'

Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })

Plug 'nvim-telescope/telescope-ui-select.nvim'

Plug 'nvim-telescope/telescope-file-browser.nvim'

Plug 'jlanzarotta/bufexplorer'  -- <Leader>b[etsv] (open/toggle/-split/|split); then b<Num> switches to buffer


-- Vim-Tmux Interaction

Plug 'christoomey/vim-tmux-navigator'  -- Adds vim-tmux navigation commands

Plug 'tpope/vim-tbone'  -- Adds Tyank, Tput, etc., and also <Leader>y


-- Vim-Git Interaction

Plug 'lewis6991/gitsigns.nvim'

Plug 'itchyny/vim-gitbranch'  -- Gives `gitbranch#name()`


-- Convenience Plugins

-- Manual

Plug 'easymotion/vim-easymotion'  -- Adds <Leader><Leader>[swef...].

Plug 'justinmk/vim-sneak'

Plug 'tpope/vim-surround'  -- ysiw) cs)] ds] etc.

Plug 'junegunn/vim-easy-align'  -- gaip + =,*=,<space>.

Plug 'tpope/vim-commentary'  -- gcc for line, gc otherwise (cmd-/ remapped too).

Plug 'andymass/vim-matchup'  -- Extends % and adds [g[]zia]%.


-- Automatic

Plug 'tpope/vim-repeat'  -- Enables repeating surrounds and some other plugins.

Plug 'windwp/nvim-autopairs'  -- Automatically adds and removes paired brackets etc.


-- Visuals

Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'

Plug 'RRethy/vim-illuminate'

	vim.g.Illuminate_delay = 100

Plug 'p00f/nvim-ts-rainbow'

Plug 'Mofiqul/vscode.nvim'

Plug 'narutoxy/dim.lua'

Plug 'norcalli/nvim-colorizer.lua'

Plug 'stevearc/dressing.nvim' -- E.g. improves vim.input, which affects e.g. LSP rename

Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'Pocco81/TrueZen.nvim'

Plug 'junegunn/limelight.vim'

	vim.g.limelight_paragraph_span = 3

Plug 'tmux-plugins/vim-tmux'  -- .tmux.conf: Syntax highlighting, correct comment string, `K` for `man tmux` jump to word under cursor, `:make`

Plug 'neovimhaskell/haskell-vim'

	vim.g.haskell_enable_quantification   = 1  -- Enables highlighting of `forall`.
	vim.g.haskell_enable_recursivedo      = 1  -- Enables highlighting of `mdo` and `rec`.
	vim.g.haskell_enable_arrowsyntax      = 1  -- Enables highlighting of `proc`.
	vim.g.haskell_enable_pattern_synonyms = 1  -- Enables highlighting of `pattern`.
	vim.g.haskell_enable_typeroles        = 1  -- Enables highlighting of type roles.
	vim.g.haskell_enable_static_pointers  = 1  -- Enables highlighting of `static`.
	vim.g.haskell_backpack                = 1  -- Enables highlighting of backpack keywords.

Plug 'blankname/vim-fish'  -- Improves vim experience on .fish files

Plug 'unblevable/quick-scope'

	-- Trigger a highlight in the appropriate direction when pressing these keys:
	-- TODO
	-- This breaks ; when used in conjunction with vim-sneak
	-- vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
	vim.g.qs_highlight_on_keys = {}

	-- augroup qs_colors
		-- autocmd!
		-- autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
		-- autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
	-- augroup END

	-- let g:qs_lazy_highlight = 1
	-- let g:qs_delay = 0


-- Miscellaneous

Plug 'antoinemadec/FixCursorHold.nvim'  -- Fix neovim cursor hold issue

Plug 'lambdalisue/suda.vim'  -- Add SudaRead and SudaWrite for sudo reads and writes

Plug 'editorconfig/editorconfig-vim'  -- Adds the ability to read .editorconfig files (see https://editorconfig.org/)

vim.call('plug#end')
