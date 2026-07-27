vim.pack.add({ "https://github.com/willothy/flatten.nvim" }, { confirm = false })

require("flatten").setup({})

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd("startinsert")
  end,
})
