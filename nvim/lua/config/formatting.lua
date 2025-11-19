local M = {}

-- Filetype to formatter mappings
M.ftformatter = {
  lua = { "stylua" }, -- paru -S stylua
}

-- Formatter-specific configuration
M.formatters = {
  stylua = {
    args = {
      "--indent-type=Spaces",
      "--indent-width=2",
      "--quote-style=ForceDouble",
      "-",
    },
  },
}

return M
