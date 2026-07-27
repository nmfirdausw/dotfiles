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
    ["<C-e>"] = { "show", "select_prev", "fallback" },
    ["<C-p>"] = { "show", "select_prev", "fallback" },
    ["<C-d>"] = { "show_documentation", "hide_documentation", "fallback" },
    ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
    ["<CR>"] = {
      function(cmp)
        if cmp.is_menu_visible() then
          return cmp.accept()
        end
      end,
      "fallback",
    },
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
    keymap = {
      preset = "inherit",
      ["<Down>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
    },
    completion = {
      menu = { auto_show = false },
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
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
