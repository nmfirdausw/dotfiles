vim.cmd.packadd("snacks.nvim")
require("snacks").setup({})

Snacks.keymap.set("n", "<leader>r", function()
  Snacks.picker.recent()
end, { desc = "Recent files" })

Snacks.keymap.set("n", "<leader>f", function()
  Snacks.picker.smart()
end, { desc = "Files (smart)" })
