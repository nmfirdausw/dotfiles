local impatient_installed, impatient = pcall(require, "impatient")
if impatient_installed then impatient.enable_profile() end

require "settings"
require "bootstrap"
require "utils"
require "autocmds"
require "keymaps"
