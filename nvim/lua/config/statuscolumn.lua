_G.StatusColumn = function()
  local lnum = vim.v.lnum
  local bufnr = vim.api.nvim_get_current_buf()
  local signs = vim.fn.sign_getplaced(bufnr, { lnum = lnum, group = "*" })[1].signs
  local fillchars = vim.opt.fillchars:get()
  local statuscolumn = "%=%4r%4l"

  if vim.opt.foldenable:get() then
    if vim.fn.foldlevel(lnum) > 0 then
      if vim.fn.foldclosed(lnum) ~= -1 then
        statuscolumn = "%#Folded#%=%4r%4l"
        if vim.opt.number:get() or vim.opt.relativenumber:get() then
          statuscolumn = statuscolumn .. "  "
        end
        if vim.opt.signcolumn:get() == "no" then
          if vim.opt.number:get() or vim.opt.relativenumber:get() then
            return statuscolumn .. " "
          else
            return statuscolumn .. ""
          end
        end
        return statuscolumn .. fillchars.foldclose .. "  %*"
      end
      if vim.fn.foldlevel(lnum) > vim.fn.foldlevel(lnum - 1) then
        statuscolumn = "%=%4r%4l"
        if vim.opt.number:get() or vim.opt.relativenumber:get() then
          statuscolumn = statuscolumn .. "  "
        end
        if vim.opt.signcolumn:get() == "no" then
          if vim.opt.number:get() or vim.opt.relativenumber:get() then
            return statuscolumn .. " "
          else
            return statuscolumn .. ""
          end
        end
        if #signs > 0 and not signs[1].group:match("gitsigns_signs_") then
          return statuscolumn .. "%s "
        end
        return statuscolumn .. fillchars.foldopen .. "  "
      end
    end
  end

  if vim.opt.number:get() or vim.opt.relativenumber:get() then
    statuscolumn = statuscolumn .. "  "
  end

  if vim.opt.signcolumn:get() == "no" then
    if vim.opt.number:get() or vim.opt.relativenumber:get() then
      return statuscolumn .. " "
    else
      return statuscolumn .. ""
    end
  end

  if #signs > 0 then
    return statuscolumn .. "%s "
  end

  return statuscolumn .. "│  "
end

-- Enable the custom statuscolumn
vim.opt.statuscolumn = "%{%v:lua._G.StatusColumn()%}"

-- Disable statuscolumn for special buffer types
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.buftype ~= "" and vim.bo.buftype ~= "prompt" then
      vim.opt_local.statuscolumn = ""
      vim.opt_local.number = false
      vim.opt_local.signcolumn = "no"
    end
  end,
})
