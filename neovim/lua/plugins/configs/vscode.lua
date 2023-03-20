local M = {}

M.vscode_colourscheme_colour_overrides = {
	vscFront = '#D1D0D0',
	vscBack = '#0e0e0e',
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

	vscGray = '#707080',

	vscPink = '#C586C0',
	vscLightBlue = '#8CCCEE',
	vscMediumBlue = '#5CACEE',
	vscGreen = '#85CEA0',
	vscBlueGreen = '#2EC9B5',
	vscLightBlueGreen = '#5EF0E5',
	vscRed = '#F44747',
	vscOrange = '#CE9178',  -- Only needed due to specifying it in group_overrides
	vscYellowOrange = '#F7CA8D',
	vscYellow = '#D5D5A3',

	vscFoldBackground = '#121212',

	vscHoverText = '#203845',
	vscLightGray = '#C0C0C0',

	vscStatusForeground = '#CCCCCC',
	vscStatusBackground = '#202328',
	vscStatusNCForeground = '#20202A',
}

M.my_colours = {
	ErrorColour = '#db4b4b',
	WarnColour = '#ff966c',
	InfoColour = '#ffc777',
	HintColour = '#73daca',
	MiscColour = '#bb9af7',

	ScrollHandle = '#181818',
	ScrollCursor = '#606060',
	ScrollSearch = '#0db9d7',

	TabColour = '#191919',
	TabColourSelected = '#303030',
	TabBackgroundColour = '#111111',

	BreakpointColour = '#db4b4b',
	DapLogPointColour = '#ffc777',
	DapStoppedColour = '#73daca',
	DebuggingLinePC = '#202020',
}

