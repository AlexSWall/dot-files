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
	sidescrolloff = 5,
	signcolumn = 'yes',
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
