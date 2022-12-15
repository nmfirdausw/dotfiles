local transparent_installed, transparent = pcall(require, "transparent")
if not transparent_installed then return end

transparent.setup({
    enable = true,
    extra_groups = {
        "TelescopeBorder",
        "TelescopeTitle",
        "NeoTreeFloatTitle",
        "NeoTreeFloatBorder",
        "NeoTreeTabSeparatorInactive",
        "NeoTreeTabSeparatorActive",
        "NeoTreeTabInactive",
        "FloatTitle",
        "FloatBorder",
    },
    exclude = {},
})
