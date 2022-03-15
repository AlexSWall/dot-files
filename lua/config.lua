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

	LSP:
		'gd'    - definition()
		'gh'    - hover()
		'gH'    - code_action()
		'gD'    - implementation()
		'gr'    - references()
		'gR'    - rename()

		'<C-k>' - signature_help()
	--]]


-- Prep

	-- Change vim shell to zsh if current shell is fish.
	if vim.opt.shell['_value'] == 'fish' then
		vim.opt.shell = 'zsh'
	end


-- Plugins

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

			-- Fixing bug I seem to get complaining that this isn't defined.
			vim.g.undotree_CursorLine = 1

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

		Plug 'jlanzarotta/bufexplorer'  -- <Leader>b[etsv] (open/toggle/-split/|split); then b<Num> switches to buffer


	-- Vim-Tmux Interaction

		Plug 'christoomey/vim-tmux-navigator'  -- Adds vim-tmux navigation comma

		Plug 'tpope/vim-tbone'  -- Adds Tyank, Tput, etc., and also <Leader>y

		Plug 'benmills/vimux'  -- Allows one to send commands when in Tmux (e.g. <Leader>vp, <Leader>vl, etc.)

		Plug('jtdowney/vimux-cargo', { branch = 'main' })  -- Adds <Leader>r[cabf] for cargo run/test all/unit test current file/focused

		Plug 'tmux-plugins/vim-tmux'  -- .tmux.conf: Syntax highlighting, correct comment string, `K` for `man tmux` jump to word under cursor, `:make`


	-- Vim-Git Interaction

		Plug 'lewis6991/gitsigns.nvim'

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

			Plug 'windwp/nvim-autopairs'  -- Automatically adds and removes paired brackets etc.


	-- Visuals

		Plug 'RRethy/vim-illuminate'

		Plug 'p00f/nvim-ts-rainbow'

		Plug 'Mofiqul/vscode.nvim'

		Plug 'narutoxy/dim.lua'

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
			vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}

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


