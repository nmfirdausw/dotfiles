local ftprovider = require("config.fold").ftprovider

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.schedule(function()
      vim.cmd.packadd("nvim-ufo")
      require("ufo").setup({
        provider_selector = function(_, filetype, _)
          return ftprovider[filetype] or { "treesitter", "indent" }
        end,
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local suffix = (" 󰁂 %d "):format(endLnum - lnum)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0
          for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
            else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              local hlGroup = chunk[2]
              table.insert(newVirtText, { chunkText, hlGroup })
              chunkWidth = vim.fn.strdisplaywidth(chunkText)
              if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
              end
              break
            end
            curWidth = curWidth + chunkWidth
          end
          table.insert(newVirtText, { suffix, "MoreMsg" })
          return newVirtText
        end,
        preview = {
          win_config = {
            border = vim.g.border,
            winblend = 0,
            winhighlight = "Normal:Normal",
            maxheight = 20,
          },
        },
      })
      vim.keymap.set("n", "K", function()
        -- First priority: check if there's a fold under cursor
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if winid then
          return
        end

        -- Second priority: check if there are diagnostics under cursor
        local line = vim.api.nvim_win_get_cursor(0)[1] - 1
        local diagnostics = vim.diagnostic.get(0, { lnum = line })
        if #diagnostics > 0 then
          vim.diagnostic.open_float()
          return
        end

        -- Third priority: show LSP hover
        vim.lsp.buf.hover()
      end, { desc = "Peek fold/diagnostics/hover" })

      vim.keymap.set("n", "<leader>tz", function()
        vim.opt.foldenable = not vim.opt.foldenable:get()
        local status = vim.opt.foldenable:get() and "enabled" or "disabled"
        vim.notify("Folding " .. status)
      end, { desc = "Toggle folding" })
    end)
  end,
  once = true,
})
