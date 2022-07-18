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
		print('Installing ' .. name)
		server:install()
	end
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local function on_attach(_, _)

	local function keymap(from, to)
		vim.keymap.set('n', from, to, { buffer = 0 } )
	end

	keymap('<C-k>',     vim.lsp.buf.hover)
	keymap('gd',         '<cmd>Telescope lsp_definitions<CR>')
	keymap('gt',         '<cmd>Telescope lsp_type_definitions<CR>')
	keymap('gi',         '<cmd>Telescope lsp_implementations<CR>')
	keymap('gr',         '<cmd>Telescope lsp_references<CR>')
	keymap('gH',         vim.lsp.buf.code_action)
	keymap('gD',         '<cmd>Telescope diagnostics<CR>')
	keymap('[d',         vim.diagnostic.goto_prev)
	keymap(']d',         vim.diagnostic.goto_next)
	keymap('<Leader>rn', vim.lsp.buf.rename)
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
		local luadev = require('lua-dev').setup({})
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
			},
			mccabe = {
				Threshold = 25
			}
		}
	end,

	['tsserver'] = function(opts)
		opts.settings = {
			tsserver = {
				suggest = {
					autoImports = true;
				}
			}
		}
	end
}

lsp_installer.on_server_ready(function(server)

	-- Default options used for setting up all servers
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
		single_file_support = true
	}

	-- Add LSP Server-specific options
	if enhance_server_opts[server.name] then
		enhance_server_opts[server.name](opts)
	end

	server:setup(opts)
end)

require('null-ls').setup({
	sources = {
		require('null-ls').builtins.code_actions.shellcheck,
		require('null-ls').builtins.diagnostics.shellcheck.with({
			diagnostics_format = '[#{c}] #{m} (#{s})'
		}),
	},
})

require('dapui').setup()
require('dap').listeners.after.event_initialized['dapui_config'] = function() require('dapui').open()  end
require('dap').listeners.before.event_terminated['dapui_config'] = function() require('dapui').close() end
require('dap').listeners.before.event_exited['dapui_config']     = function() require('dapui').close() end

require('nvim-dap-virtual-text').setup()

-- -- dap-python.setup() takes the path to the python executable which has debugpy
-- -- installed.
-- require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
-- table.insert(require('dap').configurations.python, {
--   type = 'python',
--   request = 'launch',
--   name = 'My custom launch configuration',
--   program = '${file}',
--   -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
-- })

require('dap-go').setup()

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
		s('req', fmt("local {} = require('{}')", { i(1, 'default'), rep(1) }))
	}
}

