local M = {}

function M.setup()
	require('mason-lspconfig').setup({
		ensure_installed = require('plugins.ensure-installed').lsp_servers_to_ensure_installed
	})
end

return M
