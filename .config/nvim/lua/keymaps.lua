-- Indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move Line
vim.keymap.set("v", "<S-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "<S-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })

vim.keymap.set("n", "<leader>w", ":w<cr>", { desc = "Write file" })
vim.keymap.set("n", "<leader>q", ":q<cr>", { desc = "Write file" })
