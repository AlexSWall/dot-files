local M = {}

M.dump = function(o, filepath)

	local d = vim.inspect(o)

	if filepath then
		local f = assert(io.open(filepath, 'w'))
		f:write(d)
		f:close()
	else
		print(d)
	end

	return d
end

return M
