-- Space as leader
vim.g.mapleader = " "

-- Paste over selection without clobbering the register
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste" })

-- Delete into the black hole register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

-- Shift+Up/Down moves the line or selection, reindenting after the move
vim.keymap.set("n", "<S-Down>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<S-Up>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("i", "<S-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down (Insert)" })
vim.keymap.set("i", "<S-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up (Insert)" })

-- Keep selection during indent and unindent
vim.keymap.set("v", "<", "<gv", { desc = "Unindent" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent" })

-- Join lines without moving the cursor
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines" })

-- Auto center cursor after jump to next or previous search result
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result" })

-- Buffer management
vim.keymap.set("n", "<leader>bb", "<C-^>", { desc = "Toggle between 2 buffers" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })

-- Delete the current buffer but keep its windows open, switching them to the
-- alternate buffer first
vim.keymap.set("n", "<leader>x", function()
  local buf = vim.api.nvim_get_current_buf()
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
  -- Terminals are never "saved", so force the delete
  if vim.bo[buf].buftype == "terminal" then
    vim.cmd("bdelete! " .. buf)
  else
    vim.cmd("bdelete " .. buf)
  end
end, { desc = "Delete buffer" })

-- Tab management
vim.keymap.set("n", "<leader><Tab><Tab>", "<cmd>tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader><Tab>p", "<cmd>tabprev<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader><Tab>n", "<cmd>tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader><Tab>x", "<cmd>tabclose<CR>", { desc = "Close tab" })

-- Wrapping list navigation: prefers the location list when this window has one
-- open, otherwise the quickfix list, otherwise the key's default behaviour
local function list_nav(dir, fallback)
  return function()
    local kind, list

    -- Location list is window-local, so check this window first
    local loc = vim.fn.getloclist(0, { winid = 0, idx = 0, size = 0 })
    if loc.winid ~= 0 then
      kind, list = "l", loc
    else
      local qf = vim.fn.getqflist({ winid = 0, idx = 0, size = 0 })
      if qf.winid ~= 0 then
        kind, list = "c", qf
      end
    end

    -- Neither list is open: pass the key through untouched
    if not kind then
      local keys = vim.api.nvim_replace_termcodes(fallback, true, false, true)
      vim.api.nvim_feedkeys(keys, "n", false)
      return
    end

    if list.size == 0 then
      return
    end

    -- Wrap to the other end instead of erroring at the boundary
    if dir == "next" then
      vim.cmd(list.idx >= list.size and kind .. "first" or kind .. "next")
    else
      vim.cmd(list.idx <= 1 and kind .. "last" or kind .. "prev")
    end
  end
end

-- List navigation
vim.keymap.set("n", "<C-n>", list_nav("next", "<C-n>"), { desc = "Next list entry" })
vim.keymap.set("n", "<C-p>", list_nav("prev", "<C-p>"), { desc = "Previous list entry" })
vim.keymap.set("n", "<C-e>", list_nav("prev", "<C-e>"), { desc = "Previous list entry" })

-- Open the lists
vim.keymap.set("n", "<leader>c", ":copen<CR>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>l", ":lopen<CR>", { desc = "Open location list" })

-- Esc: close floating windows, restore current-line virtual text, close
-- quickfix and location lists, clear search highlight
vim.keymap.set("n", "<Esc>", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
  vim.diagnostic.config({ virtual_text = { current_line = true } })
  vim.cmd("cclose")
  vim.cmd("silent! lclose")
  vim.cmd("nohlsearch")
end, { desc = "Close floats, quickfix and loclist, clear search highlight" })
