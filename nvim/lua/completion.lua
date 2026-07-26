vim.pack.add({
  "https://github.com/saghen/blink.lib",
  "https://github.com/saghen/blink.cmp",
}, { confirm = false })

local blink_cmp = require("blink.cmp")

blink_cmp.build():pwait()

blink_cmp.setup({
  keymap = {
    preset = "default",
    ["<C-n>"] = { "show", "select_next", "fallback" },
    ["<CR>"] = {
      function(cmp)
        if cmp.is_menu_visible() then
          return cmp.accept()
        end
      end,
      "fallback",
    },
    ["<C-e>"] = { "show", "select_prev", "fallback" },
  },
  completion = {
    accept = {
      auto_brackets = { enabled = true },
    },
    menu = { auto_show = false },
    list = {
      selection = {
        preselect = true,
        auto_insert = true,
      },
    },
    documentation = {
      auto_show = false,
      auto_show_delay_ms = 100,
    },
    ghost_text = { enabled = true },
  },
  signature = {
    enabled = true,
    window = { show_documentation = false },
    trigger = {
      enabled = true,
    },
  },
  cmdline = {
    keymap = { preset = "inherit" },
    completion = {
      menu = { auto_show = true },
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
    },
  },
})

vim.api.nvim_create_autocmd("CompleteDone", {
  callback = function()
    vim.defer_fn(function()
      if vim.api.nvim_get_mode().mode == "i" then
        blink_cmp.show_signature()
      end
    end, 10)
  end,
})
