local M = {}

function M.setup()
	local nmap = require('utils.keymap').nmap
	nmap('n',  [[<Cmd>execute('normal! ' . v:count1 . 'nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>]])
	nmap('N',  [[<Cmd>execute('normal! ' . v:count1 . 'Nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>]])
	nmap('*',  [[*``<Cmd>lua require('hlslens').start()<CR>]])
	nmap('#',  [[#N<Cmd>lua require('hlslens').start()<CR>]])
	nmap('g*', [[g*``<Cmd>lua require('hlslens').start()<CR>]])
	nmap('g#', [[g#N<Cmd>lua require('hlslens').start()<CR>]])
end

return M
