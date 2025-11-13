-- Filetype configuration: { spaces, expandtab }
local config = {
  lua = { 2, true },
}

for filetype, indent_config in pairs(config) do
  local spaces, expandtab = indent_config[1], indent_config[2]
  vim.api.nvim_create_autocmd("FileType", {
    pattern = filetype,
    callback = function()
      vim.bo.expandtab = expandtab
      vim.bo.shiftwidth = spaces
      vim.bo.softtabstop = spaces
      vim.bo.tabstop = spaces
    end,
  })
end
