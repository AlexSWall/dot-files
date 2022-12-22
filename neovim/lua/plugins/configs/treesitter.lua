local M = {}

function M.setup()

	require('nvim-treesitter.install').compilers = {
		'clang'
	}

	require('nvim-treesitter.configs').setup({

		ensure_installed = {
			'bash', 'c', 'comment', 'cpp', 'css', 'dockerfile', 'erlang', 'fish', 'go', 'gomod', 'haskell', 'help', 'html', 'java', 'javascript', 'json', 'lua', 'make', 'markdown', 'php', 'python', 'rust', 'tsx', 'typescript', 'vim', 'yaml',
			-- latex
		},

		highlight = {
			enable = true,  -- Must be false for correct PHP indentation
			additional_vim_regex_highlighting = false
		},

		indent = {
			enable = true,  -- Must be false for correct PHP indentation
			disable = { 'yaml' }
		},

		matchup = {
			enable = true
		},

		-- rainbow = {
		-- 	enable = true,
		-- 	extended_mode = true
		-- },

		context_commentstring = {
			enable = true
		}
	})
end

return M
