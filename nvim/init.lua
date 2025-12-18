_G.MainWin = vim.api.nvim_get_current_win()

require("config.options")
require("config.diagnostic")
require("config.lsp")
require("config.autocmds")
require("plugins")
