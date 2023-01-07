local M = {}

function M.setup()

	local code_actions = require('null-ls').builtins.code_actions
	local diagnostics  = require('null-ls').builtins.diagnostics
	local formatting   = require('null-ls').builtins.formatting

	local ruff_extra_args = {
		-- Removed:
		-- - McCabe (C90),
		-- - flake8-blind-except (BLE),
		-- - flake8-print (T20),
		-- - flake8-errmsg (EM),
		-- - eradicate (ERA),
		-- - flake8-pie (PIE)
		'--select', 'F,E,W,I,D,UP,N,YTT,ANN,S,FBT,B,A,C4,T10,ISC,ICN,PT,Q,RET,SIM,TID,ARG,DTZ,PD,PGH,PLC,PLE,PLR,PLW,RUF',
		'--ignore', ''
		-- These are covered by pyright.
		.. 'F401,F821,F841,'
		-- 'Temporarily allow no docstrings.'
		-- .. 'D100,D101,D102,D103,D104,D105,D106,D107,'
		-- No blank lines before class docstring.
		.. 'D203,'
		-- Don't force one-line docstrings.
		.. 'D200,'
		-- Multiline docstrings should start on next line.
		.. 'D212,'
		-- Allow dynamically-typed expressions via typing.Any.
		.. 'ANN401,'
		-- Allow unittest.assertEquals (etc.)
		.. 'PT009,'
		-- Allow single quotes.
		.. 'Q000,Q001'
		.. '',
		'--line-length', '120'
	}

	require('null-ls').setup({
		sources = {
			-- All
			diagnostics.codespell,

			-- Bash
			code_actions.shellcheck,
			diagnostics.shellcheck.with({
				diagnostics_format = '[#{c}] #{m} (#{s})'
			}),

			-- C/C++
			-- diagnostics.cpplint,
			formatting.clang_format,

			-- Python
			diagnostics.ruff.with({
				extra_args = ruff_extra_args
			}),
			diagnostics.pycodestyle,  -- Catches too many blank lines, whitespace issues, etc.
			formatting.ruff.with({
				extra_args = ruff_extra_args
			}),
			formatting.blue,  -- Preferable to Black.
			formatting.autopep8,  -- Slower but catches additional errors such as whitespace issues.

			-- Lua
			formatting.stylua,

			-- Javascript
			diagnostics.eslint_d,
			code_actions.eslint_d,
			formatting.prettierd,
		},
	})
end

return M
