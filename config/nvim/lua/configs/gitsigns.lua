local gitsigns_installed, gitsigns = pcall(require, "gitsigns")
if not gitsigns_installed then return end

gitsigns.setup({
    signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▎" },
        topdelete = { text = "契" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
    },
})
