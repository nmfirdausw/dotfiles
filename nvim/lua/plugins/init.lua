vim.pack.add({
  "https://github.com/willothy/flatten.nvim",
}, {
  confirm = false,
  load = function(plugin)
    local name = plugin.spec.name
    if name then
      name = name:gsub("^[Nn][Vv][Ii][Mm]%-", "")
      name = name:gsub("%.[Nn][Vv][Ii][Mm]$", "")
      name = name:gsub("%.[Ll][Uu][Aa]$", "")
      name = name:lower()
      name = name:gsub("%.", "-")
      pcall(require, "plugins." .. name)
    end
  end,
})
