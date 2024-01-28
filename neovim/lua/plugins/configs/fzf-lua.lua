local M = {}

function M.setup()

	require('fzf-lua').setup({
		'telescope',
		winopts={
			preview={
				default='bat'
			}
		}
	})

	local nmap = require('utils.keymap').nmap

	nmap('<Leader>fa', require('fzf-lua').live_grep_native,  'Live fuzzy search file contents')
	nmap('<Leader>fb', require('fzf-lua').blines,            'Fuzzy search buffers')
	nmap('<Leader>ff', require('fzf-lua').files,             'Fuzzy search filepaths')
	nmap('<Leader>fg', require('fzf-lua').grep,              'Fuzzy search on search for specific input')
end

return M
