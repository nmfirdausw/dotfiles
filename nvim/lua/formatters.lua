-- Per-filetype external formatter commands (must read stdin, write stdout).
-- %d in the command is filled in with the buffer's shiftwidth.
-- These take priority over LSP formatting when the binary is installed.
local formatter_overrides = {
  lua = { cmd = "stylua --indent-type Spaces --indent-width %d --quote-style ForceDouble -" },
}

-- Point gq at the external formatter, but only if its binary exists —
-- otherwise leave formatexpr alone so the LSP keeps handling gq
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("formatprg", { clear = true }),
  callback = function(args)
    local config = formatter_overrides[vim.bo[args.buf].filetype]
    if not config then
      return
    end
    -- First word of the command is the executable to check for
    local bin = config.cmd:match("^(%S+)")
    if vim.fn.executable(bin) == 1 then
      vim.bo[args.buf].formatprg = config.cmd:format(vim.bo[args.buf].shiftwidth)
      vim.bo[args.buf].formatexpr = ""
    end
  end,
})

-- LSP attach sets formatexpr and would steal gq back from formatprg, so
-- clear it again for buffers that have an external formatter
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("formatprg_guard", { clear = true }),
  callback = function(args)
    if vim.bo[args.buf].formatprg ~= "" then
      vim.bo[args.buf].formatexpr = ""
    end
  end,
})
