M = {}

local conf = require("telescope.config").values
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"

local flatten = vim.tbl_flatten

M.fuzzy_search_text = function( opts )

	local opts = opts or {}

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

return M
