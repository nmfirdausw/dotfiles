-- Share the system clipboard
vim.opt.clipboard:append("unnamedplus")

-- Soft-wrap long lines
vim.opt.wrap = true

-- Live preview for :s in a split
vim.inccommand = "split"

-- New splits open below and to the right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Case-insensitive search unless the pattern has a capital
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- No swap or backup files; keep persistent undo instead
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

-- Keep 8 lines of context above and below the cursor
vim.opt.scrolloff = 8

-- Hide the command line when idle, one global statusline
vim.opt.cmdheight = 0
vim.opt.laststatus = 3

-- Treat hyphenated words as one word (css-class, some-var)
vim.opt.iskeyword:append("-")
