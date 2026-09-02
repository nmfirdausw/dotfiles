-- fff: fuzzy file picker
vim.pack.add({ "https://github.com/dmtrKovalenko/fff" }, { confirm = false })

-- fff ships a Rust binary, so fetch or build it after install and update
vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("fff_build", { clear = true }),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "fff" and (kind == "install" or kind == "update") then
      -- On a fresh install the plugin isn't on the runtimepath yet
      if not ev.data.active then
        vim.cmd.packadd("fff")
      end
      require("fff.download").download_or_build_binary()
    end
  end,
})

-- Picker config, read by the plugin on setup
vim.g.fff = {
  lazy_sync = true,
  debug = {
    enabled = true,
    show_scores = true,
  },
  prompt = " ",
  layout = {
    border = "rounded",
  },
}

-- Back :find with fff's fuzzy matcher instead of the 'path' walk
_G.custom_fff_find = function(cmdarg, cmdcomplete)
  -- Fallback to a wild character search if the query is blank or empty
  local query = (cmdarg == "") and "*" or cmdarg
  -- Swallow errors so a picker failure doesn't break :find completion
  local success, result = pcall(function()
    return require("fff").file_search(query, { mode = "files" })
  end)
  if not success or not result or not result.items then
    return {}
  end
  local parsed_paths = {}
  for _, item in ipairs(result.items) do
    if item.relative_path then
      table.insert(parsed_paths, item.relative_path)
    end
  end
  return parsed_paths
end

-- Assign the global Lua function directly to Vim's internal findfunc handler
vim.o.findfunc = "v:lua.custom_fff_find"
