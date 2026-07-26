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
    if vim.fn.mode() ~= "n" then
      return
    end
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(win).relative ~= "" then
        return -- a float is open; keep virtual text hidden
      end
    end
    vim.diagnostic.config({ virtual_text = { current_line = true } })
  end,
})
