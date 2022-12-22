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
	rust_analyzer = false,  -- Rust
	sumneko_lua   = true,   -- Lua
	taplo         = false,  -- Toml
	texlab        = true,   -- LaTeX
	tsserver      = true,   -- Typescript, Javascript
	vimls         = true,   -- Vimscript
	yamlls        = true,   -- Yaml

   -- Python:
	pyright              = true,
	jedi_language_server = false,
	sourcery             = false,
	pylsp                = false,
}

M.servers_to_ensure_installed = function()

	local servers_to_ensure_installed = {}

	for name, enabled in pairs(M.lsp_servers) do
		if enabled == true then
			table.insert(servers_to_ensure_installed, name)
		end
	end

	return servers_to_ensure_installed

end

return M
