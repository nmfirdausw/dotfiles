local autopairs_installed, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_installed then return end

autopairs.setup({
    check_ts = true,
    ts_config = { java = false },
    fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
    },
})

local cmp_installed, cmp = pcall(require, "cmp")
if cmp_installed then
    cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done { tex = false })
end
