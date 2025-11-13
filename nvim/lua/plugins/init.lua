vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
}, {
  confirm = false,
  load = function(plugin)
    local utils = require("config.utils")
    require("plugins." .. utils.trim_plugin_name(plugin.spec.name))
  end,
})
