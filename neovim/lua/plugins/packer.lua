-- Structure based on
-- https://github.com/gotgenes/dotfiles
-- For speed, look into
-- https://github.com/ray-x/nvim

-- Ensure packer is installed.
local ensure_packer = function()
	local install_path = vim.fn.stdpath( 'data' ) .. '/site/pack/packer/start/packer.nvim'
	if vim.fn.empty( vim.fn.glob( install_path ) ) > 0 then
		vim.fn.system({
			'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path
		})
		vim.cmd('packadd packer.nvim')
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Ensure we can find packer; else exit.
local status_ok, _ = pcall(require, 'packer')
if not status_ok then
	vim.notify('Could not find packer.', vim.log.levels.ERROR)
	return
end

-- After writing to packer.lua, recompile.
-- vim.api.nvim_create_autocmd('BufWritePost', {
-- 	pattern = { 'packer.lua', 'plugin-condition-table.lua' },
-- 	command = 'PackerSync'
-- })


local plugins = function( use )

	-- Core

		use('wbthomason/packer.nvim')


	-- Meta --

		use('nvim-lua/plenary.nvim')
		use('kyazdani42/nvim-web-devicons')


	-- Metavisuals

		use({
			'nvim-treesitter/nvim-treesitter',
			config = function()
				require('plugins.configs.treesitter').setup()
			end,
			run = ':TSUpdate'
		})

		use({
			'nvim-treesitter/playground',
			requires = 'nvim-treesitter/nvim-treesitter',
			run = ':TSInstall query'
		})

		use({
			'p00f/nvim-ts-rainbow',
			cond = function()
				return require('plugins.plugin-condition-table').enable_plugin_table['nvim-ts-rainbow']
			end,
			requires = 'nvim-treesitter/nvim-treesitter',
		})


	-- LSP Plugins --

		use('neovim/nvim-lspconfig')

		use({
			'williamboman/nvim-lsp-installer',
			requires = 'neovim/nvim-lspconfig',
			config = function()
				require('plugins.configs.lsp').setup()
			end
		})

		use({
			'jose-elias-alvarez/null-ls.nvim',
			requires = {
				'nvim-lua/plenary.nvim',
				'neovim/nvim-lspconfig',
			},
			config = function()
				require('plugins.configs.null-ls').setup()
			end
		})

		use({
			'ray-x/lsp_signature.nvim',
			config = function()
				require('plugins.configs.lsp-signature').setup()
			end
		})

		use({
			'j-hui/fidget.nvim',
			cond = function()
				return require('plugins.plugin-condition-table').enable_plugin_table['fidget']
			end,
			config = function()
				require('fidget').setup({})
			end
		})

		-- Code outline
		use({
			'stevearc/aerial.nvim',
			config = function()
				require('aerial').setup({})
			end
		})


	-- DAP Plugins

		use({
			'mfussenegger/nvim-dap',
			config = function()
				require('plugins.configs.dap').setup()
			end
		})

		use({
			'rcarriga/nvim-dap-ui',
			requires = 'mfussenegger/nvim-dap',
			config = function()
				require('plugins.configs.dap-ui').setup()
			end
		})

		use({
			'theHamsta/nvim-dap-virtual-text',
			requires = 'mfussenegger/nvim-dap',
			config = function()
				require('nvim-dap-virtual-text').setup({})
			end
		})


	-- Other Code-Aware Plugins

		use({
			'vim-test/vim-test',
			config = function()
				require('plugins.configs.vim-test').setup()
			end
		})

		use({
			'ThePrimeagen/refactoring.nvim',
			requires = {
				'nvim-lua/plenary.nvim',
				'nvim-treesitter/nvim-treesitter'
			},
			config = function()
				require('refactoring').setup({})
			end,
		})

		use({
			'kevinhwang91/nvim-ufo',
			requires = 'kevinhwang91/promise-async',
			cond = function()
				return require('plugins.plugin-condition-table').enable_plugin_table['ufo']
			end,
			config = function()
				require('plugins.configs.ufo').setup()
			end,
		})


	-- Completion

		use({
			'hrsh7th/nvim-cmp',
			requires = {
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
		})

		use({
			'L3MON4D3/LuaSnip',
			requires = {
				'saadparwaiz1/cmp_luasnip'
			},
			event = 'InsertEnter',
			config = function()
				require('plugins.configs.luasnip').setup()
			end
		})


	-- Visual Interface Plugins

		use({
			'folke/trouble.nvim',
			requires = 'kyazdani42/nvim-web-devicons',
			config = function()
				require('plugins.configs.trouble').setup()
			end,
		})

		use({
			'kyazdani42/nvim-tree.lua',
			requires = 'kyazdani42/nvim-web-devicons',
			config = function()
				require('plugins.configs.nvim-tree').setup()
			end
		})

		use({
			'mbbill/undotree',
			config = function()
				require('plugins.configs.undo-tree').setup()
			end
		})

		use({
			'akinsho/toggleterm.nvim',
			config = function()
					require('plugins.configs.toggleterm').setup()
			end
		})

		use({
			'sindrets/diffview.nvim',
			config = function()
				require('diffview').setup({})
			end
		})

		use({
			'mhartington/formatter.nvim',
			config = function()
				require('plugins.configs.formatter').setup()
			end
		})

		use({
			'simrat39/symbols-outline.nvim',
			config = function()
				require('plugins.configs.symbols-outline').setup()
			end
		})


	-- Finders

		use({
			'nvim-telescope/telescope.nvim',
			requires = {
				'nvim-lua/plenary.nvim',
				'kyazdani42/nvim-web-devicons',
			},
			config = function()
				require('plugins.configs.telescope').setup()
			end
		})

		use({
			'nvim-telescope/telescope-ui-select.nvim',
			requires = 'nvim-telescope/telescope.nvim',
			config = function()
				require('telescope').load_extension('ui-select')
			end
		})

		use({
			'nvim-telescope/telescope-file-browser.nvim',
			requires = 'nvim-telescope/telescope.nvim',
			config = function()
				require('telescope').load_extension('file_browser')
			end
		})

		use({
			'nvim-telescope/telescope-fzf-native.nvim',
			requires = 'nvim-telescope/telescope.nvim',
			cond = function()
				return require('plugins.plugin-condition-table').enable_plugin_table['telescope-fzf-native']
			end,
			run = 'make',
			opt = true,
			config = function()
				require('telescope').load_extension('fzf')
			end
		})

		-- <Leader>b[etsv] (open/toggle/-split/|split);
		-- then b<Num> switches to buffer
		use('jlanzarotta/bufexplorer')


	-- Code-specific

		-- Fish
			use({
				'blankname/vim-fish',
				ft = 'fish'
			})

		-- Haskell
			use({
				'neovimhaskell/haskell-vim',
				config = function()
					require('plugins.configs.haskell-vim').setup()
				end,
				ft = 'haskell'
			})

		-- Jenkinsfile
			use({
				'martinda/Jenkinsfile-vim-syntax',
				ft = 'Jenkinsfile'
			})

		-- LaTeX
			use({
				'lervag/vimtex',
				ft = 'tex'
			})

		-- Lua
			use({
				'folke/neodev.nvim',
				requires = {
					'neovim/nvim-lspconfig',
					'williamboman/mason-lspconfig',
				},
				config = function()
					require('neodev').setup({})
				end
			})

		-- Markdown
			use({
				'iamcco/markdown-preview.nvim',
				-- Works only if yarn and npm are installed.
				run = 'cd app & yarn install',
				ft = { 'markdown', 'pandoc.markdown', 'rmd' }
			})
			-- Edit '```' markdown codeblocks in separate buffer.
			use({
				'AndrewRadev/inline_edit.vim',
				ft = { 'markdown', 'pandoc.markdown', 'rmd' }
			})

		-- Python
			use({
				'jeetsukumaran/vim-python-indent-black',
				ft = 'python'
			})

		-- Tmux (.tmux.conf)
			use({
				'tmux-plugins/vim-tmux',
				ft = 'tmux'
			})

		-- Typescript
			use({
				'leafgarland/typescript-vim',
				ft = 'typescript'
			})
			use({
				'peitalin/vim-jsx-typescript',
				ft = 'typescript'
			})
			-- use({
			-- 	'jose-elias-alvarez/nvim-lsp-ts-utils',
			-- 	requires = {
			-- 		'neovim/nvim-lspconfig',
			-- 		'jose-elias-alvarez/null-ls.nvim',
			-- 		'nvim-lua/plenary.nvim',
			-- 	},
			-- 	config = function()
			-- 		require('plugins.configs.nvim-lsp-ts-utils').setup()
			-- 	end,
			-- 	ft = 'typescript'
			-- })


	-- Tmux

		use({
			'christoomey/vim-tmux-navigator',  -- Adds vim-tmux navigation commands
			config = function()
				require('plugins.configs.tmux-navigator').setup()
			end
		})

		-- Adds Tyank, Tput, etc., and also <Leader>y
		use('tpope/vim-tbone')


	-- Git

		use({
			'lewis6991/gitsigns.nvim',
			requires = {
				'nvim-lua/plenary.nvim',
			},
			cond = function()
				return require('plugins.plugin-condition-table').enable_plugin_table['gitsigns']
			end,
			config = function()
				require('plugins.configs.gitsigns').setup()
			end
		})

		-- Gives `gitbranch#name()`
		use('itchyny/vim-gitbranch')


	-- Convenience, Productivity, and Quality of Life

		-- Manual

			use({
				'ggandor/leap.nvim',
				config = function()
					require('leap').set_default_keymaps()
				end,
			})

			-- ysiw) cs)] ds] etc.
			use('tpope/vim-surround')

			-- use('machakann/vim-sandwich')

			-- gS, gJ
			use('AndrewRadev/splitjoin.vim')

			use({
				'junegunn/vim-easy-align',  -- gaip + =,*=,<space>.
				config = function()
					require('plugins.configs.easy-align').setup()
				end
			})

			use({
				'b3nj5m1n/kommentary',
				config = function()
					require('plugins.configs.kommentary').setup()
				end,
			})

			-- Extends % and adds [g[]zia]%.
			use('andymass/vim-matchup')

			use({
				'mhinz/vim-sayonara',
				config = function()
					require('plugins.configs.sayonara').setup()
				end
			})

			use({
				'AndrewRadev/sideways.vim',
				config = function()
					require('plugins.configs.sideways').setup()
				end
			})

			use('godlygeek/tabular')

		-- Automatic

			use('tpope/vim-repeat')

			use({
				'windwp/nvim-autopairs',
				requires = {
					'hrsh7th/nvim-cmp',
					'nvim-treesitter/nvim-treesitter',
				},
				config = function()
					require('plugins.configs.autopairs').setup()
				end,
				event = 'InsertEnter'
			})

			use({
				'ethanholz/nvim-lastplace',
				config = function()
					require('nvim-lastplace').setup({
						lastplace_ignore_buftype = {'quickfix', 'nofile', 'help'},
						-- lastplace_ignore_filetype = {},
						lastplace_open_folds = true
					})
				end
			})

			use({
				'JoosepAlviste/nvim-ts-context-commentstring',
				event = 'InsertEnter'
			})

			use({
				'RRethy/nvim-treesitter-endwise',
				requires = 'nvim-treesitter/nvim-treesitter',
				config = function()
					require('nvim-treesitter.configs').setup({
						endwise = {
							enable = true,
						},
					})
				end,
				ft = { 'ruby', 'lua', 'vim', 'bash', 'elixir' }
			})

			use({
				'windwp/nvim-ts-autotag',
				requires = 'nvim-treesitter/nvim-treesitter',
				config = function()
					require('nvim-ts-autotag').setup()
				end,
				ft = {
					'php', 'markdown', 'xml', 'html', 'javascript', 'typescript',
					'javascriptreact', 'typescriptreact', 'tsx', 'jsx'
				}
			})


	-- Visuals

		-- Colourschemes

			use({
				'Mofiqul/vscode.nvim',
				config = function()
					require('plugins.configs.vscode').setup()
				end
			})

		-- Editor

			use({
				'lukas-reineke/indent-blankline.nvim',
				cond = function()
					return require('plugins.plugin-condition-table').enable_plugin_table['indent-blankline']
				end,
				config = function()
					require('plugins.configs.indent-blankline').setup()
				end,
			})

			use({
				'lukas-reineke/virt-column.nvim',
				config = function()
					require("virt-column").setup()
				end,
			})

			use({
				'RRethy/vim-illuminate',
				config = function()
					require('plugins.configs.illuminate').setup()
				end
			})

			use({
				'narutoxy/dim.lua',
				config = function()
					require('dim').setup({})
				end,
			})

		-- UI

			use({
				'stevearc/dressing.nvim',
				requires = 'nvim-telescope/telescope.nvim',
			})

			use({
				'NvChad/nvim-colorizer.lua',
				config = function()
					require('colorizer').setup({ names = false })
				end,
			})

		-- UX

			use({
				'karb94/neoscroll.nvim',
				cond = function()
					return require('plugins.plugin-condition-table').enable_plugin_table['neoscroll']
				end,
				config = function()
					require('plugins.configs.neoscroll').setup()
				end
			})

		-- Modal

			use({
				'Pocco81/TrueZen.nvim',
				config = function()
					require('plugins.configs.true-zen').setup()
				end
			})

			use({
				'junegunn/limelight.vim',
				config = function()
					vim.g.limelight_paragraph_span = 3
				end
			})


	-- Miscellaneous

		use('antoinemadec/FixCursorHold.nvim')

		use({
			'lambdalisue/suda.vim',
			cmd = { 'SudaRead', 'SudaWrite' }
		})

		use('gpanders/editorconfig.nvim')


	-- Finalize

		-- Automatically set up configuration after cloning packer.nvim
		if packer_bootstrap then
			require('packer').sync()
		end
