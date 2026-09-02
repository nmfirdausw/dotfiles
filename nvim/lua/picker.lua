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
