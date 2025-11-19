vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/kevinhwang91/nvim-ufo",
  "https://github.com/kevinhwang91/promise-async",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/nvim-mini/mini.ai",
  { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1") },
}, {
  confirm = false,
  load = function(plugin)
    local utils = require("config.utils")
    require("plugins." .. utils.trim_plugin_name(plugin.spec.name))
  end,
})
