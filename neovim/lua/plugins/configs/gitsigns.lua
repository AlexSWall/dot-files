local M = {}

function M.setup()

	require('gitsigns').setup({
		on_attach = function(bufnr)

			local function map(l, r, desc, opts)
				opts = opts or {}
				opts.buffer = bufnr
				opts.desc = desc
				vim.keymap.set('n', l, r, opts)
			end

			local gs = package.loaded.gitsigns
			map('<leader>gj', gs.next_hunk, 'Go to next git hunk')
			map('<leader>gk', gs.prev_hunk, 'Go to previous git hunk')
			map('<leader>gp', gs.preview_hunk, 'Preview git hunk')
			map('<leader>gd', gs.diffthis, 'View git diff of current hunk')
			map('<leader>gr', gs.reset_hunk, 'Reset current hunk')
			map('<leader>gt', gs.toggle_deleted, 'Toggle deleted')
			map('<leader>gb', gs.toggle_current_line_blame, 'Toggle git blame')
			map(']c', function()
				if vim.wo.diff then return ']c' end
				vim.schedule(function() gs.next_hunk() end)
				return '<Ignore>'
			end, 'Go to next git hunk', { expr=true })
			map('[c', function()
				if vim.wo.diff then return '[c' end
				vim.schedule(function() gs.prev_hunk() end)
				return '<Ignore>'
			end, 'Go to previous git hunk', { expr=true })
		end
	})

end

return M

