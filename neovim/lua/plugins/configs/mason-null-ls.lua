local M = {}

function M.setup()
	require('mason-null-ls').setup({
		automatic_installation = true
	})
end

return M
