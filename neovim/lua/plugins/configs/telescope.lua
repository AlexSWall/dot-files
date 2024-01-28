local M = {}

local conf = require('telescope.config').values
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local pickers = require('telescope.pickers')

local flatten = vim.tbl_flatten

M.fuzzy_search_text = function( opts )

	opts = opts or {}

	-- Used by gen_from_vimgrep to ensure we only sort based on text and not
	-- filenames.
	opts.only_sort_text = true;

	-- Create custom entry_maker using only_sort_text = true.
	opts.entry_maker = make_entry.gen_from_vimgrep( opts )

	local args = flatten({ conf.vimgrep_arguments, '--', ''})

	pickers.new(opts, {
		prompt_title = 'Fuzzy Search Text',
		finder = finders.new_oneshot_job( args, opts ),
		previewer = conf.grep_previewer( opts ),
		sorter = conf.generic_sorter( opts )
	}):find()
end

function M.setup()

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
			},
			file_ignore_patterns = {
				'.?venv[0-9]*',
				'node_modules',
				'target'
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

	local nmap = require('utils.keymap').nmap

	-- Commented out are probably due to using fzf-lua instead:

	--nmap('<Leader>fa', require('plugins.configs.telescope').fuzzy_search_text,    'Fuzzy search text')
	--nmap('<Leader>fa', require('telescope.builtin').live_grep,                    'Fuzzy search text')
	--nmap('<Leader>fb', require('telescope.builtin').buffers,                      'Fuzzy search buffers')
	nmap('<Leader>fd', require('telescope.builtin').diagnostics,                  'Fuzzy search diagnostics')
	nmap('<Leader>fe', require('telescope').extensions.file_browser.file_browser, 'Telescope file browser')
	--nmap('<Leader>ff', require('telescope.builtin').find_files,                   'Fuzzy search files')
	--nmap('<Leader>fg', require('telescope.builtin').git_files,                    'Fuzzy search git files')
	nmap('<Leader>fh', require('telescope.builtin').help_tags,                    'Fuzzy search help tags')
	nmap('<Leader>fk', require('telescope.builtin').keymaps,                      'Fuzzy search keymaps')
	nmap('<Leader>fm', require('telescope.builtin').keymaps,                      'Fuzzy search keymaps')
	nmap('<Leader>fr', require('telescope.builtin').registers,                    'Fuzzy search registers')
	nmap('<Leader>fs', require('telescope.builtin').grep_string, 'Fuzzy search on instances of current string')
	nmap('<Leader>fA', function()
		require('telescope.builtin').grep_string({
			search_dirs = { vim.fn.input('Dir: ', '',  'dir') },
			search=''
		})
	end, 'Fuzzy search text in specific directory')
end

return M
