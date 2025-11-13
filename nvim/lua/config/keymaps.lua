-- Copy to system clipboard
vim.keymap.set("n", "<leader>Y", '"+y$', { desc = "Copy to end of line (system clipboard)" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy selection (system clipboard)" })
vim.keymap.set("n", "<leader>yy", '"+yy', { desc = "Copy line (system clipboard)" })

-- Paste from system clipboard
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste after cursor (system clipboard)" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste before cursor (system clipboard)" })
vim.keymap.set("v", "<leader>p", '"+p', { desc = "Paste (system clipboard)" })
