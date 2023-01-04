local M = {}

function M.setup()
	local vscode_hls = require('plugins.configs.vscode').nvim_scrollbar_highlights()
	require("scrollbar").setup({
		handlers = {
			cursor = false,
			diagnostic = true,
			gitsigns = false,  -- Set up manually below.
			handle = true,
			search = false  -- Set up manually below.
		},
		handle = vscode_hls.handle,
		marks = vscode_hls.marks
	})
	-- require("scrollbar.handlers.gitsigns").setup()
	require("scrollbar.handlers.search").setup({
		-- Disable hlslens
		override_lens = function() end
	})
end

return M
