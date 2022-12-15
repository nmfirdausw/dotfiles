local lsp_lines_installed, lsp_lines = pcall(require, "lsp_lines")
if not lsp_lines_installed then return end

lsp_lines.setup()

vim.diagnostic.config({
    virtual_text = false,
})
