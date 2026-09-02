-- Treesitter folds by default; buffers without a parser fall back to indent
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append({ fold = " " })

-- Per-filetype fold overrides, applied on top of the defaults above
local fold_overrides = {
  php = { foldexpr = "v:lua.vim.lsp.foldexpr()" },
  gitcommit = { foldmethod = "manual", foldexpr = "0" },
}

-- One autocmd for every filetype; the table above decides what happens
local group = vim.api.nvim_create_augroup("fold_overrides", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  callback = function(args)
    local ft = vim.bo[args.buf].filetype

    -- Explicit override wins
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
    end
  end,
})

-- LSP folds are set at FileType, before any server has attached, so the first
-- computation comes back empty. Recompute once a capable client is up.
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_fold_refresh", { clear = true }),
  callback = function(args)
    if vim.wo.foldexpr ~= "v:lua.vim.lsp.foldexpr()" then
      return
    end
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/foldingRange") then
      vim.cmd("normal! zx") -- recompute folds now the server can answer
    end
  end,
})
