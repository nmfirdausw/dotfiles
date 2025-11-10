vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.schedule(function()
      vim.cmd.packadd("gitsigns.nvim")
      require("gitsigns").setup({
        attach_to_untracked = true,
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "-" },
          untracked = { text = "┆" },
        },
        signs_staged = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "-" },
          untracked = { text = "┆" },
        },
        preview_config = {
          border = "rounded",
        },
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")
          vim.keymap.set("n", "<leader>]h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]h", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end, { desc = "Next hunk", buffer = bufnr })

          vim.keymap.set("n", "<leader>[h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[h", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end, { desc = "Previous hunk", buffer = bufnr })

          vim.keymap.set("n", "<leader>[h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[H", bang = true })
            else
              gitsigns.nav_hunk("first")
            end
          end, { desc = "First hunk", buffer = bufnr })

          vim.keymap.set("n", "<leader>[h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]H", bang = true })
            else
              gitsigns.nav_hunk("last")
            end
          end, { desc = "Last hunk", buffer = bufnr })

          vim.keymap.set("n", "<leader>ghs", gitsigns.stage_hunk, { desc = "Stage hunk", buffer = bufnr })
          vim.keymap.set("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "Reset hunk", buffer = bufnr })

          vim.keymap.set("v", "<leader>ghs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Stage hunk", buffer = bufnr })

          vim.keymap.set("v", "<leader>ghr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Reset hunk", buffer = bufnr })

          vim.keymap.set("n", "<leader>gs", gitsigns.stage_buffer, { desc = "Stage buffer", buffer = bufnr })
          vim.keymap.set("n", "<leader>gs", gitsigns.reset_buffer, { desc = "Reset buffer", buffer = bufnr })
          vim.keymap.set("n", "<leader>ghu", gitsigns.stage_hunk, { desc = "Undo stage hunk", buffer = bufnr })
          vim.keymap.set("n", "<leader>ghp", gitsigns.preview_hunk, { desc = "Preview hunk", buffer = bufnr })
          vim.keymap.set(
            "n",
            "<leader>ghi",
            gitsigns.preview_hunk_inline,
            { desc = "Preview hunk inline", buffer = bufnr }
          )
          vim.keymap.set("n", "<leader>gbb", function()
            gitsigns.blame()
          end, { desc = "Blame buffer", buffer = bufnr })
          vim.keymap.set("n", "<leader>gbp", function()
            gitsigns.blame_line({ full = true })
          end, { desc = "Blame preview", buffer = bufnr })
          vim.keymap.set(
            "n",
            "<leader>gbl",
            gitsigns.toggle_current_line_blame,
            { desc = "Toggle blame line", buffer = bufnr }
          )
          vim.keymap.set(
            "n",
            "<leader>gdd",
            gitsigns.preview_hunk_inline,
            { desc = "Toggle deleted lines", buffer = bufnr }
          )
          vim.keymap.set("n", "<leader>gdw", gitsigns.toggle_word_diff, { desc = "Toggle word diff", buffer = bufnr })
          vim.keymap.set("n", "<leader>gdl", gitsigns.toggle_linehl, { desc = "Toggle line highlight", buffer = bufnr })
          vim.keymap.set("n", "<leader>gn", gitsigns.toggle_numhl, { desc = "Toggle number highlight", buffer = bufnr })
          vim.keymap.set("n", "<leader>gs", gitsigns.toggle_signs, { desc = "Toggle git signs", buffer = bufnr })
          vim.keymap.set(
            "n",
            "<leader>tgb",
            gitsigns.toggle_current_line_blame,
            { desc = "Toggle blame line", buffer = bufnr }
          )
          vim.keymap.set(
            "n",
            "<leader>tgd",
            gitsigns.preview_hunk_inline,
            { desc = "Toggle deleted lines", buffer = bufnr }
          )
          vim.keymap.set("n", "<leader>tgw", gitsigns.toggle_word_diff, { desc = "Toggle word diff", buffer = bufnr })
          vim.keymap.set("n", "<leader>tgl", gitsigns.toggle_linehl, { desc = "Toggle line highlight", buffer = bufnr })
          vim.keymap.set(
            "n",
            "<leader>tgn",
            gitsigns.toggle_numhl,
            { desc = "Toggle number highlight", buffer = bufnr }
          )
          vim.keymap.set("n", "<leader>tgs", gitsigns.toggle_signs, { desc = "Toggle git signs", buffer = bufnr })
          vim.keymap.set({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select hunk", buffer = bufnr })
          vim.keymap.set("n", "<leader>gdb", gitsigns.diffthis, { desc = "Diff buffer", buffer = bufnr })
        end,
      })
    end)
  end,
  once = true,
})
