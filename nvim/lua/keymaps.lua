vim.g.mapleader = " "

vim.keymap.set("n", "<Esc>", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
  vim.diagnostic.config({ virtual_text = { current_line = true } })
  vim.cmd("cclose")
  vim.cmd("nohlsearch")
end, { desc = "Close floats and quickfix, clear search highlight" })

-- Paste over selection without losing yanked text
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

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

-- Buffer
vim.keymap.set("n", "<leader>e", "<cmd>bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>n", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>x", function()
  local buf = vim.api.nvim_get_current_buf()
  -- Switch every window showing this buffer to another one first,
  -- so bdelete doesn't close windows or tabs
  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.api.nvim_win_call(win, function()
      local alt = vim.fn.bufnr("#")
      if alt > 0 and alt ~= buf and vim.fn.buflisted(alt) == 1 then
        vim.cmd("buffer #")
      else
        vim.cmd("bprevious")
      end
    end)
  end
  -- Terminal buffers have a running job and need a forced delete
  if vim.bo[buf].buftype == "terminal" then
    vim.cmd("bdelete! " .. buf)
  else
    vim.cmd("bdelete " .. buf)
  end
end, { desc = "Delete buffer" })

-- Tab
vim.keymap.set("n", "<leader>t", "<cmd>tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>m", "<cmd>tabprev<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>i", "<cmd>tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>q", "<cmd>tabclose<CR>", { desc = "Close tab" })

-- Grep into the quickfix list
vim.keymap.set("n", "<leader>g", ":silent grep ", { desc = "Grep" })
vim.keymap.set("n", "<leader>G", "<cmd>silent grep <cword> | copen<CR>", { desc = "Grep word under cursor" })

-- Quickfix navigation: next/prev entry while the quickfix window is open,
-- otherwise keep the keys' default behavior
local function qf_nav(cmd, fallback)
  return function()
    if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
      pcall(vim.cmd, cmd) -- pcall: no error at first/last entry
    else
      local keys = vim.api.nvim_replace_termcodes(fallback, true, false, true)
      vim.api.nvim_feedkeys(keys, "n", false)
    end
  end
end

vim.keymap.set("n", "<C-n>", qf_nav("cnext", "<C-n>"), { desc = "Next quickfix entry" })
vim.keymap.set("n", "<C-p>", qf_nav("cprev", "<C-p>"), { desc = "Previous quickfix entry" })
vim.keymap.set("n", "<C-e>", qf_nav("cprev", "<C-e>"), { desc = "Previous quickfix entry" })
vim.keymap.set("n", "<leader>c", "<cmd>copen<CR>", { desc = "Open quickfix list" })

-- Auto center cursor after jump to next or previous search result
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result" })
