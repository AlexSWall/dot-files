local M = {}

function M.setup()
	require('mason-lspconfig').setup({
		ensure_installed = require('plugins.lsp-servers').servers_to_ensure_installed()
	})
end

return M
