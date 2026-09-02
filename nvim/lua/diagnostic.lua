-- Diagnostic display: underline the text, refresh while typing, sort by
-- severity, and only show virtual text for the line the cursor is on
vim.diagnostic.config({
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  virtual_text = { current_line = true },
  float = { border = "none" },
})

-- Restore virtual text once the cursor moves away, but not while sitting
-- inside the float itself
vim.api.nvim_create_autocmd("CursorMoved", {
  group = vim.api.nvim_create_augroup("diagnostic_virtual_text", { clear = true }),
  callback = function()
    if vim.fn.mode() ~= "n" then
      return
    end
    if vim.bo.buftype == "nofile" then
      return
    end
    vim.diagnostic.config({ virtual_text = { current_line = true } })
  end,
})

-- Toggle diagnostic on and off
vim.keymap.set("n", "<leader>td", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostic" })

-- Toggle diagnostic on and off
vim.keymap.set("n", "<leader>dd", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostic" })

-- Show the diagnostic in a float, hiding virtual text so it isn't duplicated
vim.keymap.set("n", "<leader>dk", function()
  vim.diagnostic.config({ virtual_text = false })
  vim.diagnostic.open_float()
end, { desc = "Open diagnostic float" })

-- Send this buffer's diagnostics to the location list
vim.keymap.set("n", "<leader>dl", function()
  vim.diagnostic.setloclist({ open = true })
end, { desc = "Add all diagnostics to quickfix list" })

-- Send every diagnostic in the workspace to the quickfix list
vim.keymap.set("n", "<leader>dc", function()
  vim.diagnostic.setqflist({ open = true })
end, { desc = "Add all diagnostics to quickfix list" })
