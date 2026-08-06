if not vim.g.neovide then
  return
end

vim.opt.linespace = 5
vim.g.neovide_pixel_geometry = "RGBH"
vim.g.neovide_floating_shadow = false
vim.g.neovide_position_animation_length = 0.05
vim.g.neovide_scroll_animation_length = 0.15
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_message_area_drag_selection = true
vim.g.neovide_refresh_rate = 120
vim.g.neovide_detach_on_quit = "prompt"
vim.g.neovide_remember_window_size = true
vim.g.neovide_highlight_matching_pair = true
vim.g.neovide_input_macos_option_key_is_meta = "both"
vim.g.neovide_cursor_animation_length = 0.100

vim.cmd("terminal")
vim.cmd("startinsert")