end

require('packer').init({})

return require('packer').startup(plugins)

-- use({
-- 	'williamboman/mason.nvim',
-- 	config = function()
-- 		require('mason').setup()
-- 	end,
-- })
-- use({
-- 	'williamboman/mason-lspconfig.nvim',
-- 	config = function()
-- 		require('mason-lspconfig').setup({
-- 			automatic_installation = true,
-- 		})
-- 		require('configs.lsp').setup()
-- 	end,
-- 	requires = {
-- 		'neovim/nvim-lspconfig',
-- 	},
-- })

-- use({
-- 	'Pocco81/DAPInstall.nvim',
-- 	requires = 'mfussenegger/nvim-dap',
-- 	config = function()
-- 		require('dap-install').setup()
-- 	end,
-- 	cmd = {
-- 		'DIInstall',
-- 		'DIUninstall',
-- 		'DIList',
-- 	},
-- })

-- use({
-- 	'mfussenegger/nvim-dap-python',
-- 	requires = 'mfussenegger/nvim-dap',
-- 	config = function()
-- 		-- TODO
-- 	end,
-- 	ft = { 'python' }
-- })

-- use({
-- 	'leoluz/nvim-dap-go',
-- 	requires = 'mfussenegger/nvim-dap',
-- 	config = function()
-- 		-- TODO
-- 	end,
-- 	ft = { 'go' }
-- })



