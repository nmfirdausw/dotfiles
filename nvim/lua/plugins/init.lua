vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/kevinhwang91/nvim-ufo",
  "https://github.com/kevinhwang91/promise-async",
  "https://github.com/lewis6991/gitsigns.nvim",
}, {
  confirm = false,
  load = function(plugin)
    local utils = require("config.utils")
    require("plugins." .. utils.trim_plugin_name(plugin.spec.name))
  end,
})
