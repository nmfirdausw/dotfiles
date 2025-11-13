local M = {}

-- Trim common Neovim plugin prefixes and suffixes from plugin names
function M.trim_plugin_name(name)
  if not name or type(name) ~= "string" then
    return name or ""
  end

  local result = name
  result = result:gsub("^[Nn][Vv][Ii][Mm]%-", "")
  result = result:gsub("%.[Nn][Vv][Ii][Mm]$", "")
  result = result:gsub("%.[Ll][Uu][Aa]$", "")
  result = result:lower()
  result = result:gsub("%.", "-")

  return result
end

return M
