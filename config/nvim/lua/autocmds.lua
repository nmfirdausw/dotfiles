vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("git_plugin_lazy_load", { clear = true }),
        callback = function()
            vim.fn.system("git -C " .. vim.fn.expand "%:p:h" .. " rev-parse")
            if vim.v.shell_error == 0 then
                vim.api.nvim_del_augroup_by_name "git_plugin_lazy_load"
            local packer = require "packer"
            vim.tbl_map(function(plugin) packer.loader(plugin) end, nik.git_plugins)
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("file_plugin_lazy_load", { clear = true }),
    callback = function()
        local title = vim.fn.expand "%"
        if not (title == "" or title == "[packer]" or title:match "^neo%-tree%s+filesystem") then
            vim.api.nvim_del_augroup_by_name "file_plugin_lazy_load"
            local packer = require "packer"
            vim.tbl_map(function(plugin) packer.loader(plugin) end, nik.file_plugins)
        end
    end,
})


