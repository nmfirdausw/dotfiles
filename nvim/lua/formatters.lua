-- Per-filetype external formatter commands (must read stdin, write stdout)
local formatters = {
  lua = { cmd = "stylua --indent-type Spaces --indent-width 2 --quote-style ForceDouble -" },
}

-- Point gq at the formatter for that buffer, only if the binary exists
for ft, config in pairs(formatters) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    callback = function(args)
      -- First word of the command is the executable to check for
      local bin = config.cmd:match("^(%S+)")
      if vim.fn.executable(bin) == 1 then
        vim.bo[args.buf].formatprg = config.cmd
        -- Clear formatexpr so the LSP doesn't take over gq
        vim.bo[args.buf].formatexpr = ""
      end
    end,
  })
end
