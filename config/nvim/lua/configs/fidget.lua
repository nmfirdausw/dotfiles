local fidget_installed, fidget = pcall(require, "fidget")
if not fidget_installed then return end

fidget.setup {}
