vim.pack.add({ "https://github.com/folke/which-key.nvim" }, { confirm = false })

vim.g.mapleader = " "

-- Paste over selection without losing yanked text
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

vim.keymap.set("n", "<Esc>", function()
  vim.cmd("nohl")
  -- close floating windows
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      pcall(vim.api.nvim_win_close, win, true)
    end
  end
  -- close quickfix if open
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      vim.cmd("cclose")
      break
    end
  end
end, { desc = "Clear highlights, close floats and quickfix", silent = true })

-- Normal Mode: Move current line up or down
vim.keymap.set("n", "<S-Down>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<S-Up>", ":m .-2<CR>==", { desc = "Move line up" })

-- Visual Mode: Move selected block up or down (maintains selection and re-indents)
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Insert Mode: Move current line up or down while typing
vim.keymap.set("i", "<S-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down (Insert)" })
vim.keymap.set("i", "<S-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up (Insert)" })

-- Keep selection during indent and unindent
vim.keymap.set("v", "<", "<gv", { desc = "Unindent" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent" })

-- Join lines without moving cursor
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines"})

-- Auto center cursor after jump to next or previous search result
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result" })

vim.keymap.set("n", "<leader>re", ":restart<CR>", { desc = "Restart Neovim" })

vim.keymap.set("n", "<leader>u", function()
  vim.cmd.packadd("nvim.undotree")
  require("undotree").open()
end, { desc = "Toggle builtin undotree" })

vim.keymap.set("n", "gl", function()
  vim.diagnostic.config({ virtual_text = false, virtual_lines = false })
  vim.diagnostic.open_float()
end, { desc = "Show diagnostic" })

vim.keymap.set("n", "<leader>q", function()
  if vim.bo.buftype == "terminal" then
    vim.cmd("bd!")
  else
    vim.cmd("bd")
  end
end, { desc = "Close buffer" })

local function qf_is_open()
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      return true
    end
  end
  return false
end

vim.keymap.set("n", "<C-n>", function()
  if qf_is_open() then
    pcall(function() vim.cmd("cnext") end)
  end
end, { desc = "Next quickfix" })

vim.keymap.set("n", "<C-p>", function()
  if qf_is_open() then
    pcall(function() vim.cmd("cprev") end)
  end
end, { desc = "Prev quickfix" })

vim.keymap.set("n", "<C-e>", function()
  if qf_is_open() then
    pcall(function() vim.cmd("cprev") end)
  end
end, { desc = "Prev quickfix" })

vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = "Signature help" })
