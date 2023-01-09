local M = {}

function M.python_env()
	-- Attempts to find the Python virtual environment.
	--
	-- 1. Search environment for VIRTUAL_ENV or (failing that) CONDA_DEFAULT_ENV.
	-- 2. Search for a venv folder in the current working directory
	--    (via the pattern '.?v?env.?')
	-- 3. Search for the system Python.
	--
	-- On success, a dictionary containing python_path and bin_dir is returned.
	-- On failure, nil is returned.

	local path = require('lspconfig/util').path
	local join = path.join

	-- Use virtualenv or conda env if present.
	if vim.env.VIRTUAL_ENV or vim.env.CONDA_DEFAULT_ENV then
		local bin_dir = join(vim.env.VIRTUAL_ENV or vim.env.CONDA_DEFAULT_ENV, 'bin')
		return {
			python_path = join(bin_dir, 'python'),
			bin_dir = bin_dir
		}
	end

	-- Search for venv patterns in current working directory.
	for _, pattern in ipairs({
		'venv', 'venv?', '.venv', '.venv?', 'env', '.env'
	}) do
		local matches = vim.fn.glob(join(vim.fn.getcwd(), pattern), true, true)
		local _, match = next(matches)
		if match and path.exists(join(match, 'bin', 'python')) then
			local bin_dir = join(match, 'bin')
			return {
				python_path = join(bin_dir, 'python'),
				bin_dir = bin_dir
			}
		end
	end

	-- No Python environment found, try to use the system Python.
	local python_path = vim.fn.exepath('python3') or vim.fn.exepath('python') or nil
	if python_path then
		return {
			python_path = python_path,
			bin_dir = path.dirname(python_path)
		}
	end

	return nil
end

M.enhance_server_opts = {
	['sumneko_lua'] = function(opts)

		local runtime_path = vim.split(package.path, ';')
		table.insert(runtime_path, 'lua/?.lua')
		table.insert(runtime_path, 'lua/?/init.lua')

		opts.settings = {
			Lua = {
				runtime = {
					version = 'LuaJIT',
					path = runtime_path,
				},
				diagnostics = {
					globals = {
						'vim',

						-- Busted
						'describe',
						'it',
						'before_each',
						'after_each',
						'teardown',
						'pending',
						'clear'
					}
				},
				completion = {
					callSnippet = 'Replace',
				},
				telemetry = { enable = false },
				workspace = {
					-- Remove 'Do you need to configure your work environment as'
					-- prompts on opening Lua files.
					checkThirdParty = false
				}
			}
		}
	end,

	['pyright'] = function(opts)
		-- https://github.com/microsoft/pyright/blob/main/docs/settings.md
		opts.settings = {
			pyright = {
				-- Use ruff instead.
				disableOrganizeImports = true,
			},
			python = {
				analysis = {
					autoImportCompletions = true,

					-- Alternatively 'workspace', but may be slow.
					diagnosticMode = 'openFilesOnly',

					typeCheckingMode = 'basic',
				}
			},
		}

		opts.before_init = function(_, config)
			local python_env = M.python_env()
			if python_env == nil then
				return
			end
			config.settings.python.pythonPath = python_env.python_path
		end
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

	local nmap = require('utils.keymap').nmap
	local imap = require('utils.keymap').imap

	nmap('<C-k>',      vim.lsp.buf.hover,                         'Show hover information')
	nmap('<C-s>',      vim.lsp.buf.signature_help,                'Show (function) signature help')
	imap('<C-s>',      vim.lsp.buf.signature_help,                'Show (function) signature help')
	nmap('gd',         '<cmd>Telescope lsp_definitions<CR>',      'Show/go to symbol definitions(s)')
	nmap('gt',         '<cmd>Telescope lsp_type_definitions<CR>', 'Show/go to type definition(s)')
	nmap('gi',         '<cmd>Telescope lsp_implementations<CR>',  'Show/go to implementation(s)')
	nmap('gr',         '<cmd>Telescope lsp_references<CR>',       'Show/go to reference(s)')
	nmap('gH',         vim.lsp.buf.code_action,                   'Code action')
	nmap('gD',         '<cmd>Telescope diagnostics<CR>',          'Show diagnostics')
	nmap('[d',         vim.diagnostic.goto_prev,                  'Go to previous diagnostic')
	nmap(']d',         vim.diagnostic.goto_next,                  'Go to next diagnostic')
	nmap('<Leader>rn', vim.lsp.buf.rename,                        'Rename symbol')

	-- Use null_ls for formatting.
	-- (Can be changed to only occur for certain LSPs if needed.)
	local format_buffer_cmd = function()
		vim.lsp.buf.format({
			filter = function(buf_client)
				return buf_client.name == "null-ls"
			end
		})
	end
	nmap('<Leader>F', format_buffer_cmd, 'Format file using null-ls')
end

function M.setup_lsp_plugins()
	require('neodev').setup({})
end

function M.setup()

	local servers = require('plugins.ensure-installed').lsp_servers_to_ensure_installed

	M.setup_lsp_plugins()

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

	for _, server in ipairs(servers) do

		-- Default options used for setting up all servers
		local opts = {
			on_attach = function(client, bufnr)
				if client.server_capabilities.documentSymbolProvider then
					require('nvim-navic').attach(client, bufnr)
				end
			end,
			capabilities = capabilities,
			single_file_support = true
		}

		-- Add LSP Server-specific options
		if M.enhance_server_opts[server] then
			M.enhance_server_opts[server](opts)
		end

		require('lspconfig')[server].setup(opts)
	end

	local signs = { Error = '', Warn = '', Info = '', Hint = '' }
	for type, icon in pairs(signs) do
		local hl = 'DiagnosticSign' .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	M.add_keymaps()
end

return M
