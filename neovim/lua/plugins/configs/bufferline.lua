local M = {}

function M.rename_tab()
	vim.ui.input(
		{
			prompt = 'Enter tab title: '
		},
		function(input)
			if input == nil then
				-- Leave tab name unchanged.
			elseif input == '' then
				-- Delete tab name.
				vim.api.nvim_tabpage_set_var(0, 'tab_name', '')
				vim.api.nvim_tabpage_del_var(0, 'tab_name')
			else
				-- Set tab name.
				vim.api.nvim_tabpage_set_var(0, 'tab_name', input)
			end
			-- Refresh tab line.
			vim.cmd('redrawtabline')
		end
	)
end

function M.setup()
	require('bufferline').setup({
		options = {
			mode = 'tabs',
			always_show_bufferline = false,
			diagnostics = false,
			separator_style = 'slant',
			show_duplicate_prefix = false,
			modified_icon = '',
			close_icon = '',
			buffer_close_icon = '',
			offsets = {
				{
					filetype = 'NvimTree',
					text = 'File Explorer',
					text_align = 'center',
					separator = true
				}
			},
			name_formatter = function(inputs)
				local tab_info = vim.fn.gettabinfo(inputs.tabnr)[1]
				if tab_info == nil or tab_info.variables == nil then
					return inputs.name
				end
				return tab_info.variables.tab_name or inputs.name
			end
		},
		highlights = require('plugins.configs.vscode').bufferline_highlights()
	})

	local nmap = require('utils.keymap').nmap
	nmap('<Leader>tr', require('plugins.configs.bufferline').rename_tab, 'Rename the current tab')
end

return M
