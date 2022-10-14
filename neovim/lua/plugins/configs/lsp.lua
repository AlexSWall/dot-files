M = {}

function M.install_servers()
	-- Install any LSP servers we want which aren't installed.
	for name, enabled in pairs(require('plugins.lsp-servers').lsp_servers) do
		if enabled == true then
			local server_is_found, server = require('nvim-lsp-installer').get_server(name)
			if server_is_found and not server:is_installed() then
				print('Installing ' .. name)
				server:install()
			end
		end
	end
end

M.enhance_server_opts = {
	['sumneko_lua'] = function(opts)
		opts.settings = {
			Lua = {
				diagnostics = {
					globals = {
						'vim'
					}
				},
				completion = {
					callSnippet = 'Replace',
				}
			}
		}

		-- Add lua-dev to the mix
		local lua_dev = require('lua-dev').setup({})
		for k,v in pairs(lua_dev) do opts[k] = v end
	end,

	['pylsp'] = function(opts)
		opts.settings = {
			pylsp = {
				plugins = {
					jedi_completion = {
						include_params = true,
					}
				}
			},
			mccabe = {
				Threshold = 25
			}
		}
	end,

	['tsserver'] = function(opts)
		opts.settings = {
			tsserver = {
				suggest = {
					autoImports = true;
				}
			}
		}
	end,

	['clangd'] = function(opts)
		-- See https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
		opts.capabilities.offsetEncoding = { 'utf-16' }
	end
}

function M.add_keymaps()
	local function keymap(from, to)
		vim.keymap.set('n', from, to, { buffer = 0 } )
	end

	keymap('<C-k>',      vim.lsp.buf.hover)
	keymap('<C-s>',      vim.lsp.buf.signature_help)
	keymap('gd',         '<cmd>Telescope lsp_definitions<CR>')
	keymap('gt',         '<cmd>Telescope lsp_type_definitions<CR>')
	keymap('gi',         '<cmd>Telescope lsp_implementations<CR>')
	keymap('gr',         '<cmd>Telescope lsp_references<CR>')
	keymap('gH',         vim.lsp.buf.code_action)
	keymap('gD',         '<cmd>Telescope diagnostics<CR>')
	keymap('[d',         vim.diagnostic.goto_prev)
	keymap(']d',         vim.diagnostic.goto_next)
	keymap('<Leader>rn', vim.lsp.buf.rename)

	vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, { buffer = 0 } )
end

function M.get_capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

	return capabilities
end

function M.setup()

	require('plugins.configs.lsp').install_servers()

	local capabilities = require('plugins.configs.lsp').get_capabilities()

	require('nvim-lsp-installer').on_server_ready(function(server)

		-- Default options used for setting up all servers
		local opts = {
			on_attach = require('plugins.configs.lsp').add_keymaps,
			capabilities = capabilities,
			single_file_support = true
		}

		-- Add LSP Server-specific options
		if require('plugins.configs.lsp').enhance_server_opts[server.name] then
			require('plugins.configs.lsp').enhance_server_opts[server.name](opts)
		end

		server:setup(opts)
	end)
end

return M
