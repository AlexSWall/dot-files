local options = {

	-- Fundamental.
	backup = false,
	shada = "'100,<1000,s100,h",
	swapfile = false,
	undofile = true,
	updatetime = 50,
	writebackup = false,

	-- Usability.
	completeopt = 'menuone,noinsert,noselect',
	foldlevel = 99,
	foldmethod = 'indent',
	foldminlines = 0,
	ignorecase = true,
	smartcase = true,
	splitbelow = true,
	splitright = true,
	splitkeep = 'screen',

	-- Visuals.
	breakindent = true,
	breakindentopt = 'sbr',
	colorcolumn = { 80, 120 },
	cursorline = true,
	cursorlineopt = 'number',
	fillchars = { eob = ' ' },  -- Remove ~ end-of-buffer symbols.
	linebreak = true,
	listchars = 'eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣',
	pumblend = 10,
	pumheight = 20,
	scrolloff = 3,
	showbreak = '↪ ',
	showcmdloc = 'statusline',
	sidescrolloff = 5,
	signcolumn = 'yes',
	-- Shows number or relativenumber are off, show nothing.
	-- Else, show 'number relativenumber', but in the same column.
	-- Disabled for now, as currently it doesn't support e.g. gitsigns.
	-- statuscolumn = '%=%{ &number && &relativenumber ? ( v:relnum ? v:relnum + " asd" : v:lnum ) : "" } ',
	termguicolors = true,
	wrap = true,

	-- Miscellaneous.
	keywordprg = ':help',
}

-- Set options.
for k, v in pairs(options) do
	vim.opt[k] = v
end

-- Appends.
vim.opt.shortmess:append({ s = true, I = true })  -- No 'search hit BOTTOM' nor intro text.
vim.opt.diffopt:append('vertical')                -- Create vertical vimdiff splits.
vim.opt.diffopt:append('linematch:60')            -- Improve the diff engine using Neovim v0.9 functionality.
