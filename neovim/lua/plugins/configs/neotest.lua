local M = {}

local _ = require('utils.functional')

function M.setup()

	local rules = _{
		'neotest_python/unittest.py',
		'neotest_python/__init__.py',
		'neotest.py'
	}:map(function(fp)
		return {
			path = vim.fn.expand('$HOME/.local/share/nvim/lazy/neotest-python/' .. fp),
			include = false
		}
	end)

	require("neotest").setup({
		adapters = {
			require("neotest-python")({
				dap = {
					rules = rules
				}
			}),
			require("neotest-plenary"),
			require("neotest-vim-test")({
				ignore_file_types = { "python", "vim", "lua" },
			}),
		},
	})

	-- For vim-test.
	vim.g['test#strategy'] = 'neovim'

	local nmap = require('utils.keymap').nmap

	local r = require('neotest').run.run

	nmap('<Leader>tt', function() r()                   end, 'Run nearest test ')
	nmap('<Leader>tf', function() r(vim.fn.expand('%')) end, 'Run tests for current file')
	nmap('<Leader>dt', function() r({strategy = 'dap'}) end, 'Debug nearest test')
	nmap('<Leader>ts', require('neotest').run.stop, 'Stop running tests')
	nmap('<Leader>ta', require('neotest').run.attach, 'Attach to the nearest test')
	-- nmap('<Leader>tl', '<cmd>TestLast<CR>', 'Run the last test run')
	-- nmap('<Leader>tv', '<cmd>TestVisit<CR>', 'Open last run test in current buffer')
end

return M

