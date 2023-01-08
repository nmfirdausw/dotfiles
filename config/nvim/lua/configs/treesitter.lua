local treesitter_installed, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_installed then return end

treesitter.setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'php' },
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    rainbow = {
        enable = true,
        disable = { },
        extended_mode = false,
        max_file_lines = nil,
    },
    autotag = { enable = true },
    incremental_selection = { enable = true },
    indent = { enable = false },
})
