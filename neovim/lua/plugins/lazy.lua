local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git', 'clone', '--filter=blob:none', '--single-branch',
		'https://github.com/folke/lazy.nvim.git', lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

local plugins = {

	-- Dependencies --

		{
			'nvim-lua/plenary.nvim',
		},

		{
			'nvim-tree/nvim-web-devicons',
		},


	-- Metavisuals

		{
			'nvim-treesitter/nvim-treesitter',
			config = function()
				require('plugins.configs.treesitter').setup()
			end,
			build = function()
				-- :TSUpdateSync
				pcall(require('nvim-treesitter.install').update({ with_sync = true }))
			end,
		},

		{
			'nvim-treesitter/playground',
			dependencies = 'nvim-treesitter/nvim-treesitter',
			build = function()
				-- :TSInstallSync query
				pcall(require('nvim-treesitter.install').ensure_installed_sync, 'query')
			end,
		},

		{
			'nvim-treesitter/nvim-treesitter-textobjects',
			after = 'nvim-treesitter',
		},


	-- LSP Plugins --

		{
			'williamboman/mason.nvim',
			config = function()
				require('mason').setup({
					ui = {
						icons = {
							package_installed = '✓',
							package_pending = '➜',
							package_uninstalled = '✗'
						}
					}
				})
			end,
		},

		{
			'williamboman/mason-lspconfig.nvim',
			dependencies = {
				'williamboman/mason.nvim'
			},
			config = function()
				require('plugins.configs.mason-lspconfig').setup()
			end
		},

		{
			'jayp0521/mason-null-ls.nvim',
			dependencies = {
				'williamboman/mason.nvim',
				'jose-elias-alvarez/null-ls.nvim'
			},
			config = function()
				require('plugins.configs.mason-null-ls').setup()
			end
		},

		{
			'neovim/nvim-lspconfig',
			dependencies = {
				'williamboman/mason.nvim',
				'williamboman/mason-lspconfig.nvim',
				'folke/neodev.nvim',
				'simrat39/rust-tools.nvim'
			},
			config = function()
				require('plugins.configs.lsp').setup()
			end
		},

		{
			'jose-elias-alvarez/null-ls.nvim',
			dependencies = {
				'nvim-lua/plenary.nvim',
				'neovim/nvim-lspconfig',
				'jose-elias-alvarez/typescript.nvim'
			},
			config = function()
				require('plugins.configs.null-ls').setup()
			end
		},

		{
			'ray-x/lsp_signature.nvim',
			config = function()
				require('plugins.configs.lsp-signature').setup()
			end
		},

		{
			'SmiteshP/nvim-navic',
			dependencies = 'neovim/nvim-lspconfig'
		},


		-- Code outline
		{
			'stevearc/aerial.nvim',
			config = function()
				require('plugins.configs.aerial').setup()
			end
		},


	-- DAP Plugins

		{
			'mfussenegger/nvim-dap',
			dependencies = {
				'rcarriga/nvim-dap-ui',
				'mfussenegger/nvim-dap-python',
				'theHamsta/nvim-dap-virtual-text',
			},
			config = function()
				require('plugins.configs.dap').setup()
			end
		},

		{
			'rcarriga/nvim-dap-ui',
			dependencies = 'mfussenegger/nvim-dap',
			config = function()
				require('plugins.configs.dap-ui').setup()
			end
		},

		{
			'theHamsta/nvim-dap-virtual-text',
			dependencies = 'mfussenegger/nvim-dap',
			config = function()
				require('nvim-dap-virtual-text').setup({})
			end
		},

		{
			'mfussenegger/nvim-dap-python',
			dependencies = 'mfussenegger/nvim-dap',
			ft = { 'python' }
		},

	-- Testing

		{
			'nvim-neotest/neotest',
			dependencies = {
				'nvim-lua/plenary.nvim',
				'nvim-treesitter/nvim-treesitter',
				'nvim-neotest/neotest-python',
				'nvim-neotest/neotest-plenary'
			},
			config = function()
				require('plugins.configs.neotest').setup()
			end
		},
		{ 'nvim-neotest/neotest-python' },
		{ 'nvim-neotest/neotest-plenary' },
		{ 'nvim-neotest/neotest-vim-test' },
		{ 'vim-test/vim-test' },

	-- Other Code-Aware Plugins

		{
			'ThePrimeagen/refactoring.nvim',
			dependencies = {
				'nvim-lua/plenary.nvim',
				'nvim-treesitter/nvim-treesitter'
			},
			config = function()
				require('refactoring').setup({})
			end,
		},

		{
			'kevinhwang91/nvim-ufo',
			dependencies = 'kevinhwang91/promise-async',
			enabled = function()
				return require('plugins.plugin-condition-table').enable_plugin_table['ufo']
			end,
			config = function()
				require('plugins.configs.ufo').setup()
			end,
		},


	-- Completion

		{
			'hrsh7th/nvim-cmp',
			dependencies = {
				{ 'hrsh7th/cmp-nvim-lsp' },
				{ 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
				{ 'hrsh7th/cmp-path', after = 'nvim-cmp' },
				{ 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
				{ 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
				{ 'onsails/lspkind-nvim' },  -- Adds VS Code pictograms.
				{ 'L3MON4D3/LuaSnip', after = 'nvim-cmp' },
				{ 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
			},
			event = 'InsertEnter',
			config = function()
				require('plugins.configs.cmp').setup()
			end
		},

		{
			'L3MON4D3/LuaSnip',
			dependencies = {
				'saadparwaiz1/cmp_luasnip'
			},
			event = 'InsertEnter',
			config = function()
				require('plugins.configs.luasnip').setup()
			end
		},


	-- Visual Interface Plugins

		{
			'folke/trouble.nvim',
			dependencies = 'nvim-tree/nvim-web-devicons',
			config = function()
				require('plugins.configs.trouble').setup()
			end,
		},

		{
			'nvim-tree/nvim-tree.lua',
			dependencies = 'nvim-tree/nvim-web-devicons',
			config = function()
				require('plugins.configs.nvim-tree').setup()
			end
		},

		{
			'mbbill/undotree',
			config = function()
				require('plugins.configs.undo-tree').setup()
			end
		},

		{
			'akinsho/toggleterm.nvim',
			config = function()
					require('plugins.configs.toggleterm').setup()
			end
		},

		{
			'sindrets/diffview.nvim',
			config = function()
				require('diffview').setup({})
			end
		},


	-- Finders

		{
			'nvim-telescope/telescope.nvim',
			dependencies = {
				'nvim-lua/plenary.nvim',
				'nvim-tree/nvim-web-devicons',
			},
			config = function()
				require('plugins.configs.telescope').setup()
			end
		},

		{
			'nvim-telescope/telescope-ui-select.nvim',
			dependencies = 'nvim-telescope/telescope.nvim',
			config = function()
				require('telescope').load_extension('ui-select')
			end
		},

		{
			'nvim-telescope/telescope-file-browser.nvim',
			dependencies = 'nvim-telescope/telescope.nvim',
			config = function()
				require('telescope').load_extension('file_browser')
			end
		},

		{
			'nvim-telescope/telescope-fzf-native.nvim',
			dependencies = 'nvim-telescope/telescope.nvim',
			enabled = function()
				return require('plugins.plugin-condition-table').enable_plugin_table['telescope-fzf-native']
			end,
			build = 'make',
			lazy = true,
			config = function()
				require('telescope').load_extension('fzf')
			end
		},


	-- Navigators

		{
			'ThePrimeagen/harpoon',
			config = function()
				require('plugins.configs.harpoon').setup()
			end
		},

		{
			'jlanzarotta/bufexplorer'
		},


	-- Code-specific

		-- Fish
			{
				'blankname/vim-fish',
				ft = 'fish'
			},

		-- Haskell
			{
				'neovimhaskell/haskell-vim',
				config = function()
					require('plugins.configs.haskell-vim').setup()
				end,
				ft = 'haskell'
			},

		-- Jenkinsfile
			{
				'martinda/Jenkinsfile-vim-syntax',
				ft = 'Jenkinsfile'
			},

		-- LaTeX
			{
				'lervag/vimtex',
				ft = 'tex'
			},

		-- Lua
			{
				'folke/neodev.nvim',
			},

		-- Markdown
			{
				'iamcco/markdown-preview.nvim',
				build = 'cd app & yarn install',
				ft = { 'markdown', 'pandoc.markdown', 'rmd' },
				enabled = function()
					return require('plugins.plugin-condition-table').enable_plugin_table['markdown-preview']
				end,
			},
			{
				'AndrewRadev/inline_edit.vim',
				ft = { 'markdown', 'pandoc.markdown', 'rmd' }
			},

		-- Rust

			{
				'simrat39/rust-tools.nvim'
			},

		-- Tmux (.tmux.conf)
			{
				'tmux-plugins/vim-tmux',
				ft = 'tmux'
			},

		-- Typescript
			{
				'jose-elias-alvarez/typescript.nvim',
				config = function()
					require('typescript').setup({})
				end,
				ft = 'typescript'
			},


	-- Tmux

		{
			-- Adds vim-tmux navigation commands
			'numToStr/Navigator.nvim',
			config = function()
				require('plugins.configs.tmux-navigator').setup()
			end
		},

		-- Adds Tyank, Tput, etc., and also <Leader>y
		'tpope/vim-tbone',


	-- Git

		{
			'lewis6991/gitsigns.nvim',
			dependencies = {
				'nvim-lua/plenary.nvim'
			},
			config = function()
				require('plugins.configs.gitsigns').setup()
			end
		},


	-- Convenience, Productivity, and Quality of Life

		-- Manual

			{
				'ggandor/leap.nvim',
				config = function()
					require('leap').opts.case_sensitive = true
					require('leap').add_default_mappings()
				end,
			},

			{
				'ggandor/flit.nvim',
				config = function()
					require('flit').setup({
						labeled_modes = 'nx'
					})
				end
			},

			{
				'tpope/vim-surround'
				-- Alternative: 'machakann/vim-sandwich')
			},

			{
				'junegunn/vim-easy-align',
				config = function()
					require('plugins.configs.easy-align').setup()
				end
			},

			{
				'numToStr/Comment.nvim',
				config = function()
					require('Comment').setup({
						sticky = true
					})
				end
			},

			{
				'andymass/vim-matchup'
			},

			{
				'mhinz/vim-sayonara',
				config = function()
					require('plugins.configs.sayonara').setup()
				end
			},

			{
				'AndrewRadev/sideways.vim',
				config = function()
					require('plugins.configs.sideways').setup()
				end
			},

			{
				'Wansmer/treesj',
				dependencies = 'nvim-treesitter',
				config = function()
					require('plugins.configs.treesj').setup()
				end
			},

			{
				'ckolkey/ts-node-action',
				dependencies = 'nvim-treesitter',
				config = function()
					require('plugins.configs.ts-node-action').setup()
				end
			},

			{
				'godlygeek/tabular'
			},

			{
				'glts/vim-radical',
			},

		-- Automatic

			{
				'tpope/vim-repeat'
			},

			{
				'NMAC427/guess-indent.nvim',
				config = function()
					require('guess-indent').setup({})
				end,
			},

			{
				'windwp/nvim-autopairs',
				dependencies = {
					'hrsh7th/nvim-cmp',
					'nvim-treesitter/nvim-treesitter',
				},
				config = function()
					require('plugins.configs.autopairs').setup()
				end,
				event = 'InsertEnter'
			},

			{
				'ethanholz/nvim-lastplace',
				config = function()
					require('nvim-lastplace').setup({
						lastplace_ignore_buftype = {'quickfix', 'nofile', 'help'},
						-- lastplace_ignore_filetype = {},
						lastplace_open_folds = true
					})
				end
			},

			{
				'JoosepAlviste/nvim-ts-context-commentstring',
				event = 'InsertEnter'
			},

			{
				'RRethy/nvim-treesitter-endwise',
				dependencies = 'nvim-treesitter/nvim-treesitter',
				config = function()
					require('nvim-treesitter.configs').setup({
						endwise = {
							enable = true,
						},
					})
				end,
				ft = { 'ruby', 'lua', 'vim', 'bash', 'elixir' }
			},

			{
				'windwp/nvim-ts-autotag',
				dependencies = 'nvim-treesitter/nvim-treesitter',
				config = function()
					require('nvim-ts-autotag').setup()
				end,
				ft = {
					'php', 'markdown', 'xml', 'html', 'javascript', 'typescript',
					'javascriptreact', 'typescriptreact', 'tsx', 'jsx'
				}
			},

			'tpope/vim-speeddating',


	-- Visuals

		-- Colourschemes

			{
				'Mofiqul/vscode.nvim',
				config = function()
					require('plugins.configs.vscode').setup()
				end,
				priority = 100
			},

		-- Editor

			{
				'akinsho/bufferline.nvim',
				enabled = true,
				version = 'v3.*',
				dependencies = {
					'nvim-tree/nvim-web-devicons',
					'Mofiqul/vscode.nvim'
				},
				config = function()
					require('plugins.configs.bufferline').setup()
				end,
				priority = 90
			},

			{
				'nvim-lualine/lualine.nvim',
				dependencies = {
					'nvim-tree/nvim-web-devicons',
					'Mofiqul/vscode.nvim'
				},
				config = function()
					require('plugins.configs.lualine').setup()
				end,
				priority = 90
			},

			{
				'lukas-reineke/indent-blankline.nvim',
				enabled = function()
					return require('plugins.plugin-condition-table').enable_plugin_table['indent-blankline']
				end,
				config = function()
					require('plugins.configs.indent-blankline').setup()
				end,
			},

			{
				'lukas-reineke/virt-column.nvim',
				config = function()
					require('plugins.configs.virt-column').setup()
				end
			},

			{
				'p00f/nvim-ts-rainbow',
				enabled = function()
					return require('plugins.plugin-condition-table').enable_plugin_table['nvim-ts-rainbow']
				end,
				dependencies = 'nvim-treesitter/nvim-treesitter',
			},

			{
				'RRethy/vim-illuminate',
				config = function()
					require('plugins.configs.illuminate').setup()
				end
			},

			{
				'narutoxy/dim.lua',
				config = function()
					require('dim').setup({})
				end,
			},

		-- UI

			{
				'stevearc/dressing.nvim',
				dependencies = 'nvim-telescope/telescope.nvim',
			},

			{
				'NvChad/nvim-colorizer.lua',
				config = function()
					require('colorizer').setup({
						user_default_options = { names = false }
					})
				end,
			},

		-- UX

			{
				'karb94/neoscroll.nvim',
				enabled = function()
					return require('plugins.plugin-condition-table').enable_plugin_table['neoscroll']
				end,
				config = function()
					require('plugins.configs.neoscroll').setup()
				end
			},

			{
				'kosayoda/nvim-lightbulb',
				config = function()
					require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
				end
			},

			{
				'kevinhwang91/nvim-hlslens',
				config = function()
					require('plugins.configs.hlslens').setup()
				end
			},

			{
				'petertriho/nvim-scrollbar',
				dependencies = {
					'kevinhwang91/nvim-hlslens',
					'lewis6991/gitsigns.nvim',
				},
				config = function()
					require('plugins.configs.scrollbar').setup()
				end,
			},

		-- Modal

			{
				'Pocco81/TrueZen.nvim',
				config = function()
					require('plugins.configs.true-zen').setup()
				end
			},

			{
				'folke/twilight.nvim',
				config = function()
					require('plugins.configs.twilight').setup()
				end
			},


	-- Miscellaneous

		{
			'stevearc/stickybuf.nvim',
		},

		{
			'gpanders/editorconfig.nvim',
		}
}

-- To consider:
--  - If <Leader>d fails me: 'inkarkat/vim-ReplaceWithRegister'
--  - If I want to use multiple cursors: 'mg979/vim-visual-multi'

-- Must be before any keybindings which make use of <Leader>.
vim.g.mapleader = ' '

require('lazy').setup(plugins, {})
