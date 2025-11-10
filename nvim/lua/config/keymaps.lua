-- Copy to system clipboard
vim.keymap.set("n", "<leader>Y", '"+y$', { desc = "Copy to end of line (system clipboard)" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy selection (system clipboard)" })
vim.keymap.set("n", "<leader>yy", '"+yy', { desc = "Copy line (system clipboard)" })

-- Paste from system clipboard
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste after cursor (system clipboard)" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste before cursor (system clipboard)" })
vim.keymap.set("v", "<leader>p", '"+p', { desc = "Paste (system clipboard)" })

-- Scrolling keymap
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set('n', '<PageDown>', '<C-d>zz', { desc = 'Scroll half screen down (PageDown)', silent = true })
vim.keymap.set('n', '<PageUp>', '<C-u>zz', { desc = 'Scroll half screen up (PageUp)', silent = true })

-- Keep visual selection active after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Clear search highlighting with Escape
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Toggle line numbers on/off
vim.keymap.set("n", "<leader>tn", function()
  vim.opt.number = not vim.opt.number:get()
  local status = vim.opt.number:get() and "enabled" or "disabled"
  vim.notify("Line numbers " .. status)
end, { desc = "Toggle line numbers" })

-- Toggle relative line numbers on/off
vim.keymap.set("n", "<leader>tr", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
  local status = vim.opt.relativenumber:get() and "enabled" or "disabled"
  vim.notify("Relative line numbers " .. status)
end, { desc = "Toggle relative numbers" })

-- Toggle sign column visibility
vim.keymap.set("n", "<leader>ts", function()
  local current = vim.opt.signcolumn:get()
  if current == "yes" then
    vim.opt.signcolumn = "no"
    vim.notify("Sign column disabled")
  else
    vim.opt.signcolumn = "yes"
    vim.notify("Sign column enabled")
  end
end, { desc = "Toggle sign column" })
