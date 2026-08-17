local formatters = {
  lua = { cmd = "stylua --indent-type Spaces --indent-width 2 --quote-style ForceDouble -" },
}

for ft, config in pairs(formatters) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    callback = function(args)
      local bin = config.cmd:match("^(%S+)")
      if vim.fn.executable(bin) == 1 then
        vim.bo[args.buf].formatprg = config.cmd
        vim.bo[args.buf].formatexpr = ""
      end
    end,
  })
end
