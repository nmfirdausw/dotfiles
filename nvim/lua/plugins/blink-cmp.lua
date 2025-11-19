vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
  callback = function()
    vim.cmd.packadd("blink.cmp")
    vim.schedule(function()
      require("blink.cmp").setup({
        keymap = {
          preset = "enter",
        },
        signature = {
          enabled = true,
          window = { border = vim.g.border },
        },
        completion = {
          documentation = {
            auto_show = true,
            window = { border = vim.g.border },
          },
          menu = {
            auto_show = true,
            border = vim.g.border,
            draw = {
              columns = {
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
                { "kind" },
                { "source_name" },
              },
              components = {
                kind_icon = {
                  ellipsis = false,
                  text = function(ctx)
                    local kind_icons = require("config.icons").kinds
                    local icon = ctx.kind_icon
                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                      local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                      if dev_icon then
                        icon = dev_icon
                      end
                      if string.sub(ctx.label, -1) == "/" then
                        icon = "󰝰 "
                      end
                    else
                      icon = kind_icons[ctx.kind] or ""
                    end

                    return icon .. ctx.icon_gap
                  end,
                  highlight = function(ctx)
                    local hl = ctx.kind_hl
                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                      local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                      if dev_icon then
                        hl = dev_hl
                      end
                      if string.sub(ctx.label, -1) == "/" then
                        hl = "Directory"
                      end
                    end
                    return hl
                  end,
                },
              },
            },
          },
          list = {
            selection = {
              preselect = false,
              auto_insert = false,
            },
          },
        },
        cmdline = {
          enabled = true,
          keymap = { preset = "inherit" },
          sources = function()
            local type = vim.fn.getcmdtype()
            if type == "/" or type == "?" then
              return { "buffer" }
            end
            if type == ":" or type == "@" then
              return { "cmdline", "path" }
            end
            return {}
          end,
          completion = {
            trigger = {
              show_on_blocked_trigger_characters = {},
              show_on_x_blocked_trigger_characters = {},
            },
            list = {
              selection = {
                preselect = false,
                auto_insert = true,
              },
            },
            menu = {
              auto_show = true,
            },
            ghost_text = { enabled = true },
          },
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
          providers = {
            lsp = {
              opts = { tailwind_color_icon = " " },
            },
            cmdline = {
              min_keyword_length = 2,
            },
          },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
      })
    end)
  end,
  once = true,
})
