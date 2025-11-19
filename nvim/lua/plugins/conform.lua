local conform_has_setup = false
local config = require("config.formatting")

local setup_conform = function()
  vim.cmd.packadd("conform.nvim")
  require("conform").setup({
    formatters_by_ft = config.ftformatter,
    formatters = config.formatters,
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = function()
      if vim.g.format_on_save then
        return {
          lsp_format = "fallback",
          timeout_ms = 2000,
        }
      end
    end,
  })
end

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    if not conform_has_setup then
      setup_conform()
      require("conform").format({
        lsp_format = "fallback",
        timeout_ms = 2000,
      })

      conform_has_setup = true
    end
  end,
})

vim.keymap.set("n", "<C-f>", function()
  if not conform_has_setup then
    setup_conform()
    conform_has_setup = true
  end
  require("conform").format({
    lsp_format = "fallback",
    timeout_ms = 2000,
  })
end, { desc = "Format code" })

vim.keymap.set("v", "<C-f>", function()
  if not conform_has_setup then
    setup_conform()
    conform_has_setup = true
  end
  require("conform").format({
    range = {
      start = vim.api.nvim_buf_get_mark(0, "<"),
      ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
    },
    timeout_ms = 2000,
  })
end, { desc = "Format selection" })

vim.keymap.set("n", "<leader>tf", function()
  vim.g.format_on_save = not vim.g.format_on_save
  local status = vim.g.format_on_save and "enabled" or "disabled"
  vim.notify("Format on save " .. status)
end, { desc = "Toggle format on save" })
