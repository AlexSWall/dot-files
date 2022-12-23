local M = {}

function M.setup()

	vim.o.background = 'dark'

	local vscode_colourscheme_colour_overrides = {
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

		vscGray = '#909090',

		vscLightBlue = '#8CCCEE',
		vscMediumBlue = '#5CACEE',
		vscGreen = '#85CEA0',
		vscBlueGreen = '#2EC9B5',
		vscLightBlueGreen = '#5EF0E5',
		vscOrange = '#CE9178',  -- Only needed due to specifying it in group_overrides
		vscYellowOrange = '#F7DA8D',
		vscYellow = '#D5D5A3',


		vscFoldBackground = '#121212',

		vscHoverText = '#203845',
		vscLightGray = '#C0C0C0',

		vscStatusForeground = '#CCCCCC',
		vscStatusBackground = '#161616',
		vscStatusNCForeground = '#20202A',
	}

	local c = vscode_colourscheme_colour_overrides

	require('vscode').setup({
		italic_comments = true,

		-- Enable transparent background
		transparent = true,

		-- Disable nvim-tree background color
		disable_nvimtree_bg = false,

		-- Override colors
		color_overrides = vscode_colourscheme_colour_overrides,

		-- Override highlight groups
		group_overrides = {
			-- Standard highlight group overrides
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
			ColorColumn    = { fg = 'NONE', bg = 'NONE' },
			VirtColumn     = { fg = '#202020', bg = 'NONE' },
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
		}
	})
end

function M.bufferline_highlights()

	local tab_colour = '#191919'
	local tab_colour_selected = '#282828'
	local tab_background_colour = '#111111'

	return {
		background = { bg = tab_colour },
		buffer_selected = { bg = tab_colour_selected, italic = false },
		tab_close = { bg = tab_colour },
		close_button = { bg = tab_colour },
		close_button_visible = { bg = tab_colour },
		close_button_selected = { bg = tab_colour_selected },
		modified = { bg = tab_colour },
		modified_visible = { bg = tab_colour },
		modified_selected = { bg = tab_colour_selected },
		separator_selected = { fg = tab_background_colour, bg = tab_colour_selected  },
		separator_visible = { fg = tab_background_colour, bg = tab_colour  },
		separator = { fg = tab_background_colour, bg = tab_colour  },
	}
end

return M
