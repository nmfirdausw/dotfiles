vim.cmd.packadd("snacks.nvim")
require("snacks").setup({
  picker = {
    layout = {
      preview = "main",
      layout = {
        backdrop = false,
        height = 0.382,
        row = -2,
        box = "vertical",
        border = "none",
        title = "{title}",
        { win = "preview" },
        { win = "input", height = 1 },
        { win = "list" },
      },
    },
  },
})

Snacks.keymap.set("n", "<leader>r", function()
  Snacks.picker.recent()
end, { desc = "Recent files" })

Snacks.keymap.set("n", "<leader>f", function()
  Snacks.picker.smart()
end, { desc = "Files (smart)" })
