vim.cmd.packadd("nvim-treesitter")
local parsers = require("config.treesitter")

require("nvim-treesitter").install(parsers)

local function setup()
  local buf = vim.api.nvim_get_current_buf()
  local has_parser = pcall(vim.treesitter.get_parser, buf)
  if not has_parser then
    return
  end
  vim.treesitter.start()

  local lang = vim.treesitter.get_parser(buf):lang()
  local has_folds_query = pcall(vim.treesitter.query.get, lang, "folds")
  local has_indents_query = pcall(vim.treesitter.query.get, lang, "indents")

  if has_folds_query then
    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end

  if has_indents_query then
    vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
  end
end

setup()

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    setup()
  end,
})
