vim.g.ruby_host_prog = "/opt/homebrew/lib/ruby/gems/3.3.0/bin/neovim-ruby-host"

require("options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  install = {
    colorscheme = { "default" }
  },
  ui = {
    border = "single"
  },
})

require("keymaps")
require("autocmds")
