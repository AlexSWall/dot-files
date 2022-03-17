
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

	imap = function(shortcut, command)
		_helpers.map('i', shortcut, command)
	end,

	vmap = function(shortcut, command)
		_helpers.map('v', shortcut, command)
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
local imap = helpers.imap
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
			keymap('n', ':', ';', { noremap = true })
			keymap('v', ':', ';', { noremap = true })

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
				-- the cursor; much easier to do than *
				nmap('<Leader>N', '*')

				-- While in visual mode, use <Leader>/ to search for the selected text.
				-- vmap('<Leader>/', 'y/\V<C-R>=escape(@",'/\')<CR><CR>')
				vmap('<Leader>n', '*')

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
				':GitGutterDisable<CR>' ..
				':set nonumber norelativenumber nolinebreak nobreakindent signcolumn=no showbreak= <CR>' ..
				':call SetNumberToggle(\'disable\')<CR>')
			--
			-- Reenable GUI
			nmap('<Leader><Leader>0',
				':GitGutterEnable<CR>' ..
				':set number relativenumber linebreak breakindent signcolumn=yes showbreak=↪\\ <CR>' ..
				':call SetNumberToggle(\'enable\')<CR>')

		end,

		visual = function()

			nmap('<Leader><Leader>l', ':highlight ExtraWhitespace ctermbg=darkblue guibg=darkblue<CR>')
			nmap('<Leader><Leader>L', ':highlight ExtraWhitespace NONE<CR>')

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
		--		<Leader>F
		--
		neoformat = function()
			nmap('<Leader>F', ':Neoformat prettier<CR>')
		end,

		-- Neoterm
		--
		--		Ctrl-q
		neoterm = function()
			nmap('<C-q>', ':Ttoggle<CR>')
			imap('<C-q>', '<Esc>:Ttoggle<CR>')
			tmap('<C-q>', '<C-\\><C-n>:Ttoggle<CR>')
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

		-- Symbols Outline
		--
		--		<Leader>s
		--
		symbols_outline = function()
			nmap('<Leader>s', ':SymbolsOutline<CR>')
		end,

		-- Tbone
		--
		--		<Leader>y
		--
		tbone = function()
			-- Functions

			-- Not currently working...
			-- getpos returns [0, 0, 0, 0]?

			-- function tmux_load_buffer()
			-- 	-- Selection start and end arrays
			-- 	-- 2nd and 3rd entries of the array are the line number and column number.
			-- 	local s_start = vim.fn.getpos("'<")
			-- 	local s_end   = vim.fn.getpos("'>")
			-- 	print(dump(s_start))
			-- 	local start_line, start_col = s_start[2], s_start[3]
			-- 	local   end_line,   end_col =   s_end[2],   s_end[3]

			-- 	-- Get the lines from the start line to the end line, and remove the line
			-- 	-- contents before the start column and after the end column.
			-- 	local lines = vim.fn.getline(start_line, end_line)
			-- 	print(dump(lines))
			-- 	lines[1]      = string.sub(lines[1], start_col)
			-- 	lines[#lines] = string.sub(lines[#lines], 0, end_col)

			-- 	-- Write the resulting line contents to a temporary file, load it into the
			-- 	-- tmux buffer, and then delete the temporary file.
			-- 	local tempfile = vim.fn.tempname()
			-- 	vim.fn.writefile(lines, tempfile, 'a')
			-- 	vim.fn.system('tmux load-buffer ' .. tempfile)
			-- 	vim.fn.delete(tempfile)
			-- end

			vim.cmd([[
				function! s:tmux_load_buffer()
					let [lnum1, col1] = getpos("'<")[1:2]
					let [lnum2, col2] = getpos("'>")[1:2]
					let lines = getline(lnum1, lnum2)
					let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
					let lines[0] = lines[0][col1 - 1:]
					let tempfile = tempname()
					call writefile(lines, tempfile, "a")
					call system('tmux load-buffer '.tempfile)
					echo tempfile
					" call delete(tempfile)
				endfunction

				vnoremap <silent> <Leader>y :call <sid>tmux_load_buffer()<CR>
			]])

			-- tmux_load_buffer()
			-- vmap_expr('<Leader>y', 'v:lua.tmux_load_buffer()')
			-- vim.api.nvim_buf_set_keymap(0, 'v', '<Leader>y', 'v:lua.tmux_load_buffer()', { noremap = true, silent = true, expr = true })

			-- vim.cmd('vnoremap <silent> <Leader>y :call <sid>tmux_load_buffer()<CR>')
			-- vim.cmd('vnoremap <silent> <Leader>y :call tmux_load_buffer()<CR>')
		end,

		-- Telescope
		--
		--		<Leader>f[abfgvrA]
		--
		telescope = function()
			nmap('<Leader>fa', ':Telescope live_grep<CR>')
			nmap('<Leader>fb', ':Telescope buffers<CR>')
			nmap('<Leader>ff', ':Telescope find_files<CR>')
			nmap('<Leader>fg', ':Telescope git_files<CR>')
			nmap('<Leader>fv', ':Telescope grep_string<CR>')
			nmap('<Leader>fr', ':Telescope registers<CR>')

			_G.telescope_live_grep_in_path = function(path)
				local _path = path or vim.fn.input('Dir: ', '',  'dir')
				require('telescope.builtin').live_grep({search_dirs = {_path}})
			end

			nmap('<Leader>fA', ':lua telescope_live_grep_in_path()<CR>')

			nmap('<Leader>nt', '<cmd>Telescope file_browser<CR>')
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

