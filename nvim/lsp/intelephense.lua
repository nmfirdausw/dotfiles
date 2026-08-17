---@type vim.lsp.Config
return {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  root_markers = { ".git", "composer.json" },
  init_options = {
    storagePath = vim.fn.stdpath("cache") .. "/intelephense",
    globalStoragePath = vim.fn.stdpath("data") .. "/intelephense",
    clearCache = false,
  },
  ---@type lspconfig.settings.intelephense
  settings = {
    intelephense = {
      telemetry = {
        enabled = false,
      },
    },
  },
}
