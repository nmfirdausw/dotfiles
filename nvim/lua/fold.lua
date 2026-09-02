-- Treesitter folds by default; buffers without a parser fall back to indent,
-- and upgrade to LSP folding if a capable server later attaches
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append({ fold = " " })

-- Per-filetype fold overrides, applied on top of the defaults above
local fold_overrides = {
  gitcommit = { foldmethod = "manual", foldexpr = "0" },
}

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("fold_overrides", { clear = true }),
  callback = function(args)
    local ft = vim.bo[args.buf].filetype

    -- Explicit override wins; never upgraded later
    local opts = fold_overrides[ft]
    if opts then
      for k, v in pairs(opts) do
        vim.wo[0][0][k] = v
      end
      return
    end

    -- Otherwise treesitter, falling back to indent when there's no parser
    local lang = vim.treesitter.language.get_lang(ft)
    local ok = lang and pcall(vim.treesitter.get_parser, args.buf, lang, { error = false })
    if not ok then
      vim.wo[0][0].foldmethod = "indent"
      vim.wo[0][0].foldexpr = "0"
      -- Mark this as a fallback so LspAttach may upgrade it
      vim.b[args.buf].fold_fallback = true
    end
  end,
})

-- Indent folding is the weakest option, so swap it for LSP folds as soon as a
-- server that supports them attaches
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_fold_upgrade", { clear = true }),
  callback = function(args)
    if not vim.b[args.buf].fold_fallback then
      return
    end
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/foldingRange") then
      vim.wo[0][0].foldmethod = "expr"
      vim.wo[0][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
      vim.b[args.buf].fold_fallback = nil
    end
  end,
})
