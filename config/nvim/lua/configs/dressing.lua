local dressing_installed, dressing = pcall(require, "dressing")
if not dressing_installed then return end

dressing.setup({
    input = {
        default_prompt = "➤ ",
        win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" },
    },
    select = {
        backend = { "telescope", "builtin" },
        builtin = { win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" } },
    },
})
