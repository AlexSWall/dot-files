local M = {}

function M.setup()
	require("twilight").setup({
		context = 10
	})
end

return M

