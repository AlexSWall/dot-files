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

local keymap_utils = require('utils.keymap')
local keymap    = keymap_utils.keymap
local nmap      = keymap_utils.nmap
local nmap_expr = keymap_utils.nmap_expr
local imap      = keymap_utils.imap
local xmap      = keymap_utils.xmap
local vmap      = keymap_utils.vmap
local tmap      = keymap_utils.tmap

local keymaps = {

	in_built = {

		fundamental = function()

			-- Swap ':' and ';'.
			keymap('n', ';', ':', { noremap = true })
			keymap('v', ';', ':', { noremap = true })
			-- We remap : to <Plug>Sneak_; later

			-- Set <Esc><Esc> to go to normal mode in :term
			tmap('<Esc><Esc>', '<C-\\><C-n>')

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

				-- Move vim tabs around.
				nmap('<Leader>H', ':tabmove -1<CR>')
				nmap('<Leader>L', ':tabmove +1<CR>')

			end,

			navigating_files = function()

				-- Edit Neovim config.
				nmap('<Leader>ve', ':e ~/.config/nvim/lua/config.lua<CR>')

				-- Reload Neovim config.
				nmap('<Leader>vr', ':so ~/.config/nvim/init.lua<CR>')

				-- Allow gf to edit non-existent files too.
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

			nmap('<Leader>it', function() require('core.indentation').set_indentation(3, true) end)
			nmap('<Leader>i2', function() require('core.indentation').set_indentation(2, false) end)
			nmap('<Leader>i3', function() require('core.indentation').set_indentation(3, false) end)
			nmap('<Leader>i4', function() require('core.indentation').set_indentation(4, false) end)
			nmap('<Leader>i8', function() require('core.indentation').set_indentation(8, false) end)
		end,

		complex_functionality = function()

			-- Use d to yank text beforehand.
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
				':lua require("functions.relative-number-toggle").set_number_toggle("disable")<CR>')
			--
			-- Re-enable GUI
			nmap('<Leader><Leader>0',
				':Gitsigns attach<CR>' ..
				':set number relativenumber linebreak breakindent signcolumn=yes showbreak=↪\\ <CR>' ..
				':lua require("functions.relative-number-toggle").set_number_toggle("enable")<CR>')

			-- Toggle comment using <C-c> in normal and insert mode.
			nmap('<C-c>', require('functions.toggle-comment').toggle_comment, 'Toggle comment')
			imap('<C-c>', require('functions.toggle-comment').toggle_comment, 'Toggle comment')

			-- Flip comments using gC in normal and visual mode.
			require('functions.flip-flop-comments')
			nmap('gC', '<cmd>set operatorfunc=v:lua.__flip_flop_comment<cr>g@', 'Invert comments')
			xmap('gC', '<cmd>set operatorfunc=v:lua.__flip_flop_comment<cr>g@', 'Invert comments')

			-- Add <Leader>gc to invert the previous selection's comments.
			nmap('<Leader>gc', '<cmd>set operatorfunc=v:lua.__flip_flop_comment<cr>gvg@', 'Invert comments in previous selection')

		end,

		visual = function()

			nmap('<Leader>tw', ':highlight ExtraWhitespace guibg=#223E55<CR>')
			nmap('<Leader>tW', ':highlight ExtraWhitespace NONE<CR>')

		end

	},

	custom = {

		-- Python Post-Process
		--
		--		<Leader><Leader>p
		--
		python_post_process = function()
			vim.keymap.set({'n'}, '<Leader><Leader>p', require("functions.python-post-process").python_post_process, { silent = true })
		end,

		-- Sudo Write
		--
		--		<Leader><Leader>w
		sudo_write = function()
			nmap('<Leader><Leader>w', require('functions.sudo').sudo_write)
		end,

		-- Tmux Yank
		--
		--		<Leader>y
		--
		tmux_yank = function()
			vmap('<Leader>y', require('functions.tmux-yank').tmux_yank)
		end,
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
