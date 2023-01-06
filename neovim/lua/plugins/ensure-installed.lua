local M = {}

M.lsp_servers_to_ensure_installed = require('utils').lookup_to_list({
	bashls        = true,   -- bash
	clangd        = true,   -- C, C++
	cmake         = true,   -- CMake
	cssls         = true,   -- CSS
	dockerls      = true,   -- Docker
	erlangls      = false,  -- Erlang
	hls           = false,  -- Haskell
	html          = true,   -- HTML
	intelephense  = true,   -- PHP
	pyright       = true,   -- Python
	rust_analyzer = false,  -- Rust
	sumneko_lua   = true,   -- Lua
	taplo         = false,  -- Toml
	texlab        = true,   -- LaTeX
	tsserver      = true,   -- Typescript, Javascript
	vimls         = true,   -- Vimscript
	yamlls        = true,   -- Yaml
})

M.treesitter_parsers_to_ensure_installed = {
	'bash', 'c', 'comment', 'cpp', 'css', 'dockerfile', 'erlang', 'fish', 'go',
	'gomod', 'haskell', 'help', 'html', 'java', 'javascript', 'json', 'latex',
	'lua', 'make', 'markdown', 'php', 'python', 'rust', 'tsx', 'typescript',
	'vim', 'yaml'
}

return M
