local M = {}

local relative_number_toggle_ignore_list = {
	help = true,
	NvimTree = true,
	Outline = true,
	toggleterm = true,
	TelescopePrompt = true,
	Trouble = true,
	tsplayground = true
}

local number_toggle_on = true

local relative_number_toggle = function(state)

	if (vim.bo.filetype == '') or (relative_number_toggle_ignore_list[vim.bo.filetype] == true) then
		-- We're never setting the relative number for this filetype.
		vim.opt_local.relativenumber = false

	elseif require("true-zen.ataraxis").running then
		vim.opt_local.relativenumber = false

	elseif number_toggle_on == false then
		-- Skip toggle

	elseif state == 'on' then
		vim.opt_local.relativenumber = true

	elseif state == 'off' then
		vim.opt_local.relativenumber = false
	end
end

M.set_number_toggle = function(state)

	if state == 'enable' then

		number_toggle_on = true

		local numToggleGrp = vim.api.nvim_create_augroup('NumberToggle', { clear = true })

		vim.api.nvim_create_autocmd({'BufEnter', 'FocusGained', 'InsertLeave'}, {
			callback = function() relative_number_toggle('on') end,
			group = numToggleGrp
		})

		vim.api.nvim_create_autocmd({'BufLeave', 'FocusLost', 'InsertEnter'}, {
			callback = function() relative_number_toggle('off') end,
			group = numToggleGrp
		})

	elseif state == 'disable' then

		number_toggle_on = false

		vim.api.nvim_create_augroup('NumberToggle', { clear = true })

	end
end

return M
