local _ = {}

function _.require_on_member_use(require_path)
	return setmetatable({}, {
		__index = function(_, key)
			return function(...)
				return require(require_path)[key](...)
			end
		end
	})
end

function _.wrap(tbl, _)
	return setmetatable({tbl = tbl}, { __index = _ })
end

function _.unwrap(tbl)
	return tbl.tbl
end

return _
