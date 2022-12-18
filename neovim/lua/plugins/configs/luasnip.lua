M = {}

function M.setup()

	-- LuaSnip
	local luasnip = require('luasnip')
	local fmt     = require('luasnip.extras.fmt').fmt
	local rep     = require('luasnip.extras').rep
	local s       = luasnip.s
	local i       = luasnip.insert_node

	luasnip.config.set_config({
		history = true,
		updateevents = 'TextChanged,TextChangedI',
		-- enable_autosnippets = true,
	})

	luasnip.snippets = {
		-- Available in any filetype
		all = {
		},

		-- Available in Lua files only
		lua = {
			luasnip.parser.parse_snippet('expand', '-- This is what was expanded'),
			luasnip.parser.parse_snippet('lf', 'local $1 = function($2)\n\t$0\n' .. 'end'),
			s('req', fmt("local {} = require('{}')", { i(1, 'default'), rep(1) }))
		}
	}

	-- LuaSnip
	--
	--		<C-[jkl]>
	--
	vim.keymap.set({'i', 's'}, '<C-k>', function()
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { silent = true, desc = 'Go to next luasnip node' })

	vim.keymap.set({'i', 's'}, '<C-j>', function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { silent = true, desc = 'Go to previous luasnip node' })

	vim.keymap.set('i', '<C-l>', function()
			if luasnip.choice_active() then
				luasnip.change_choice(1)
			end
		end, { silent = true, desc = '???' })

	-- vim.keymap.set('i', '<C-h>', function()
	-- 		if luasnip.choice_active() then
	-- 			luasnip.change_choice(-1)
	-- 		end
	-- 	end, { silent = true, desc = '???' })
end


return M
