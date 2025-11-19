local M = {}

-- Servers to enable
-- Make sure to configure them in lsp folder
M.enable = {
  "lua_ls", -- paru -S lua-language-server
  "copilot", -- bun add -g @github/copilot-language-server
}

-- Default config
M.config = {
  codelens = true,
  inlay_hints = true,
}

-- Setup and enable LSP features
M.setup = function()
  vim.g.codelens = M.config.codelens
  vim.g.inlay_hints = M.config.inlay_hints
  vim.lsp.enable(M.enable)

  local codelens_group = nil
  local function enable_codelens()
    vim.lsp.codelens.refresh()
    vim.schedule(function()
      vim.lsp.codelens.refresh()
    end)

    if not codelens_group then
      codelens_group = vim.api.nvim_create_augroup("LspCodelens", { clear = true })
    end
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
      group = codelens_group,
      callback = vim.lsp.codelens.refresh,
    })
    vim.g.codelens = true
  end

  local function disable_codelens()
    vim.lsp.codelens.clear()
    if codelens_group then
      vim.api.nvim_clear_autocmds({ group = codelens_group })
    end
    vim.g.codelens = false
  end

  local function toggle_codelens()
    if vim.g.codelens then
      disable_codelens()
      vim.notify("CodeLens disabled")
    else
      enable_codelens()
      vim.notify("CodeLens enabled")
    end
  end

  -- Set up autocmd to enable features based on LSP capabilities
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        -- Enable inlay hints if supported
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          vim.defer_fn(function()
            vim.lsp.inlay_hint.enable(vim.g.inlay_hints)
          end, 1000)

          vim.keymap.set("n", "<leader>ti", function()
            local current_state = vim.lsp.inlay_hint.is_enabled()
            vim.lsp.inlay_hint.enable(not current_state)
            print("Inlay hints " .. (not current_state and "enabled" or "disabled"))
          end, { desc = "Toggle inlay hints" })
        end

        -- Enable CodeLens if supported
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
          if vim.g.codelens then
            vim.defer_fn(function()
              enable_codelens()
            end, 1000)
          end
          vim.keymap.set("n", "<leader>tl", toggle_codelens, { desc = "Toggle CodeLens" })
        end

        -- Setup inline completion if supported
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion) then
          vim.lsp.inline_completion.enable(true)
          vim.keymap.set("i", "<C-a>", function()
            if not vim.lsp.inline_completion.get() then
              return "<C-a>"
            end
          end, { expr = true, replace_keycodes = true, desc = "Accept inline suggestion" })
          vim.keymap.set("i", "<C-n>", function()
            vim.lsp.inline_completion.select({})
          end, { desc = "Next inline suggestion" })
          vim.keymap.set("i", "<C-e>", function()
            vim.lsp.inline_completion.select({ count = -1 })
          end, { desc = "Previous inline suggestion" })
        end
      end
    end,
  })

  vim.lsp.inlay_hint.enable(vim.g.inlay_hints)
end

return M
