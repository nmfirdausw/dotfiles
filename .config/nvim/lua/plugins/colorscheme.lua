return {
  "diegoulloao/neofusion.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("neofusion").setup({
      transparent_mode = true,
      overrides = {
        CursorLineNr = { link = "NeofusionYellowBold" },
      }
    })
    vim.cmd.colorscheme("neofusion")
  end
}
