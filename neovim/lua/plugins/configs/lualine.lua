local M = {}

local function add_macro_recording_refresh_autocmds()

	local lualine_refresh_fn = function()
		require('lualine').refresh({ place = { 'statusline' } })
	end

	vim.api.nvim_create_autocmd('RecordingEnter', { callback = lualine_refresh_fn })

	vim.api.nvim_create_autocmd('RecordingLeave', {
		callback = function()
			-- vim.fn.reg_recording does not empty immediately, so wait 50ms.
			local timer = vim.loop.new_timer()
			timer:start(50, 0, vim.schedule_wrap(lualine_refresh_fn))
		end
	})
end

local function lualine()
	-- Author: shadmansaleh; Credit: glepnir

	local colors = {
		bg       = '#202328',
		fg       = '#bbc2cf',
		yellow   = '#ECBE7B',
		cyan     = '#00a0d0',
		darkcyan = '#607090',
		darkblue = '#081633',
		green    = '#48be65',
		orange   = '#FF8800',
		violet   = '#a9a1e1',
		magenta  = '#c678dd',
		blue     = '#51afef',
		red      = '#ec5f67',
	}

	local conditions = {
		buffer_not_empty = function()
			return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
		end,
		hide_in_width = function()
			return vim.fn.winwidth(0) > 80
		end
	}

	-- Config
	local config = {
		options = {
			-- Disable sections and component separators.
			component_separators = '',
			section_separators = '',
			theme = {
				normal   = { c = { fg = colors.fg, bg = colors.bg } },
				inactive = { c = { fg = colors.fg, bg = colors.bg } },
			},
			disabled_filetypes = {
				'toggleterm', 'NvimTree', 'aerial'
			}
		},
		sections = {
			-- Remove the defaults.
			lualine_a = {},
			lualine_b = {},
			lualine_y = {},
			lualine_z = {},
			-- These will be populated.
			lualine_c = {},
			lualine_x = {},
		},
		inactive_sections = {
			-- Remove the defaults.
			lualine_a = {},
			lualine_b = {},
			lualine_y = {},
			lualine_z = {},
			lualine_c = {},
			lualine_x = {},
		},
	}

	-- Pushes a component into lualine_c; the left section.
	local function ins_left(component)
		table.insert(config.sections.lualine_c, component)
		table.insert(config.inactive_sections.lualine_c, component)
	end

	-- Pushes a component into lualine_x; the right section.
	local function ins_right(component)
		table.insert(config.sections.lualine_x, component)
		table.insert(config.inactive_sections.lualine_x, component)
	end

	-- Pushes a component into lualine_c; the left section.
	local function ins_left_active(component)
		table.insert(config.sections.lualine_c, component)
	end

	-- Pushes a component into lualine_x; the right section.
	local function ins_right_active(component)
		table.insert(config.sections.lualine_x, component)
	end

	-- Pushes a component into lualine_c; the left section.
	local function ins_left_inactive(component)
		table.insert(config.inactive_sections.lualine_c, component)
	end

	-- Pushes a component into lualine_x; the right section.
	local function ins_right_inactive(component)
		table.insert(config.inactive_sections.lualine_x, component)
	end

	-- Left bar; `▊`.
	ins_left_active({
		function()
			return '▊'
		end,
		color = { fg = colors.blue },
		-- No space needed beforehand.
		padding = { left = 0, right = 1 }
	})

	ins_left_inactive({ function() return ' ' end, padding = { left = 0, right = 1 } })
	ins_left_inactive({ function() return '   ' end, padding = { right = 1 } })

	-- Mode; ``.
	ins_left_active({
		function()
			return ' ' .. vim.fn.mode():upper()
		end,
		color = function()
			-- Auto-change colour according to Neovim's mode.
			local mode_color = {
				n = colors.red,
				i = colors.green,
				v = colors.blue,
				V = colors.blue,
				c = colors.magenta,
				no = colors.red,
				s = colors.orange,
				S = colors.orange,
				[''] = colors.orange,
				ic = colors.yellow,
				R = colors.violet,
				Rv = colors.violet,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				['r?'] = colors.cyan,
				['!'] = colors.red,
				t = colors.red,
			}
			return { fg = mode_color[vim.fn.mode()], gui = 'bold' }
		end,
		padding = { right = 1 },
	})

	-- Filename; e.g. `foo.cpp`.
	ins_left({
		'filename',
		cond = conditions.buffer_not_empty,
		color = { fg = colors.magenta },
		padding = { left = 1, right = 0 }
	})

	-- Location; e.g. `26:6`.
	ins_left({ 'location', padding = { left = 1, right = 0 } })

	-- Progress; e.g. `28%`.
	ins_left({ 'progress', color = { fg = colors.fg, gui = 'bold' } })

	-- Diagnostics, e.g. ` 3  1  8`.
	ins_left({
		'diagnostics',
		sources = { 'nvim_diagnostic' },
		symbols = { error = ' ', warn = ' ', info = ' ' },
		diagnostics_color = {
			color_error = { fg = colors.red },
			color_warn = { fg = colors.yellow },
			color_info = { fg = colors.cyan },
		},
	})

	-- Insert mid section.
	ins_left({
		function()
			return '%='
		end,
	})

	-- TODO Add showcmd entry on Neovim v0.9.
	-- See: https://github.com/neovim/neovim/issues/20882
	-- See: https://github.com/neovim/neovim/pull/21202

	-- Search Count; e.g. [23/81]
	ins_right({
		function ()
			local sc =  vim.fn.searchcount({ recompute = 1 })
			local current = sc.current
			local total = sc.total
			return '[' .. current .. '/' .. total .. ']'
		end,
		cond = function ()
			return vim.fn.searchcount({ recompute = 1 }).exact_match == 1
		end,
		color = { fg = '#88aa88' },
	})

	-- Macro Recording
	ins_right({
		function ()
			local recording_register = vim.fn.reg_recording()
			if recording_register == '' then
				return ''
			else
				return 'Recording @' .. recording_register
			end
		end,
		color = { fg = colors.green }
	})

	add_macro_recording_refresh_autocmds()

	-- Git diff; e.g.  10  2  1
	ins_right({
		'diff',
		symbols = { added = ' ', modified = ' ', removed = ' ' },
		diff_color = {
			added = { fg = colors.green },
			modified = { fg = colors.orange },
			removed = { fg = colors.red },
		},
		cond = conditions.hide_in_width,
	})

	-- Git branch; e.g. ` main`.
	ins_right({
		'branch',
		icon = '',
		color = { fg = colors.violet, gui = 'bold' },
	})

	-- File encoding; e.g. `utf-8`.
	ins_right({
		'o:encoding',
		fmt = string.lower,
		cond = conditions.hide_in_width,
		color = { fg = colors.darkcyan, gui = 'bold' },
	})

	ins_right({
		'fileformat',
		icons_enabled = false,
		fmt = string.lower,
		cond = conditions.hide_in_width,
		color = { fg = colors.darkcyan, gui = 'bold' },
	})

	-- Right bar; `▊`.
	ins_right_active({
		function()
			return '▊'
		end,
		color = { fg = colors.blue },
		padding = { left = 1 },
	})
	ins_right_inactive({ function() return ' ' end, padding = { left = 1 } })

	require('lualine').setup(config)
end

function M.my_setup()
	-- Status Line
	vim.g.StatusLineGit = function()

		if vim.fn.exists('*gitbranch#name') ~= 0 then

			local branch_name = vim.fn['gitbranch#name']()

			if string.len(branch_name) > 0 then
				return '  ' .. branch_name .. ' '
			end
		end

		return ''
	end

	vim.opt.statusline = '%#StatusLine# %{StatusLineGit()} %f %y'
	                  .. ' %{&fileencoding?&fileencoding:&encoding}:%{&fileformat}'
	                  .. ' %h%w%m%r'
	                  .. "  %{%v:lua.require('nvim-navic').get_location()%}"
	                  .. ' %#StatusLineNC#%=-%12.(%#StatusLine#'
	                  .. ' %l,%c%V%) '

	-- Fill status line with hyphens.
	vim.opt.fillchars['stl'] = '-'
	vim.opt.fillchars['stlnc'] = '-'

	vim.opt.cmdheight = 0

end

function M.setup()
	lualine()
	vim.opt.cmdheight = 0
end

return M
