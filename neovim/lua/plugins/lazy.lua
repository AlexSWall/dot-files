-- Structure based on
-- https://github.com/gotgenes/dotfiles
-- For speed, look into
-- https://github.com/ray-x/nvim

-- Ensure lazy.nvim is installed.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- e.g. lazypath = ~/.local/share/nvim/lazy/lazy.nvim
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git', 'clone',
		'--filter=blob:none',
		'--single-branch',
		'https://github.com/folke/lazy.nvim.git',
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

vim.g.mapleader = ' '

local plugins = {

	-- Core

		'wbthomason/packer.nvim',


	-- Meta --

		'nvim-lua/plenary.nvim',
		'kyazdani42/nvim-web-devicons',


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
				require('mason').setup()
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
			'neovim/nvim-lspconfig',
			dependencies = {
				'williamboman/mason.nvim',
				'williamboman/mason-lspconfig.nvim',
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
			'j-hui/fidget.nvim',
			cond = function()
				return require('plugins.plugin-condition-table').enable_plugin_table['fidget']
			end,
			config = function()
				require('fidget').setup({})
			end
		},

		-- Code outline
		{
			'stevearc/aerial.nvim',
			config = function()
				require('aerial').setup({})
			end
		},


	-- DAP Plugins

		{
			'mfussenegger/nvim-dap',
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


	-- Other Code-Aware Plugins

		{
			'vim-test/vim-test',
			config = function()
				require('plugins.configs.vim-test').setup()
			end
		},

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
			cond = function()
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
			dependencies = 'kyazdani42/nvim-web-devicons',
			config = function()
				require('plugins.configs.trouble').setup()
			end,
		},

		{
			'kyazdani42/nvim-tree.lua',
			dependencies = 'kyazdani42/nvim-web-devicons',
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

		{
			'mhartington/formatter.nvim',
			config = function()
				require('plugins.configs.formatter').setup()
			end
		},

		{
			'simrat39/symbols-outline.nvim',
			config = function()
				require('plugins.configs.symbols-outline').setup()
			end
		},


	-- Finders

		{
			'nvim-telescope/telescope.nvim',
			dependencies = {
				'nvim-lua/plenary.nvim',
				'kyazdani42/nvim-web-devicons',
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
			cond = function()
				return require('plugins.plugin-condition-table').enable_plugin_table['telescope-fzf-native']
			end,
			build = 'make',
			lazy = true,
			config = function()
				require('telescope').load_extension('fzf')
			end
		},

		-- <Leader>b[etsv] (open/toggle/-split/|split);
		-- then b<Num> switches to buffer
		'jlanzarotta/bufexplorer',


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
				dependencies = {
					'neovim/nvim-lspconfig',
					'williamboman/mason-lspconfig',
				},
				config = function()
					require('neodev').setup({})
				end
			},

		-- Markdown
			{
				'iamcco/markdown-preview.nvim',
				-- Works only if yarn and npm are installed.
				build = 'cd app & yarn install',
				ft = { 'markdown', 'pandoc.markdown', 'rmd' }
			},
			-- Edit '```' markdown codeblocks in separate buffer.
			{
				'AndrewRadev/inline_edit.vim',
				ft = { 'markdown', 'pandoc.markdown', 'rmd' }
			},

		-- Python
			{
				'jeetsukumaran/vim-python-indent-black',
				ft = 'python'
			},

		-- Tmux (.tmux.conf)
			{
				'tmux-plugins/vim-tmux',
				ft = 'tmux'
			},

		-- Typescript
			{
				'leafgarland/typescript-vim',
				ft = 'typescript'
			},
			{
				'peitalin/vim-jsx-typescript',
				ft = 'typescript'
			},
			-- {
			-- 	'jose-elias-alvarez/nvim-lsp-ts-utils',
			-- 	dependencies = {
			-- 		'neovim/nvim-lspconfig',
			-- 		'jose-elias-alvarez/null-ls.nvim',
			-- 		'nvim-lua/plenary.nvim',
			-- 	},
			-- 	config = function()
			-- 		require('plugins.configs.nvim-lsp-ts-utils').setup()
			-- 	end,
			-- 	ft = 'typescript'
			-- },


	-- Tmux

		{
			'christoomey/vim-tmux-navigator',  -- Adds vim-tmux navigation commands
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
				'nvim-lua/plenary.nvim',
			},
			cond = function()
				return require('plugins.plugin-condition-table').enable_plugin_table['gitsigns']
			end,
			config = function()
				require('plugins.configs.gitsigns').setup()
			end
		},

		-- Gives `gitbranch#name()`
		'itchyny/vim-gitbranch',


	-- Convenience, Productivity, and Quality of Life

		-- Manual

			{
				'ggandor/leap.nvim',
				config = function()
					require('leap').add_default_mappings()
				end,
			},

			-- ysiw) cs)] ds] etc.
			'tpope/vim-surround',

			-- 'machakann/vim-sandwich')

			-- gS, gJ
			'AndrewRadev/splitjoin.vim',

			{
				'junegunn/vim-easy-align',  -- gaip + =,*=,<space>.
				config = function()
					require('plugins.configs.easy-align').setup()
				end
			},

			{
				'b3nj5m1n/kommentary',
				config = function()
					require('plugins.configs.kommentary').setup()
				end,
			},

			-- Extends % and adds [g[]zia]%.
			'andymass/vim-matchup',

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

			'godlygeek/tabular',

		-- Automatic

			'tpope/vim-repeat',

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


	-- Visuals

		-- Colourschemes

			{
				'Mofiqul/vscode.nvim',
				config = function()
					require('plugins.configs.vscode').setup()
				end
			},

		-- Editor

			{
				'lukas-reineke/indent-blankline.nvim',
				cond = function()
					return require('plugins.plugin-condition-table').enable_plugin_table['indent-blankline']
				end,
				config = function()
					require('plugins.configs.indent-blankline').setup()
				end,
			},

			{
				'lukas-reineke/virt-column.nvim',
				config = function()
					require("virt-column").setup()
				end,
			},

			{
				'p00f/nvim-ts-rainbow',
				cond = function()
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
					require('colorizer').setup({ names = false })
				end,
			},

		-- UX

			{
				'karb94/neoscroll.nvim',
				cond = function()
					return require('plugins.plugin-condition-table').enable_plugin_table['neoscroll']
				end,
				config = function()
					require('plugins.configs.neoscroll').setup()
				end
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

		'antoinemadec/FixCursorHold.nvim',

		{
			'lambdalisue/suda.vim',
			cmd = { 'SudaRead', 'SudaWrite' }
		},

		'gpanders/editorconfig.nvim',
}

