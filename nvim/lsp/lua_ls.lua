---@type vim.lsp.Config
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    { '.emmyrc.json', '.luarc.json', '.luarc.jsonc' },
    { '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml' },
    { '.git' },
  },
  ---@type lspconfig.settings.lua_ls
  settings = {
    Lua = {
      codeLens = { enable = true },
      hint = {
        enable = true,
        semicolon = "Disable",
        arrayIndex = "Disable"
      },
    },
  },
}
