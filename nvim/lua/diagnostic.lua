vim.diagnostic.config({
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  virtual_text = { current_line = true },
  float = { border = "none" },
})

vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.config({ virtual_text = false })
  vim.diagnostic.open_float()
end, { desc = "Open diagnostic float" })

vim.api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    local mode = vim.fn.mode()
    if mode == "n" then
      vim.diagnostic.config({ virtual_text = { current_line = true } })
    end
  end,
})