require("lazy").setup(plugins, {
	concurrency = 50  -- Holdover from packer; may be unneeded.
})

-- {
-- 	'Pocco81/DAPInstall.nvim',
-- 	dependencies = 'mfussenegger/nvim-dap',
-- 	config = function()
-- 		require('dap-install').setup()
-- 	end,
-- 	cmd = {
-- 		'DIInstall',
-- 		'DIUninstall',
-- 		'DIList',
-- 	},
-- },

-- {
-- 	'mfussenegger/nvim-dap-python',
-- 	dependencies = 'mfussenegger/nvim-dap',
-- 	config = function()
-- 		-- TODO
-- 	end,
-- 	ft = { 'python' }
-- },

-- {
-- 	'leoluz/nvim-dap-go',
-- 	dependencies = 'mfussenegger/nvim-dap',
-- 	config = function()
-- 		-- TODO
-- 	end,
-- 	ft = { 'go' }
-- },



-- {
-- 	'nvim-treesitter/nvim-treesitter-textobjects',
-- 	dependencies = {
-- 		'nvim-treesitter/nvim-treesitter',
-- 	},
-- 	config = function()
-- 		require('configs.nvim-treesitter-textobjects').setup()
-- 	end,
-- },

-- {
-- 	'ziontee113/syntax-tree-surfer',
-- 	dependencies = {
-- 		'nvim-treesitter/nvim-treesitter',
-- 	},
-- 	config = function()
-- 		require('configs.syntax-tree-surfer').setup()
-- 	end,
-- },




-- {
-- 	'lukas-reineke/lsp-format.nvim',
-- 	config = function()
-- 		require('configs.lsp-format')
-- 	end,
-- },



-- {
-- 	'catppuccin/nvim',
-- 	name = 'catppuccin',
-- 	config = function()
-- 		require('configs.catppuccin').setup()
-- 	end,
-- 	build = ':CatppuccinCompile',
-- },

-- {
-- 	'akinsho/bufferline.nvim',
-- 	config = function()
-- 		require('bufferline').setup {
-- 			options = {
-- 				mode = 'buffers',
-- 				offsets = {
-- 					{
-- 						filetype = 'NvimTree',
-- 						text = function()
-- 							return vim.fn.getcwd()
-- 						end,
-- 						highlight = 'Directory',
-- 						text_align = 'left'
-- 					}
-- 				},
-- 				show_buffer_icons = false,
-- 				show_buffer_close_icons = false,
-- 				show_tab_indicators = false,
-- 				always_show_bufferline = false
-- 			}
-- 		}
-- 	end
-- },


-- {
-- 	'rcarriga/nvim-notify',
-- 	config = function()
-- 		vim.notify = require('notify')
-- 	end,
-- },

-- {
-- 	'SmiteshP/nvim-navic',
-- 	dependencies = {
-- 		'nvim-treesitter/nvim-treesitter',
-- 	},
-- 	config = function()
-- 		require('nvim-navic').setup()
-- 	end,
-- },

-- {
-- 	'petertriho/nvim-scrollbar',
-- 	dependencies = {
-- 		'kevinhwang91/nvim-hlslens',
-- 	},
-- 	config = function()
-- 		require('configs.scrollbar').setup()
-- 	end,
-- },

-- {
-- 	'folke/which-key.nvim',
-- 	config = function()
-- 		require('which-key').setup()
-- 	end,
-- },

-- {
-- 	'max397574/better-escape.nvim',
-- 	config = function()
-- 		require('configs.better-escape').setup()
-- 	end,
-- },

-- David-Kunz/markid