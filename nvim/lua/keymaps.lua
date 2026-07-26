vim.g.mapleader = " "

vim.keymap.set("n", "<Esc>", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
  vim.diagnostic.config({ virtual_text = { current_line = true } })
  vim.cmd("nohlsearch")
end, { desc = "Close floating windows and clear search highlight" })
