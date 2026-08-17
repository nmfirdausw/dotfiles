vim.lsp.enable({
  "lua_ls",
  "intelephense",
})

vim.keymap.set("n", "<leader>lh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "" })

vim.keymap.set("n", "<leader>lc", function()
  vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled())
end, { desc = "Toggle codelens" })
