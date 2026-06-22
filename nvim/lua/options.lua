vim.g.netrw_banner = 0

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = true
vim.opt.inccommand = "split"
vim.opt.laststatus = 3

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

vim.opt.clipboard:append("unnamedplus")
vim.opt.isfname:append("@-@")
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "0"
vim.opt.signcolumn = "yes"

vim.opt.cmdheight = 0
vim.opt.termguicolors = true

vim.opt.path:append("**")

vim.opt.grepprg = "rg --vimgrep --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"
