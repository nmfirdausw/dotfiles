local kanagawa_installed, kanagawa = pcall(require, "kanagawa")
if not kanagawa_installed then return end

kanagawa.setup({
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = { italic = true },
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = { bold=true },
    variablebuiltinStyle = { italic = true},
    specialReturn = true,
    specialException = true,
    transparent = true,
    dimInactive = false,
    globalStatus = false,
    terminalColors = true,
    colors = {},
    overrides = {},
    theme = "default"
})

vim.cmd("colorscheme kanagawa")
