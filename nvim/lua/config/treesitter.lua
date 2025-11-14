-- List of parsers to automatically install
local parsers = {
  "lua",
}

-- Toggle syntax highlighting for the current buffer
vim.keymap.set("n", "<leader>th", function()
  local buf = vim.api.nvim_get_current_buf()
  local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)

  if not lang or not pcall(vim.treesitter.language.add, lang) then
    return
  end

  if vim.treesitter.highlighter.active[buf] then
    vim.treesitter.stop(buf)
    vim.notify("Treesitter highlighting disabled for this buffer")
  else
    vim.treesitter.start(buf)
    vim.notify("Treesitter highlighting enabled for this buffer")
  end
end, { desc = "Toggle syntax highlighting" })

return parsers
