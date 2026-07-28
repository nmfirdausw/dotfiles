vim.pack.add({ "https://github.com/willothy/flatten.nvim" }, { confirm = false })

require("flatten").setup({})

vim.opt.shell = "/opt/homebrew/bin/fish"
vim.opt.scrollback = 1000000
vim.opt.path = ".,**"

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd("startinsert")
  end,
})

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
