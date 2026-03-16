vim.cmd([[
  cabbrev <expr> q getcmdtype() == ':' && getcmdline() == 'q' ? 'bd' : 'q'
]])

require("config.options")
require("plugins")
require("config.keymaps")
require("config.lsp")
require("config.diagnostic")
require("config.colors")
require("config.autocmds")
