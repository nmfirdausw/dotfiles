vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.schedule(function()
      vim.cmd.packadd("which-key.nvim")
      require("which-key").setup({
        preset = "classic",
        win = {
          -- col = vim.opt.columns:get(),
          border = vim.g.border,
          padding = { 0, 1 },
        },
        icons = {
          mappings = false,
        },
      })
    end)
  end,
  once = true,
})
