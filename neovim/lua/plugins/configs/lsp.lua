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
						'vim',

						-- Busted
						"describe",
						"it",
						"before_each",
						"after_each",
						"teardown",
						"pending",
						"clear"
					}
				},
				completion = {
					callSnippet = 'Replace',
				}
			}
		}
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
	local function keymap(from, to, desc)
		vim.keymap.set('n', from, to, { desc = desc, buffer = 0 } )
	end

	keymap('<C-k>',      vim.lsp.buf.hover,                         'Show hover information')
	keymap('<C-s>',      vim.lsp.buf.signature_help,                'Show function signature')
	keymap('gd',         '<cmd>Telescope lsp_definitions<CR>',      'Show/go to symbol definitions(s)')
	keymap('gt',         '<cmd>Telescope lsp_type_definitions<CR>', 'Show/go to type definition(s)')
	keymap('gi',         '<cmd>Telescope lsp_implementations<CR>',  'Show/go to implementation(s)')
	keymap('gr',         '<cmd>Telescope lsp_references<CR>',       'Show/go to reference(s)')
	keymap('gH',         vim.lsp.buf.code_action,                   'Code action')
	keymap('gD',         '<cmd>Telescope diagnostics<CR>',          'Show diagnostics')
	keymap('[d',         vim.diagnostic.goto_prev,                  'Go to previous diagnostic')
	keymap(']d',         vim.diagnostic.goto_next,                  'Go to next diagnostic')
	keymap('<Leader>rn', vim.lsp.buf.rename,                        'Rename symbol')

	vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, { desc = 'Show signature help', buffer = 0 } )
end

function M.setup()

	require('plugins.configs.lsp').install_servers()

	local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
