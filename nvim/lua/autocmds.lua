-- Briefly highlight the yanked region
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("yank_highlight", { clear = true }),
  desc = "Highlight when yanking text",
  callback = function()
    vim.hl.hl_op()
  end,
})
