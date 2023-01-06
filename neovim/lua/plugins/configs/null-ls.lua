local M = {}

function M.setup()

	local code_actions = require('null-ls').builtins.code_actions
	local diagnostics  = require('null-ls').builtins.diagnostics
	local formatting   = require('null-ls').builtins.formatting

	require('null-ls').setup({
		sources = {
			-- All
			diagnostics.codespell,

			-- Bash
			code_actions.shellcheck,
			diagnostics.shellcheck.with({
				diagnostics_format = '[#{c}] #{m} (#{s})'
			}),

			-- Python
			diagnostics.flake8.with({
				extra_args = {
					-- These are covered by pyright.
					'--ignore', 'F401,F821,F841',
					'--max-line-length', '120'
				}
			}),

			formatting.black,
			formatting.isort,
			formatting.stylua,

			-- Javascript
			diagnostics.eslint_d,
			code_actions.eslint_d,
			formatting.prettierd,
		},
	})
end

return M
