vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  callback = function()
    vim.hl.hl_op()
 end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local args = vim.fn.argv()
    if #args > 0 then
      local dir = vim.fn.fnamemodify(vim.fn.expand(args[1]), ':p:h')
      if vim.fn.isdirectory(dir) == 1 then
        vim.cmd('cd ' .. vim.fn.fnameescape(dir))
      end
    end
  end,
})
