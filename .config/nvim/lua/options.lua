vim.g.mapleader = " "

local git_dir = vim.fn.finddir('.git', vim.fn.getcwd() .. ";")
vim.g.gitdir = git_dir ~= ""

vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.confirm = true
vim.opt.wrap = false

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.foldcolumn = "auto"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.smartcase = true

vim.opt.number = true
vim.opt.numberwidth = 1
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.preserveindent = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.history = 100
vim.opt.undofile = true
vim.opt.undolevels = 1000

vim.opt.list = true
vim.opt.listchars = "tab: \\ ,trail:-,eol:⬎"
