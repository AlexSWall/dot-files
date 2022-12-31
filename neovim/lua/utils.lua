local M = {}

function M.table_to_lookup(tbl)
	local ret = {}
	for _, v in pairs(tbl) do
		ret[v] = true
	end
	return ret
end

return M
