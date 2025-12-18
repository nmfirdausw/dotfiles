vim.cmd.packadd("snacks.nvim")

local layout = function()
  local main_win_pos = vim.api.nvim_win_get_position(MainWin)
  local main_win_row = main_win_pos[1]
  if main_win_row > 0 then
    return {
      preview = "main",
      reverse = true,
      layout = {
        backdrop = false,
        height = 0.382,
        row = 0,
        box = "vertical",
        border = "none",
        title = "{title}",
        { win = "list" },
        { win = "input", height = 1 },
        { win = "preview" },
      },
    }
  end
  return {
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
  }
end

require("snacks").setup({
  picker = {
    layout = layout,
  },
})

Snacks.keymap.set("n", "<leader>r", function()
  Snacks.picker.recent()
end, { desc = "Recent files" })

Snacks.keymap.set("n", "<leader>f", function()
  Snacks.picker.smart()
end, { desc = "Files (smart)" })
