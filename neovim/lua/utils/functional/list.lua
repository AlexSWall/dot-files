local _ = {}

local core = require('utils.functional.core')

function _.map(tbl, f)
	return vim.tbl_map(f, core.unwrap(tbl))
end

return _
