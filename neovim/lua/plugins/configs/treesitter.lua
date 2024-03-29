local M = {}

function M.setup()

	require('nvim-treesitter.install').compilers = {
		'clang'
	}

	local ts_rainbow_enabled = require('plugins.plugin-condition-table').enable_plugin_table['nvim-ts-rainbow']

	require('nvim-treesitter.configs').setup({

		ensure_installed = require('plugins.ensure-installed').treesitter_parsers_to_ensure_installed,

		highlight = {
			enable = true,  -- Must be false for correct PHP indentation
			additional_vim_regex_highlighting = false
		},

		-- Broken for Python, YAML, C++, PHP, maybe Javascript...
		indent = {
			enable = false,
		},

		-- Broken for Python, C++...
		-- yati = {
		-- 	enable = true,
		-- 	disable = { 'cpp', 'python' }
		-- },

		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = '<C-Space>',
				node_incremental = '<C-Space>',
				scope_incremental = '<C-l>',
				node_decremental = '<C-h>'
			}
		},

		textobjects = {
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					[']f'] = { query = '@function.outer', desc = 'Go to start of next function'},
					[']c'] = { query = '@class.outer', desc = 'Go to start of next class' }
				},
				goto_next_end = {
					[']F'] = { query = '@function.outer', desc = 'Go to end of next function' },
					[']C'] = { query = '@class.outer', desc = 'Go to end of next class' }
				},
				goto_previous_start = {
					['[f'] = { query = '@function.outer', desc = 'Go to start of previous function' },
					['[c'] = { query = '@class.outer', desc = 'Go to start of previous class' }
				},
				goto_previous_end = {
					['[F'] = { query = '@function.outer', desc = 'Go to end of previous function' },
					['[C'] = { query = '@class.outer', desc = 'Go to end of previous class' }
				}
			}
		},

		matchup = {
			enable = true
		},

		rainbow = {
			enable        = ts_rainbow_enabled,
			extended_mode = ts_rainbow_enabled,
			--max_file_lines = <num>
		}
	})
end

return M
