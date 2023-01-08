local leap_installed, leap = pcall(require, "leap")
if not leap_installed then return end

leap.add_default_mappings()
