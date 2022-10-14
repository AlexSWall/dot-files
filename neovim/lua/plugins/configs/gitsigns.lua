M = {}

function M.setup()

	require('gitsigns').setup({
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set('n', l, r, opts)
			end

			map('<leader>gj', gs.next_hunk)
			map('<leader>gk', gs.prev_hunk)
			map('<leader>gp', gs.preview_hunk)
			map('<leader>gd', gs.diffthis)
			map('<leader>gr', gs.reset_hunk)
			map('<leader>gt', gs.toggle_deleted)
			map('<leader>gb', gs.toggle_current_line_blame)

			map('<Leader>]', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
			map('<Leader>[', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})
		end
	})

end

return M

