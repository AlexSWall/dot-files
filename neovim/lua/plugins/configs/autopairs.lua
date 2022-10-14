M = {}

function M.setup()

	local Rule = require('nvim-autopairs.rule')
	local autopairs = require('nvim-autopairs')

	autopairs.setup({})

	autopairs.add_rules({
		-- Python triple quotes
		Rule("'''", "'''", { 'python' }),
		Rule('"""', '"""', { 'python' }),

		-- Triple-backticks in .txt and markdown files
		Rule("```", "```", { 'text', 'markdown' }),
		Rule("```.*$", "```", { 'text', 'markdown' })
			:only_cr()
			:use_regex(true),
	})
end

return M
