local function toggle_terminal()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(buf)
    if name:find("term://") then
      vim.api.nvim_set_current_buf(buf)
      vim.cmd("startinsert") 
      return
    end
  end

  vim.cmd("terminal")
  vim.cmd("startinsert")
end

local function bprev()
  vim.cmd("buffer previous")
end

vim.keymap.set("n", "<leader>t", toggle_terminal, { desc = "Go to or create terminal" })

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Go to previous buffer from terminal' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>:bprev<CR>', { desc = 'Go to previous buffer from terminal' })
