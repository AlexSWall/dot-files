local M = {}

function M.setup()

	-- Enables highlighting of...
	vim.g.haskell_enable_quantification   = 1  -- `forall`.
	vim.g.haskell_enable_recursivedo      = 1  -- `mdo` and `rec`.
	vim.g.haskell_enable_arrowsyntax      = 1  -- `proc`.
	vim.g.haskell_enable_pattern_synonyms = 1  -- `pattern`.
	vim.g.haskell_enable_typeroles        = 1  -- type roles.
	vim.g.haskell_enable_static_pointers  = 1  -- `static`.
	vim.g.haskell_backpack                = 1  -- backpack keywords.
end

return M
