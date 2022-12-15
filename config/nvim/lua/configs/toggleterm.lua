local toggleterm_installed, toggleterm = pcall(require, "toggleterm")
if not toggleterm_installed then return end

toggleterm.setup({
    size = 10,
    open_mapping = [[<F7>]],
    shading_factor = 2,
    direction = "float",
    float_opts = {
        border = "curved",
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})
