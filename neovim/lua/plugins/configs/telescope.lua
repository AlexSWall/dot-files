M = {}

local conf = require("telescope.config").values
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"

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
		prompt_title = "Fuzzy Search Text",
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

	-- Telescope
	--
	--		<Leader>f[abfgvrA]
	--
	local nmap = require('utils.keymap').nmap

	nmap('<Leader>fa', require('plugins.configs.telescope').fuzzy_search_text)
	nmap('<Leader>fA', function()
		require('telescope.builtin').grep_string({
			search_dirs = { vim.fn.input('Dir: ', '',  'dir') },
			search=''
		})
	end)
	nmap('<Leader>fb', require('telescope.builtin').buffers)
	nmap('<Leader>fb', require('telescope.builtin').buffers)
	nmap('<Leader>fd', require('telescope.builtin').diagnostics)
	nmap('<Leader>fe', require('telescope').extensions.file_browser.file_browser)
	nmap('<Leader>ff', require('telescope.builtin').find_files)
	nmap('<Leader>fg', require('telescope.builtin').git_files)
	nmap('<Leader>fk', require('telescope.builtin').keymaps)
	nmap('<Leader>fm', require('telescope.builtin').keymaps)
	nmap('<Leader>fr', require('telescope.builtin').registers)
	nmap('<Leader>fs', require('telescope.builtin').grep_string)

end

return M
