vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.schedule(function()
      vim.cmd.packadd("tiny-inline-diagnostic.nvim")
      require("tiny-inline-diagnostic").setup({
        preset = "simple",
        options = {
          show_source = { enabled = false },
          use_icons_from_diagnostic = true,
          throttle = 0,
          enable_on_insert = false,
        },
      })
    end)
  end,
  once = true,
})
