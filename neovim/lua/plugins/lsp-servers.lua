local M = {}

M.lsp_servers = {
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
	yamlls        = true    -- Yaml
}

return M
