local luasnip_installed = pcall(require, "luasnip")
if not luasnip_installed then return end

require("luasnip.loaders.from_vscode").lazy_load()
