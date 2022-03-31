
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
	highlight CmpItemAbbrDeprecated guifg=#808080 guibg=NONE gui=strikethrough
	highlight CmpItemAbbrMatch      guifg=#569CD6 guibg=NONE
	highlight CmpItemAbbrMatchFuzzy guifg=#569CD6 guibg=NONE
	highlight CmpItemKindVariable   guifg=#9CDCFE guibg=NONE
	highlight CmpItemKindInterface  guifg=#9CDCFE guibg=NONE
	highlight CmpItemKindText       guifg=#9CDCFE guibg=NONE
	highlight CmpItemKindFunction   guifg=#C586C0 guibg=NONE
	highlight CmpItemKindMethod     guifg=#C586C0 guibg=NONE
	highlight CmpItemKindKeyword    guifg=#D4D4D4 guibg=NONE
	highlight CmpItemKindProperty   guifg=#D4D4D4 guibg=NONE
	highlight CmpItemKindUnit       guifg=#D4D4D4 guibg=NONE
	highlight CmpItemKind           guifg=#D4D4D4 guibg=NONE

	highlight Sneak      guifg=#111111 guibg=#466F98
	highlight SneakScope guifg=#111111 guibg=#466F98
]])
