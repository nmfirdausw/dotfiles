vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  callback = function()
    vim.hl.hl_op()
 end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  desc = "Close quickfix when mode changed",
  callback = function()
    if vim.bo.buftype ~= "quickfix" then
      vim.cmd("cclose")
    end
  end,
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  desc = "Open the quickfix list after grep",
  pattern = { "grep", "vimgrep", "grepadd" },
  callback = function()
    vim.cmd("copen")
  end,
})
