local M = {}

function M.set_indentation(indent_width, use_tabs)
	vim.opt_local.tabstop     = indent_width
	vim.opt_local.shiftwidth  = indent_width
	vim.opt_local.softtabstop = indent_width
	vim.opt_local.expandtab   = not use_tabs
end

function M.set_filetype_indentation(filetypes, indent_width, use_tabs)
	vim.api.nvim_create_autocmd('Filetype', {
		pattern = filetypes,
		callback = function() M.set_indentation(indent_width, use_tabs) end
	})
end

function M.setup()
	local opt = vim.opt

	opt.autoindent = true            -- Copy indent to next line.
	opt.smartindent = false          -- Interferes with `filetype indent on`
	opt.cindent = false              -- Interferes with `filetype indent on`

	-- Default indentation
	opt.expandtab = false            -- Use tabs instead of spaces
	opt.shiftwidth = 3               -- Shift 3 spaces when tab
	opt.tabstop = 3                  -- 1 tab == 3 spaces
	opt.softtabstop = 3              -- 1 tab == 3 spaces

	-- Filetype-specific space indentation:
	M.set_filetype_indentation('haskell,yaml,python,markdown', 4, false)
end

return M
