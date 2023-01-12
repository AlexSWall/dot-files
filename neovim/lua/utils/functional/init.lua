local _ = {}

---@module 'utils.functional.core'
local core = require('utils.functional.core')
local lazy_require = core.require_on_member_use
_.wrap = function(tbl) return core.wrap(tbl, _) end
_.unwrap = core.unwrap

---@module 'utils.functional.list'
local list = lazy_require('utils.functional.list')
_.map = list.map

return setmetatable(_, {
	__call = function(_tbl, k)
		return _.wrap(k)
	end
})
