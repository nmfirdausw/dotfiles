-- Merged sign/fold cell: shows the line's sign (diagnostics, etc.) if one
-- exists, otherwise the fold indicator (- open fold start, + closed fold).
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

local function fold_char(lnum)
  if vim.fn.foldclosed(lnum) == lnum then
    return "+"
  end
  if vim.fn.foldlevel(lnum) > vim.fn.foldlevel(lnum - 1) then
    return "-"
  end
  return "│"
end

function _G.SignOrFold()
  if vim.v.virtnum > 0 then
    return " " -- wrapped rows: keep width, show nothing
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

vim.opt.statuscolumn = "%3l %{%v:lua.SignOrFold()%} "

-- No status column in terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.statuscolumn = " "
  end,
})
