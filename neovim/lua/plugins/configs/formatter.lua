M = {}

function M.setup()

	require('utils.keymap').nmap('<Leader>F', ':Format<CR>')

	require('formatter').setup({
		filetype = {
			python = {
				function()
					return {
						exe = 'black',
						args = {
							'--skip-string-normalization',
							'--line-length', '120',
							'-q',
							'-'
						},
						stdin = true
					}
				end
			}
		}
	})
end

return M
