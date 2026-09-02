-- Default indent: 4 spaces, no tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Per-filetype indent overrides
local overrides = {
  lua = { tabstop = 2, shiftwidth = 2, softtabstop = 2 },
}

-- Apply the overrides per buffer on FileType
local group = vim.api.nvim_create_augroup("indent_overrides", { clear = true })
for ft, opts in pairs(overrides) do
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = ft,
    callback = function()
      for k, v in pairs(opts) do
        vim.opt_local[k] = v
      end
    end,
  })
end

-- Keep selection during indent and unindent
vim.keymap.set("v", "<", "<gv", { desc = "Unindent" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent" })
