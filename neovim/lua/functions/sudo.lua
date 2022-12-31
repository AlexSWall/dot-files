local M = {}

local log = require('utils.log')

local sudo_password_cached = nil

local function get_sudo_password()
	local password = sudo_password_cached
	if not password then
		vim.fn.inputsave()
		password = vim.fn.inputsecret('Password: ')
		vim.fn.inputrestore()
	end
	return password
end

function M.sudo_exec(cmd, print_output)
	local password = get_sudo_password()
	if not password or #password == 0 then
		log.warn('Invalid password, sudo aborted')
		return false
	end

	local out = vim.fn.system(string.format('sudo -p "" -S %s', cmd), password)

	if vim.v.shell_error ~= 0 then
		sudo_password_cached = nil
		print('\r\n')
		log.err(out)
		return false
	end

	sudo_password_cached = password

	if print_output then
		print('\r\n', out)
	end

	return true
end

function M.sudo_write(tmpfile, filepath)
	tmpfile = tmpfile or vim.fn.tempname()
	filepath = filepath or vim.fn.expand('%')
	if not filepath or #filepath == 0 then
		log.err('E32: No file name')
		return
	end

	-- `bs=1048576` is equivalent to `bs=1M` for GNU dd or `bs=1m` for BSD dd.
	-- Both `bs=1M` and `bs=1m` are non-POSIX.
	local cmd = string.format(
		'dd if=%s of=%s bs=1048576',
		vim.fn.shellescape(tmpfile),
		vim.fn.shellescape(filepath)
	)

	-- No need to check error as this fails the entire function.
	vim.api.nvim_exec(string.format('write! %s', tmpfile), true)

	if M.sudo_exec(cmd) then
		log.info(string.format('\r\n"%s" written', filepath))
		vim.cmd('e!')
		vim.opt.readonly = false
	end
	vim.fn.delete(tmpfile)
end

return M