-- LSP Support

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
		'pylsp',         -- Python
		--'remark_ls',     -- Markdown
		'rust_analyzer', -- Rust
		'sumneko_lua',   -- Lua
		'taplo',         -- Toml
		'texlab',        -- LaTeX
		'tsserver',      -- Typescript, Javascript
		'vimls',         -- Vimscript
		'yamlls'         -- Yaml
	}

	local lsp_installer = require('nvim-lsp-installer')

	-- Install any LSP servers we want which aren't installed.
	for _, name in pairs(servers) do
		local server_is_found, server = lsp_installer.get_server(name)
		if server_is_found and not server:is_installed() then
			print("Installing " .. name)
			server:install()
		end
	end

	local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

	local function on_attach(client, _)

		-- require 'illuminate'.on_attach(client)

		local function keymap(from, to)
			vim.keymap.set('n', from, to, { buffer = 0 } )
		end

		keymap('K',          vim.lsp.buf.hover)
		keymap('gd',         vim.lsp.buf.definition)
		keymap('gt',         vim.lsp.buf.type_definition)
		keymap('gi',         vim.lsp.buf.implementation)
		keymap('gr',         vim.lsp.buf.references)
		keymap('<Leader>rn', vim.lsp.buf.rename)
		keymap('<Leader>dn', vim.diagnostic.goto_next)
		keymap('<Leader>dp', vim.diagnostic.goto_prev)
		keymap('<Leader>dl', '<cmd>Telescope diagnostics<CR>')

		-- keymap('gH', vim.lsp.buf.code_action)
		-- keymap('<C-k>', vim.lsp.buf.signature_help)
	end

	local enhance_server_opts = {
		['sumneko_lua'] = function(opts)

			opts.settings = {
				Lua = {
					diagnostics = {
						globals = {
							'vim'
						}
					},
					completion = {
						callSnippet = 'Replace',
					}
				}
			}

			-- Add lua-dev to the mix
			local luadev = require("lua-dev").setup({})
			for k,v in pairs(luadev) do opts[k] = v end
		end,

		['pylsp'] = function(opts)
			opts.settings = {
				pylsp = {
					plugins = {
						jedi_completion = {
							include_params = true,
						}
					}
				}
			}
		end
	}

	lsp_installer.on_server_ready(function(server)

		-- Default options used for setting up all servers
		local opts = {
			on_attach = on_attach,
			capabilities = capabilities
		}

		-- Add LSP Server-specific options
		if enhance_server_opts[server.name] then
			enhance_server_opts[server.name](opts)
		end

		server:setup(opts)
	end)

	local cmp = require('cmp')
	local luasnip = require('luasnip')

	luasnip.config.set_config({
			history = true,
			updateevents = 'TextChanged,TextChangedI',
			-- enable_autosnippets = true,
		})

	local fmt = require('luasnip.extras.fmt').fmt
	local s = luasnip.s
	local i = luasnip.insert_node
	local rep = require('luasnip.extras').rep

	luasnip.snippets = {
		-- Available in any filetype
		all = {
		},

		-- Available in Lua files only
		lua = {
			luasnip.parser.parse_snippet('expand', '-- This is what was expanded'),
			luasnip.parser.parse_snippet('lf', 'local $1 = function($2)\n\t$0\nend'),
			s('req', fmt("local {} = require('{}')", { i(1, "default"), rep(1) }))
		}
	}

	cmp.setup({
			mapping = {
				['<C-y>'] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}),
				['<C-e>'] = cmp.mapping.close(),
				['<C-c>'] = cmp.mapping.abort(),
				['<C-d>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				-- <C-p> and <C-n> for previous and next already work by default
			},

			sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'buffer', keyword_length = 5 },
				}),

			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end,
			},

			formatting = {
				format = require('lspkind').cmp_format({
						with_text = true,
						mode = 'text',
						menu = {
							buffer   = '[buf]',
							nvim_lsp = '[LSP]',
							nvim_lua = '[api]',
							path     = '[path]',
							luasnip  = '[snip]'
						}
				})
			},

			experimental = {
				ghost_text = {
					hl_group = 'CmpGhostText'
				}
			}
	})

	require "lsp_signature".setup({
		hint_enable = false,
		floating_window_above_cur_line = false,
		transparency = 30,
		toggle_key = nil, -- TODO
		floating_window_off_y = -4,
	})

	require('nvim-treesitter.configs').setup({
		ensure_installed = 'maintained',
		highlight = {
			enable = true,
			-- use_languagetree = true
			additional_vim_regex_highlighting = false
		},
		indent = {
			enable = true,
			disable = { 'yaml' }
		},
		matchup = {
			enable = true
		},
		rainbow = {
			enable = true,
			extended_mode = true
		}
	})

	require('telescope').setup({
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown({})
			}
		}
	})

	require('telescope').load_extension('fzf')
	require('telescope').load_extension('ui-select')

	require'nvim-tree'.setup({})

	require('gitsigns').setup({
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set('n', l, r, opts)
			end

			-- Navigation
			map(']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
			map('[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})
			map('<Leader>]', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
			map('<Leader>[', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})
			map('<leader>gr', gs.reset_hunk)
			map('<leader>gp', gs.preview_hunk)
			map('<leader>gd', gs.diffthis)
			map('<leader>gb', gs.toggle_current_line_blame)
			map('<leader>gd', gs.toggle_deleted)
		end
	})

	require('nvim-autopairs').setup({
		-- TODO?
	})

	vim.g.Illuminate_delay = 100

	-- vim.opt.foldmethod = 'expr'
	-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

	require('dim').setup({})

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
		vim.opt.updatetime = 100

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

	-- Colour scheme

	vim.cmd('set t_Co=256')
	vim.opt.termguicolors = true

	-- vim.g.monokai_term_italic = 1
	-- vim.g.monokai_gui_italic = 1
	-- vim.cmd('colorscheme monokai')

	vim.g.vscode_style = 'dark'
	vim.g.vscode_italic_comment = 1
	vim.g.codedark_italics = true
	vim.cmd('colorscheme vscode')

	vim.cmd('highlight MatchParen cterm=italic gui=italic')
	vim.cmd('highlight MatchWord guifg=#C586C0 guibg=#121212 cterm=bold,underline gui=bold,underline')

	vim.cmd('syntax enable')
	vim.cmd('filetype on')          -- The 'filetype' option gets set on loading a file.
	vim.cmd('filetype plugin on')   -- Can use ~/.vim/ftplugin/ to add filetype-specific setup.
	vim.cmd('filetype indent on')   -- Can change the indentation depending on filetype.
	-- filetype indent off  -- Fix annoying auto-indent bug.

	vim.opt.number = true
	vim.opt.relativenumber = true

	vim.opt.wrap = true
	vim.opt.list = false
	vim.opt.linebreak = true        -- Break between words, not in the middle of words.
	vim.opt.breakindent = true      -- Visually indent wrapped lines.
	vim.opt.breakindentopt = 'sbr'  -- Visually indent with the 'showbreak' option value.
	vim.opt.showbreak = '↪ '        -- What to show to indent wrapped lines.

	vim.opt.pumblend = 20
	vim.opt.pumheight = 20

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
	vim.cmd('highlight ExtraWhitespace ctermbg=LightRed guibg=#223E55')    
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

	vim.cmd([[
		" gray
		highlight CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
		" blue
		highlight CmpItemAbbrMatch guibg=NONE guifg=#569CD6
		highlight CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
		" light blue
		highlight CmpItemKindVariable guibg=NONE guifg=#9CDCFE
		highlight CmpItemKindInterface guibg=NONE guifg=#9CDCFE
		highlight CmpItemKindText guibg=NONE guifg=#9CDCFE
		" pink
		highlight CmpItemKindFunction guibg=NONE guifg=#C586C0
		highlight CmpItemKindMethod guibg=NONE guifg=#C586C0
		" front
		highlight CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
		highlight CmpItemKindProperty guibg=NONE guifg=#D4D4D4
		highlight CmpItemKindUnit guibg=NONE guifg=#D4D4D4
		highlight CmpItemKind guibg=NONE guifg=#D4D4D4
	]])


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


		-- Telescope (<Leader>f[abfgl], <Leader>f![abfgl])

			-- (:FZF = :Files)
			nmap('<Leader>fa', ':Telescope live_grep<CR>')
			nmap('<Leader>fb', ':Telescope buffers<CR>')
			nmap('<Leader>ff', ':Telescope find_files<CR>')
			nmap('<Leader>fg', ':Telescope git_files<CR>')
			nmap('<Leader>fv', ':Telescope grep_string<CR>')
			nmap('<Leader>fr', ':Telescope registers<CR>')

			_G.telescope_live_grep_in_path = function(path)
				local _path = path or vim.fn.input('Dir: ', '',  'dir')
				require('telescope.builtin').live_grep({search_dirs = {_path}})
			end

			nmap('<Leader>fA', ':lua telescope_live_grep_in_path()<CR>')


		-- LuaSnip

			vim.keymap.set({'i', 's'}, '<C-k>', function()
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				end
			end, { silent = true })

			vim.keymap.set({'i', 's'}, '<C-j>', function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { silent = true })

			vim.keymap.set('i', '<C-l>', function()
				if luasnip.choice_active() then
					luasnip.change_choice(1)
				end
			end, { silent = true })


		-- Maximizer (<Leader>m)

			nmap('<Leader>m', ':MaximizerToggle!<CR>')


		-- Neoformat (<Leader>F)

			nmap('<Leader>F', ':Neoformat prettier<CR>')


		-- Neoterm (Ctrl-q)

			nmap('<C-q>', ':Ttoggle<CR>')
			imap('<C-q>', '<Esc>:Ttoggle<CR>')
			tmap('<C-q>', '<C-\\><C-n>:Ttoggle<CR>')


		-- Symbols Outline

			nmap('<Leader>s', ':SymbolsOutline<CR>')


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
	-- vim.cmd('autocmd! FileType fzf tnoremap <buffer> <Esc> <Esc>')

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
			local str = '{ '
			for k,v in pairs(o) do
				if type(k) ~= 'number' then k = '"'..k..'"' end
				str = str .. '['..k..'] = ' .. dump(v) .. ','
			end
			return str .. '} '
		else
			return tostring(o)
		end
	end