function M.setup()

	vim.o.background = 'dark'

	local c = M.vscode_colourscheme_colour_overrides
	local mc = M.my_colours

	-- Set up the colorscheme.
	require('vscode').setup({
		italic_comments = true,

		-- Enable transparent background
		transparent = true,

		-- Disable nvim-tree background color
		disable_nvimtree_bg = false,

		-- Override colors
		color_overrides = M.vscode_colourscheme_colour_overrides,

		-- Override highlight groups
		group_overrides = {
			-- Standard highlight group overrides
			Cursor         = { fg = '#F0F0F0', bg = '#8090C0' },
			StatusLine     = { fg = c.vscStatusForeground, bg = c.vscStatusBackground },
			StatusLineNC   = { fg = c.vscStatusNCForeground, bg = c.vscStatusBackground },
			Folded         = { fg = c.vscLeftLight, bg = c.vscFoldBackground },
			Comment        = { fg = c.vscGray, bg = 'NONE', italic = true },
			SpecialComment = { fg = c.vscGray, bg = 'NONE' },
			String         = { fg = c.vscGreen, bg = 'NONE' },
			Character      = { fg = c.vscGreen, bg = 'NONE' },
			Number         = { fg = c.vscOrange, bg = 'NONE' },
			Float          = { fg = c.vscOrange, bg = 'NONE' },
			Macro          = { fg = c.vscYellowOrange, bg = 'NONE', },
			TSStringRegex  = { fg = c.vscGreen, bg = 'NONE' },
			TSString       = { fg = c.vscGreen, bg = 'NONE' },
			TSCharacter    = { fg = c.vscGreen, bg = 'NONE' },
			TSNumer        = { fg = c.vscOrange, bg = 'NONE' },
			ColorColumn    = { fg = 'NONE', bg = 'NONE' },
			VirtColumn     = { fg = '#202020', bg = 'NONE' },
			LineNr         = { fg = '#404050' },
			CursorLineNr   = { fg = '#11CCEE' },
			MatchParen     = { italic = true },
			MatchWord      = { fg = '#C586C0', bg = '#121212', bold = true, underline = true },

			-- Treesitter highlight group overrides
			['@comment']          = { fg = c.vscGray, bg = 'NONE' },
			['@string']           = { fg = c.vscGreen, bg = 'NONE' },
			['@character']        = { fg = c.vscGreen, bg = 'NONE' },
			['@number']           = { fg = c.vscOrange, bg = 'NONE' },
			['@float']            = { fg = c.vscOrange, bg = 'NONE' },
			['@variable.builtin'] = { fg = c.vscLightBlueGreen, bg = 'NONE' },

			-- Indentation rule colour
			IndentBlanklineIndent = { fg = '#202020', nocombine = true },

			-- Nvim-Cmp
			CmpGhostText          = { fg = '#606060', bg = 'NONE' },
			CmpItemAbbrDeprecated = { fg = '#808080', bg = 'NONE', strikethrough = true },
			CmpItemAbbrMatch      = { fg = '#569CD6', bg = 'NONE' },
			CmpItemAbbrMatchFuzzy = { fg = '#569CD6', bg = 'NONE' },
			CmpItemKindVariable   = { fg = '#9CDCFE', bg = 'NONE' },
			CmpItemKindInterface  = { fg = '#9CDCFE', bg = 'NONE' },
			CmpItemKindText       = { fg = '#9CDCFE', bg = 'NONE' },
			CmpItemKindFunction   = { fg = '#C586C0', bg = 'NONE' },
			CmpItemKindMethod     = { fg = '#C586C0', bg = 'NONE' },
			CmpItemKindKeyword    = { fg = '#D4D4D4', bg = 'NONE' },
			CmpItemKindProperty   = { fg = '#D4D4D4', bg = 'NONE' },
			CmpItemKindUnit       = { fg = '#D4D4D4', bg = 'NONE' },
			CmpItemKind           = { fg = '#D4D4D4', bg = 'NONE' },

			-- Rainbow Brackets (from nvim-ts-rainbow)
			rainbowcol1 = { fg = '#D16969', bg = 'NONE' },
			rainbowcol2 = { fg = '#CE9178', bg = 'NONE' },
			rainbowcol3 = { fg = '#C586C0', bg = 'NONE' },
			rainbowcol4 = { fg = '#6A9955', bg = 'NONE' },
			rainbowcol5 = { fg = '#DCDCAA', bg = 'NONE' },
			rainbowcol6 = { fg = '#569CD6', bg = 'NONE' },
			rainbowcol7 = { fg = '#646695', bg = 'NONE' },

			-- Highlight background of trailing/leading whitespace.
			ExtraWhitespace = { bg = '#223E55' },

			-- lsp_signature hint
			Hint = { fg = '#00CCCC', bg = 'NONE' },

			-- Aerial
			AerialLine = { bg = '#303030', },
			AerialLineNC = { bg = '#303030' },

			-- Leap
			LeapLabelPrimary = { fg = '#000000', bg = '#66BBAA' },  -- Options to select from
			-- LeapMatch = {},
			-- LeapLabelSelected = {},

			-- Nvim-Scrollbar
			HlSearchLens = { fg = 'Red', bg = 'Blue' },  -- Should never appear

			-- Dap
			DapBreakpoint = { fg = mc.BreakpointColour, bold = true },
			DapLogPoint = { fg = mc.DapLogPointColour, bold = true },
			DapStopped = { fg = mc.DapStoppedColour, bold = true },
			debugPC = { bg = mc.DebuggingLinePC, bold = true }
		}
	})

	-- Now load the colorscheme.
	require('vscode').load()
end

function M.bufferline_highlights()

	local c = M.my_colours

	return {
		background            = { bg = c.TabColour },
		tab_close             = { bg = c.TabColour },
		close_button          = { bg = c.TabColour },
		close_button_visible  = { bg = c.TabColour },
		modified              = { bg = c.TabColour },
		modified_visible      = { bg = c.TabColour },
		buffer_selected       = { bg = c.TabColourSelected },
		modified_selected     = { bg = c.TabColourSelected },
		close_button_selected = { bg = c.TabColourSelected },
		separator_selected    = { fg = c.TabBackgroundColour, bg = c.TabColourSelected  },
		separator_visible     = { fg = c.TabBackgroundColour, bg = c.TabColour  },
		separator             = { fg = c.TabBackgroundColour, bg = c.TabColour  },
	}
end

function M.nvim_scrollbar_highlights()

	local c = M.my_colours

	return {
		handle = {
			color = c.ScrollHandle,
		},
		marks = {
			Cursor = { color = c.ScrollCursor },
			Search = { color = c.ScrollSearch, gui = 'bold' },
			Error  = { color = c.ErrorColour, gui = 'bold' },
			Warn   = { color = c.WarnColour, gui = 'bold' },
			Info   = { color = c.InfoColour, gui = 'bold' },
			Hint   = { color = c.HintColour, gui = 'bold' },
			Misc   = { color = c.MiscColour, gui = 'bold' },
		}
	}
end

return M
