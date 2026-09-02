-- Line numbers, with the cursor line highlight applied to the number only
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Highest-priority sign extmark on a line, or nil if there is none
local function get_sign(buf, lnum)
  local marks = vim.api.nvim_buf_get_extmarks(
    buf,
    -1,
    { lnum - 1, 0 },
    { lnum - 1, -1 },
    { type = "sign", details = true }
  )
  local best
  for _, mark in ipairs(marks) do
    local details = mark[4]
    if details and details.sign_text and (not best or (details.priority or 0) > (best.priority or 0)) then
      best = details
    end
  end
  return best
end

-- Fold indicator: + closed fold, - start of an open fold, │ otherwise
local function fold_char(lnum)
  if vim.fn.foldclosed(lnum) == lnum then
    return "+"
  end
  if vim.fn.foldlevel(lnum) > vim.fn.foldlevel(lnum - 1) then
    return "-"
  end
  return "│"
end

-- Width of the number cell: digits in the buffer's last line number, min 3
local function num_width()
  local win = vim.g.statusline_winid
  local buf = win and vim.api.nvim_win_get_buf(win) or vim.api.nvim_get_current_buf()
  return math.max(3, #tostring(vim.api.nvim_buf_line_count(buf)))
end

-- Number cell: blank but same width on wrapped and virtual rows
function _G.LineNum()
  local width = num_width()
  if vim.v.virtnum ~= 0 then
    return string.rep(" ", width) .. " "
  end
  return "%" .. width .. "l"
end

-- Merged sign/fold cell: the line's sign if it has one, otherwise the fold
-- indicator. Wrapped and virtual rows keep the fold guide unbroken.
function _G.SignOrFold()
  if vim.v.virtnum ~= 0 then
    return "│"
  end
  local lnum = vim.v.lnum
  local sign = get_sign(vim.api.nvim_get_current_buf(), lnum)
  if sign then
    local hl = sign.sign_hl_group or "SignColumn"
    return "%#" .. hl .. "#" .. vim.trim(sign.sign_text) .. "%*"
  end
  return fold_char(lnum)
end

-- Signs are drawn by the cell above, so hide the built-in sign column
vim.opt.signcolumn = "no"
vim.opt.statuscolumn = "%{%v:lua.LineNum()%} %{%v:lua.SignOrFold()%} "

-- :terminal forces numbers off, so put the global values back
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("term_open", { clear = true }),
  callback = function()
    vim.opt_local.number = vim.go.number
    vim.opt_local.relativenumber = vim.go.relativenumber
  end,
})

-- Absolute numbers only in quickfix and location list windows
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("qf_number", { clear = true }),
  pattern = "qf",
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = vim.go.number
  end,
})
