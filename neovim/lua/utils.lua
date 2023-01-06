local M = {}

function M.list_to_lookup(tbl)
	local ret = {}
	for _, v in pairs(tbl) do
		ret[v] = true
	end
	return ret
end

function M.lookup_to_list(tbl)
	local ret = {}
	for k, v in pairs(tbl) do
		if v then
			table.insert(ret, k)
		end
	end
	return ret
end

return M
