vim.pack.add({ "https://github.com/willothy/flatten.nvim" }, { confirm = false })

require("flatten").setup({})

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  pattern = "term://*",
  callback = function()
    vim.schedule(function()
      vim.cmd("startinsert")
    end)
  end,
})

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
