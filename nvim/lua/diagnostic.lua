vim.diagnostic.config({
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  virtual_text = { current_line = true },
  float = { border = "none" },
})

vim.api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    local mode = vim.fn.mode()
    if mode == "n" then
      vim.diagnostic.config({ virtual_text = { current_line = true } })
    end
  end,
})
