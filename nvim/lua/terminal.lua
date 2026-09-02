vim.pack.add({ "https://github.com/willothy/flatten.nvim" }, { confirm = false })

require("flatten").setup({})

vim.opt.shell = "/opt/homebrew/bin/fish"
vim.opt.scrollback = 1000000
vim.opt.path = ".,**"

local group = vim.api.nvim_create_augroup("terminal", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  callback = function()
    vim.cmd("startinsert")
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  group = group,
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert")
    end
  end,
})

vim.api.nvim_create_autocmd("TermRequest", {
  group = group,
  callback = function(args)
    local seq = args.data.sequence
    local dir = seq and seq:match("^\027]7;file://[^/]*(.+)")
    if dir then
      vim.fn.chdir(vim.uri_decode(dir))
    end
  end,
})

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
