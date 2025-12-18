vim.api.nvim_create_autocmd({ "WinLeave", "WinEnter" }, {
  callback = function()
    if vim.bo.buftype ~= "" then
      return
    end
    MainWin = vim.api.nvim_get_current_win()
  end,
})
