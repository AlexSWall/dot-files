
--------------------------------------------------------------------------------
--      VS Code Colorscheme
--------------------------------------------------------------------------------

vim.g.vscode_style = 'dark'
vim.g.vscode_italic_comment = 1
vim.cmd('colorscheme vscode')


--------------------------------------------------------------------------------
--      Highlights
--------------------------------------------------------------------------------

vim.cmd([[
	" Styles on matching parentheses and words
	highlight MatchParen cterm=italic gui=italic
	highlight MatchWord guifg=#C586C0 guibg=#121212 cterm=bold,underline gui=bold,underline

	" Indentation rule colour
	highlight IndentBlanklineIndent guifg=#202020 gui=nocombine

	" Cmp Colourschemes
	highlight CmpItemAbbrDeprecated guibg=NONE guifg=#808080 gui=strikethrough
	highlight CmpItemAbbrMatch      guibg=NONE guifg=#569CD6
	highlight CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
	highlight CmpItemKindVariable   guibg=NONE guifg=#9CDCFE
	highlight CmpItemKindInterface  guibg=NONE guifg=#9CDCFE
	highlight CmpItemKindText       guibg=NONE guifg=#9CDCFE
	highlight CmpItemKindFunction   guibg=NONE guifg=#C586C0
	highlight CmpItemKindMethod     guibg=NONE guifg=#C586C0
	highlight CmpItemKindKeyword    guibg=NONE guifg=#D4D4D4
	highlight CmpItemKindProperty   guibg=NONE guifg=#D4D4D4
	highlight CmpItemKindUnit       guibg=NONE guifg=#D4D4D4
	highlight CmpItemKind           guibg=NONE guifg=#D4D4D4
]])
