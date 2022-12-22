local M = {}

function M.setup()

	local cmp     = require('cmp')
	local lspkind = require('lspkind')

	cmp.setup({
		mapping = {
			['<C-y>'] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
			['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
			['<C-e>'] = cmp.mapping.close(),
			['<C-c>'] = cmp.mapping.abort(),
			['<C-d>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			-- <C-p> and <C-n> for previous and next already work by default
		},

		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
			{ name = 'buffer', keyword_length = 5 },
		}),

		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)
			end,
		},

		formatting = {
			format = lspkind.cmp_format({
				with_text = true,
				mode = 'text',
				menu = {
					buffer   = '[buf]',
					nvim_lsp = '[LSP]',
					nvim_lua = '[api]',
					path     = '[path]',
					luasnip  = '[snip]'
				}
			})
		},

		experimental = {
			ghost_text = {
				hl_group = 'CmpGhostText'
			}
		}
	})

end

return M