-- use({
-- 	'nvim-treesitter/nvim-treesitter-textobjects',
-- 	requires = {
-- 		'nvim-treesitter/nvim-treesitter',
-- 	},
-- 	config = function()
-- 		require('configs.nvim-treesitter-textobjects').setup()
-- 	end,
-- })

-- use({
-- 	'ziontee113/syntax-tree-surfer',
-- 	requires = {
-- 		'nvim-treesitter/nvim-treesitter',
-- 	},
-- 	config = function()
-- 		require('configs.syntax-tree-surfer').setup()
-- 	end,
-- })




-- use({
-- 	'lukas-reineke/lsp-format.nvim',
-- 	config = function()
-- 		require('configs.lsp-format')
-- 	end,
-- })



-- use({
-- 	'catppuccin/nvim',
-- 	as = 'catppuccin',
-- 	config = function()
-- 		require('configs.catppuccin').setup()
-- 	end,
-- 	run = ':CatppuccinCompile',
-- })

-- use({
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
-- })


-- use({
-- 	'rcarriga/nvim-notify',
-- 	config = function()
-- 		vim.notify = require('notify')
-- 	end,
-- })

-- use({
-- 	'SmiteshP/nvim-navic',
-- 	requires = {
-- 		'nvim-treesitter/nvim-treesitter',
-- 	},
-- 	config = function()
-- 		require('nvim-navic').setup()
-- 	end,
-- })

-- use({
-- 	'petertriho/nvim-scrollbar',
-- 	requires = {
-- 		'kevinhwang91/nvim-hlslens',
-- 	},
-- 	config = function()
-- 		require('configs.scrollbar').setup()
-- 	end,
-- })

-- use({
-- 	'folke/which-key.nvim',
-- 	config = function()
-- 		require('which-key').setup()
-- 	end,
-- })

-- use({
-- 	'max397574/better-escape.nvim',
-- 	config = function()
-- 		require('configs.better-escape').setup()
-- 	end,
-- })

-- David-Kunz/markid