cmp.setup({
		mapping = {
			['<C-y>'] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				}),
			['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
			['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
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

require('lsp_signature').setup({
	hint_enable = false,
	floating_window_above_cur_line = false,
	transparency = 30,
	toggle_key = '<C-s>',
	floating_window_off_y = -4,
})

require 'nvim-treesitter.install'.compilers = { 'clang' }
require('nvim-treesitter.configs').setup({
	ensure_installed = { 'bash', 'c', 'comment', 'cpp', 'css', 'dockerfile', 'erlang', 'fish', 'go', 'gomod', 'haskell', 'html', 'java', 'javascript', 'json', 'latex', 'lua', 'make', 'markdown', 'php', 'python', 'rust', 'tsx', 'typescript', 'vim', 'yaml' },
	highlight = {
		enable = false,  -- Must be false for correct PHP indentation
		additional_vim_regex_highlighting = false
	},
	indent = {
		enable = false,  -- Must be false for correct PHP indentation
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

local telescope = require('telescope')
telescope.setup({
   defaults = {
		-- The default value:
		vimgrep_arguments = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case'
		}
	},
	extensions = {
		['ui-select'] = {
			require('telescope.themes').get_dropdown({})
		},
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = true,  -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
			case_mode = 'smart_case',        -- or 'ignore_case' or 'respect_case'
			-- the default case_mode is 'smart_case'
		}
	}
})

-- telescope.load_extension('fzf')
telescope.load_extension('ui-select')
telescope.load_extension('file_browser')

require'nvim-tree'.setup({
	hijack_cursor = true,
	filters = {
		custom = {
			'^.*\\.pyc$'
		}
	}
})

-- require('gitsigns').setup({
-- 	on_attach = function(bufnr)
-- 		local gs = package.loaded.gitsigns

-- 		local function map(l, r, opts)
-- 			opts = opts or {}
-- 			opts.buffer = bufnr
-- 			vim.keymap.set('n', l, r, opts)
-- 		end

-- 		map('<leader>gj', gs.next_hunk)
-- 		map('<leader>gk', gs.prev_hunk)
-- 		map('<leader>gp', gs.preview_hunk)
-- 		map('<leader>gd', gs.diffthis)
-- 		map('<leader>gr', gs.reset_hunk)
-- 		map('<leader>gt', gs.toggle_deleted)
-- 		map('<leader>gb', gs.toggle_current_line_blame)

-- 		map('<Leader>]', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
-- 		map('<Leader>[', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})
-- 	end
-- })

-- require('bufferline').setup {
-- 	options = {
-- 		mode = 'buffers',
-- 		offsets = {
-- 			{
-- 				filetype = 'NvimTree',
-- 				text = function()
-- 					return vim.fn.getcwd()
-- 				end,
-- 				highlight = 'Directory',
-- 				text_align = 'left'
-- 			}
-- 		},
-- 		show_buffer_icons = false,
-- 		show_buffer_close_icons = false,
-- 		show_tab_indicators = false,
-- 		always_show_bufferline = false
-- 	}
-- }

local Rule = require('nvim-autopairs.rule')
local autopairs = require('nvim-autopairs')

autopairs.setup({})

autopairs.add_rules({
	-- Python triple quotes
	Rule("'''", "'''", { 'python' }),
	Rule('"""', '"""', { 'python' }),

	-- Triple-backticks in .txt and markdown files
	Rule("```", "```", { 'text', 'markdown' }),
	Rule("```.*$", "```", { 'text', 'markdown' })
		:only_cr()
		:use_regex(true),
})

require('dim').setup({})

require('colorizer').setup({}, {
	names = false
})

local true_zen = require('true-zen')

true_zen.setup({
	integrations = {
		tmux = true,
		-- gitsigns = true,
		limelight = true
	}
})

true_zen.after_mode_ataraxis_on = function ()

	vim.opt.showmode = false
	vim.opt.showcmd = false
	vim.opt.scrolloff = 999

	vim.g.number_toggle_on = 0
	vim.opt.relativenumber = false
end

true_zen.before_mode_ataraxis_off = function ()
	vim.opt.showmode = true
	vim.opt.showcmd = true
	vim.opt.scrolloff = 3

	vim.g.number_toggle_on = 1
	vim.opt.relativenumber = true
end

require('indent_blankline').setup({
	space_char_blankline = ' ',
	char_highlight_list = { 'IndentBlanklineIndent' },
})

require('nvim-lastplace').setup({
    lastplace_ignore_buftype = {'quickfix', 'nofile', 'help'},
    -- lastplace_ignore_filetype = {},
    lastplace_open_folds = true
})

-- require('neoscroll').setup({
-- 	-- easing_function = 'quadratic'
-- 	mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zt', 'zz', 'zb'},
-- })

-- require('neoscroll.config').set_mappings({
-- 	['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '70'}},
-- 	['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '70'}},
-- 	['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '140'}},
-- 	['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '140'}},
-- 	['zt']    = {'zt', {'70'}},
-- 	['zz']    = {'zz', {'70'}},
-- 	['zb']    = {'zb', {'70'}}
-- })

require('toggleterm').setup({
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-q>]],
  direction = 'vertical'
})

vim.g['test#strategy'] = 'neovim'

require('nvim-treesitter.configs').setup({
  context_commentstring = {
    enable = true
  }
})


vim.o.background = 'dark'

local vscode_colourscheme_colour_overrides = {
	vscFront = '#D1D0D0',
	vscBack = '#121212',
	vscTabCurrent = '#0E0E0E',
	vscTabOther = '#222222',
	vscTabOutside = '#151516',

	vscLeftDark = '#151516',
	vscLeftMid = '#20202A',
	vscLeftLight = '#5F5F66',

	vscPopupBack = '#121212',
	vscPopupHighlightGray = '#2b3034',

	vscCursorDarkDark = '#101010',

	vscSearchCurrent = '#4B5632',
	vscSearch = '#264F78',

	vscGray = '#606060',

	vscLightBlue = '#8CCCEE',
	vscGreen = '#85CEA0',
	vscBlueGreen = '#2EC9B5',
	vscOrange = '#CE9178',  -- Only needed due to specifying it in group_overrides
	vscYellow = '#D5D5A3',


	vscFoldBackground = '#121212',

	vscHoverText = '#203845',
	vscLightGray = '#C0C0C0',

	vscStatusForeground = '#CCCCCC',
	vscStatusBackground = '#191919',
	vscStatusNCForeground = '#20202A',
}

local c = vscode_colourscheme_colour_overrides

require('vscode').setup({
	italic_comments = true,

	-- Enable transparent background
	transparent = true,

	-- Disable nvim-tree background color
	disable_nvimtree_bg = true,

	-- Override colors
	color_overrides = vscode_colourscheme_colour_overrides,

	-- Override highlight groups
	group_overrides = {
		StatusLine     = { fg = c.vscStatusForeground, bg = c.vscStatusBackground },
		StatusLineNC   = { fg = c.vscStatusNCForeground, bg = c.vscBack },
		Folded         = { fg = c.vscLeftLight, bg = c.vscFoldBackground },
		Comment        = { fg = c.vscGray, bg = 'NONE', italic = true },
		SpecialComment = { fg = c.vscGray, bg = 'NONE' },
		String         = { fg = c.vscGreen, bg = 'NONE' },
		Character      = { fg = c.vscGreen, bg = 'NONE' },
		Number         = { fg = c.vscOrange, bg = 'NONE' },
		Float          = { fg = c.vscOrange, bg = 'NONE' },
		TSStringRegex  = { fg = c.vscGreen, bg = 'NONE' },
		TSString       = { fg = c.vscGreen, bg = 'NONE' },
		TSCharacter    = { fg = c.vscGreen, bg = 'NONE' },
		TSNumer        = { fg = c.vscOrange, bg = 'NONE' },

		-- CursorLine = { bg = c.vscHoverText }
		-- MatchParen = { fg = c.vscPink, bg = c.vscBack }
	}
})
