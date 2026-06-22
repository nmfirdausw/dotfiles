vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

local overrides = {
  lua = { tabstop = 2, shiftwidth = 2, softtabstop = 2 },
}

for ft, opts in pairs(overrides) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    callback = function()
      for k, v in pairs(opts) do
        vim.opt_local[k] = v
      end
    end,
  })
end
