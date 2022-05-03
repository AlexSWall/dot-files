-- Misc
-- 	alt-e
-- 		On the command line, open the command line in vim
--
-- Built-In
-- 	gi
-- 		Jump to last insert mode location
-- 	gv
-- 		start visual mode and automatically select previous selection
-- 	g;
-- 	`.
-- 		Just to last modification
-- 	@:
-- 		Run last command line entered
-- 	&
-- 		Repeat the last substitute command without flags.
-- 	y/);<CR>
-- 		Yank up to );
-- 	Ctrl-6/^
-- 		Swap between the last two used buffers.
-- 	gv
-- 		Highlight last selection
-- 	Ctrl-o
-- 		Do a single command while in insert mode
-- 		E.g. `Ctrl-o, h` to most left one.
-- 	gw
-- 		Reorganize to go up to eighty character limit.
-- 		For example, gwip is in paragraph, <selection>gw formats selection
-- 		visual block and then `g Ctrl-a` increments all the numbers in the
-- 		block sequentially.
--
-- Plugins
-- 	<Leader>bd
-- 		Sayonara buffer delete
-- 	<Leader>m
-- 		Toggle maximize
-- 	<Leader>FP
-- 		Neoformat
-- 	<Ctrl>q
-- 		Toggle terminal (<Leader>TT and <Leader>TL to move it)
-- 	<Leader>tt
-- 		Run test (<Leader>tf for file, <Leader>tl for last, <Leader>tv for visit last)
-- 	<Ctrl>s
-- 		Toggle LSP signature
-- 	<Leader><Leader>h
-- 	<Leader><Leader>l
-- 		Move argument/entry/etc. left/right (sideways.vim)
-- 	<Leader>tw
-- 	<Leader>tW
-- 		Turn trailing-whitespace highlighting on and off

--------------------------------------------------------------------------------
--      Leader Key
--------------------------------------------------------------------------------

vim.g.mapleader = ' '


--------------------------------------------------------------------------------
--      Keymapping Helpers
--------------------------------------------------------------------------------

local _helpers = {

	map = function(mode, shortcut, command)
		vim.api.nvim_set_keymap(mode, shortcut, command,
			{ noremap = true, silent = true })
	end,

	map_expr = function(mode, shortcut, command)
		vim.api.nvim_set_keymap(mode, shortcut, command,
			{ noremap = true, silent = true, expr = true })
	end

}

local helpers = {

	map_expr = _helpers.map_expr,

	nmap = function(shortcut, command)
		_helpers.map('n', shortcut, command)
	end,

	nmap_expr = function(shortcut, command)
		_helpers.map_expr('n', shortcut, command)
	end,

	vmap = function(shortcut, command)
		_helpers.map('v', shortcut, command)
	end,

	vmap_expr = function(shortcut, command)
		_helpers.map_expr('v', shortcut, command)
	end,

	tmap = function(shortcut, command)
		_helpers.map('t', shortcut, command)
	end,

	xmap = function(shortcut, command)
		_helpers.map('x', shortcut, command)
	end

}

local keymap = vim.api.nvim_set_keymap
local nmap = helpers.nmap
local nmap_expr = helpers.nmap_expr
local vmap = helpers.vmap
local tmap = helpers.tmap
local xmap = helpers.xmap


--------------------------------------------------------------------------------
--      Keymappings
--------------------------------------------------------------------------------

local keymaps = {

	in_built = {

		fundamental = function()

			-- Swap ':' and ';'.
			keymap('n', ';', ':', { noremap = true })
			keymap('v', ';', ':', { noremap = true })
			-- We remap : to <Plug>Sneak_; later

			-- Set <Esc> to go to normal mode in :term (instead of quitting)
			tmap('<Esc>', '<C-\\><C-n>')

			-- Write and quit.
			nmap('<leader>w', ':w<CR>')
			nmap('<Leader>W', ':SudaWrite<CR>')
			nmap('<Leader>q', ':q<CR>')
			nmap('<Leader><Leader>q', ':q!<CR>')

			-- Move up and down via gj and gk by default unless a count is given.
			nmap_expr('j', '(v:count == 0 ? \'gj\' : \'j\')')
			nmap_expr('k', '(v:count == 0 ? \'gk\' : \'k\')')

			-- Keep n and N centred and unfolded
			nmap('n', 'nzzzv')
			nmap('N', 'Nzzzv')

		end,

		navigation = {

			same_buffer = function()

				-- Fast up-down movement.
				nmap('<Leader>j', '10j')
				nmap('<Leader>k', '10k')

				-- Set <Leader>N to search for the next instance of the word under
				-- the cursor; easier to do than *
				nmap('<Leader>N', '*')

				-- While in visual mode, use <Leader>/ to search for the selected text.
				vmap('<Leader>/', 'y/\\V<C-R>=escape(@","/\")<CR><CR>')

			end,

			navigating_buffer = function()

				-- 'Previous' and 'next' Buffers.
				nmap('<Leader>h', ':bprev<CR>')
				nmap('<Leader>l', ':bnext<CR>')

				-- Go to most recent buffer.
				nmap('<Leader>bb', ':b#<CR>')

			end,

			navigating_splits = function()

				-- Quickly create splits.
				nmap('<Leader>-', ':sp<CR>')
				nmap('<Leader><Bar>', ':vs<CR>')

			end,

			navigating_tabs = function()

				-- Open in new tab.
				nmap('<Leader>z', ':tab sp<CR>')

				-- Switch between vim tabs.
				nmap('<Leader>1', '1gt')
				nmap('<Leader>2', '2gt')
				nmap('<Leader>3', '3gt')
				nmap('<Leader>4', '4gt')
				nmap('<Leader>5', '5gt')
				nmap('<Leader>6', '6gt')
				nmap('<Leader>7', '7gt')
				nmap('<Leader>8', '8gt')
				nmap('<Leader>9', '9gt')

			end,

			navigating_files = function()

				-- Edit Neovim config
				nmap('<Leader>ve', ':e ~/.config/nvim/lua/config.lua<CR>')

				-- Reload Neovim config
				nmap('<Leader>vr', ':so ~/.config/nvim/init.lua<CR>')

				-- Allow gf to edit non-existent files too
				nmap('gf', ':edit <cfile><CR>')

			end

		},

		convenience = function()

			-- Easy pasting previous yank (normal + visual).
			nmap('<Leader>p', '"0p')
			vmap('<Leader>p', '"0p')
			nmap('<Leader>P', '"0P')
			vmap('<Leader>P', '"0p')

			-- Reselect visual selection after indenting.
			vmap('<', '<gv')
			vmap('>', '>gv')

			-- Select text just pasted (preserving 'type' of register used)
			function _G.select_pasted_text()
				return '`[' .. vim.fn.strpart(vim.fn.getregtype(), 0, 1) .. '`]'
			end
			nmap_expr('gp', 'v:lua.select_pasted_text()')

			-- Leak cursor in final location after visual yank.
			vmap('y', 'myy`y')
			vmap('Y', 'myY`y')

			-- Redo last macro.
			nmap('<Leader>.', '@@')

			-- Run q macro easily.
			-- This allows for qq<macro recording>q followed by Q.
			-- Overwrites initial Q mapping, which starts Ex mode.
			nmap('Q', '@q')
			vmap('Q', ':norm @q<CR>')

			-- Toggle paste
			nmap('<Leader>tp', ':set paste!<CR>')

			-- :noh shortcut
			nmap('<Leader>no', ':noh<CR>')

			-- Leak cursor in final location after visual yank.
			vmap('y', 'myy`y')
			vmap('Y', 'myY`y')

		end,

		complex_functionality = function()

			-- Use <Leader>d etc. to yank text into the yank register before
			-- deleting it.
			nmap('<Leader>dd', 'dd:let @0=@"<CR>')
			nmap('<Leader>D', 'D:let @0=@"<CR>')
			vmap('<Leader>d', 'd:let @0=@"<CR>')

			-- Move highlighted text (in visual mode) up and down using J and K.
			vmap('J', ":m '>+1<CR>gv=gv")
			vmap('K', ":m '<-2<CR>gv=gv")

			-- Repeat a macro 5000 times or until failure.
			nmap_expr('<Leader>Q', '"5000@" .. nr2char(getchar()) .. "\\<ESC>"')

			-- Reformat the entire file while leaving view position the same.
			--
			-- To do this, this key mapping creates two marks, q and w, to set
			-- current location and top row of view respectively, then formats the
			-- entire file, and finally moves back to the location of the cursor
			-- mark while setting the top of the view to the same place as before.
			-- This therefore overwrites marks q and w.
			--
			nmap('<Leader>=', 'mqHmwgg=G`wzt`q')

			-- Disable GUI for multi-line copying of vim contents by an external
			-- program.
			nmap('<Leader>0',
				':Gitsigns detach<CR>' ..
				':set nonumber norelativenumber nolinebreak nobreakindent signcolumn=no showbreak= <CR>' ..
				':call SetNumberToggle(\'disable\')<CR>')
			--
			-- Reenable GUI
			nmap('<Leader><Leader>0',
				':Gitsigns attach<CR>' ..
				':set number relativenumber linebreak breakindent signcolumn=yes showbreak=↪\\ <CR>' ..
				':call SetNumberToggle(\'enable\')<CR>')

		end,

		visual = function()

			nmap('<Leader>tw', ':highlight ExtraWhitespace ctermbg=darkblue guibg=darkblue<CR>')
			nmap('<Leader>tW', ':highlight ExtraWhitespace NONE<CR>')

		end

	},

	plugins = {

		-- Easy Align
		--
		--		ga
		--
		easy_align = function()
			-- Interactive visual mode (e.g. vipga).
			xmap('ga', '<Plug>(EasyAlign)')

			-- Interactive for a motion/text object (e.g. gaip).
			nmap('ga', '<Plug>(EasyAlign)')
		end,

		-- Easymotion
		--
		--		<Leader><Leader>[swef...]
		--
		easy_motion = function()
		end,

		-- LuaSnip
		--
		--		<C-[jkl]>
		--
		lua_snip = function()
			local luasnip = require('luasnip')

			vim.keymap.set({'i', 's'}, '<C-k>', function()
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				end
				end, { silent = true })

			vim.keymap.set({'i', 's'}, '<C-j>', function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
				end, { silent = true })

			vim.keymap.set('i', '<C-l>', function()
				if luasnip.choice_active() then
					luasnip.change_choice(1)
				end
				end, { silent = true })
		end,

		-- Maximizer
		--
		--		<Leader>m
		--
		maximizer = function()
			nmap('<Leader>m', ':MaximizerToggle!<CR>')
		end,

		-- Neoformat
		--
		--		<Leader>FP
		--
		neoformat = function()
			nmap('<Leader>FP', ':Neoformat prettier<CR>')
		end,

		-- Nvim-Tree
		--
		--		<Leader>n[acfhlv]
		--
		nvim_tree = function()
			nmap('<Leader>nf', '<cmd>NvimTreeToggle<CR>')
			nmap('<Leader>nv', '<cmd>NvimTreeFindFile<CR>')
			nmap('<Leader>nh', '<cmd>NvimTreeResize -10<CR>')
			nmap('<Leader>nl', '<cmd>NvimTreeResize +10<CR>')
			nmap('<Leader>nc', '<cmd>NvimTreeCollapse<CR>')
			nmap('<Leader>na', '<cmd>NvimTreeCollapseKeepBuffers<CR>')
		end,

		-- Toggleterm
		--
		--		<Ctrl>-q
		--    <Leader>tt
		toggleterm = function()
			nmap('<Leader>TT', '<cmd>ToggleTerm direction=float<CR>')
			nmap('<Leader>TL', '<cmd>ToggleTerm direction=vertical<CR>')
		end,

		-- Sayonara
		--
		--    <Leader>bd
		--
		sayonara = function()
			nmap('<Leader>bd', '<cmd>Sayonara!<CR>')
		end,

		-- Sideways
		--
		--    <Leader><Leader>[hl]
		--
		sideways = function()
			nmap('<Leader><Leader>h', '<cmd>SidewaysLeft<CR>')
			nmap('<Leader><Leader>l', '<cmd>SidewaysRight<CR>')
		end,

		-- Sneak
		--
		--    s
		--
		sneak = function()
			keymap('n', ':', '<Plug>Sneak_;', { noremap = true })
			keymap('v', ':', '<Plug>Sneak_;', { noremap = true })
		end,

		-- Symbols Outline
		--
		--		<Leader>s
		--
		symbols_outline = function()
			nmap('<Leader>s', ':SymbolsOutline<CR>')
		end,

		-- Tmux Yank
		--
		--		<Leader>y
		--
		tmux_yank = function()
			vim.keymap.set('v', '<Leader>y', require("functions.tmux-yank").tmux_yank, { silent = true })
		end,

		-- Telescope
		--
		--		<Leader>f[abfgvrA]
		--
		telescope = function()

			_G.telescope_live_grep_in_path = function(path)
				local _path = path or vim.fn.input('Dir: ', '',  'dir')
				require('telescope.builtin').grep_string({search_dirs = {_path}, search=''})
			end

			nmap('<Leader>fa', '<cmd>lua require("telescope.builtin").grep_string({search=""})<CR>')
			nmap('<Leader>fA', ':lua telescope_live_grep_in_path()<CR>')
			nmap('<Leader>fb', '<cmd>Telescope buffers<CR>')
			nmap('<Leader>fe', '<cmd>Telescope file_browser<CR>')
			nmap('<Leader>ff', '<cmd>Telescope find_files<CR>')
			nmap('<Leader>fg', '<cmd>Telescope git_files<CR>')
			nmap('<Leader>fk', '<cmd>Telescope keymaps<CR>')
			nmap('<Leader>fm', '<cmd>Telescope keymaps<CR>')
			nmap('<Leader>fr', '<cmd>Telescope registers<CR>')
			nmap('<Leader>fs', '<cmd>Telescope grep_string<CR>')
		end,

		-- Vim-Test
		--
		--		<Leader>t[tfslv]
		--
		test = function()
			nmap('<Leader>tt', '<cmd>TestNearest<CR>')
			nmap('<Leader>tf', '<cmd>TestFile<CR>')
			nmap('<Leader>ts', '<cmd>TestSuite<CR>')
			nmap('<Leader>tl', '<cmd>TestLast<CR>')
			nmap('<Leader>tv', '<cmd>TestVisit<CR>')
		end,

		-- Tmux Navigator
		--
		--		Alt-[hjkl]
		--
		tmux_navigator = function()
			vim.g.tmux_navigator_no_mappings = 1

			nmap('<M-h>', ':TmuxNavigateLeft<CR>')
			nmap('<M-j>', ':TmuxNavigateDown<CR>')
			nmap('<M-k>', ':TmuxNavigateUp<CR>')
			nmap('<M-l>', ':TmuxNavigateRight<CR>')
			nmap('<M-\\>', ':TmuxNavigatePrevious<CR>')
		end,

		-- TrueZen
		--
		--		<Leader>tz
		--
		true_zen = function()
			nmap('<Leader>tz', '<cmd>TZAtaraxis<CR>')
		end,

		-- Undotree
		--
		--		<Leader>u
		--
		undotree = function()
			nmap('<Leader>u', ':UndotreeToggle<CR>')
		end

	}

}

local function recurse_keymappings(e)
	for _, v in pairs(e) do
		if type(v) == 'table' then
			recurse_keymappings(v)
		else
			v()
		end
	end
end

recurse_keymappings(keymaps)

