
local c = require('vscode.colors')
local additional_highlight_groups_config =
{
	-- Styles on matching parentheses and words
	MatchParen = { italic = true },
	MatchWord = { fg = '#C586C0', bg = '#121212', bold = true, underline = true },

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

	-- Vim-Sneak
	Sneak      = { fg = '#111111', bg = '#466F98' },
	SneakScope = { fg = '#111111', bg = '#466F98' },

	-- Rainbow Brackets (from vim-ts-rainbow)
	rainbowcol1 = { fg = c.vscLightRed, bg = 'NONE' },
	rainbowcol2 = { fg = c.vscOrange,   bg = 'NONE' },
	rainbowcol3 = { fg = c.vscPink,     bg = 'NONE' },
	rainbowcol4 = { fg = c.vscGreen,    bg = 'NONE' },
	rainbowcol5 = { fg = c.vscYellow,   bg = 'NONE' },
	rainbowcol6 = { fg = c.vscBlue,     bg = 'NONE' },
	rainbowcol7 = { fg = c.vscViolet,   bg = 'NONE' },
}

for group, val in pairs(additional_highlight_groups_config) do
	vim.api.nvim_set_hl(0, group, val)
end
