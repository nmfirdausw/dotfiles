_G.nik = {}

nik.file_plugins = {}
nik.git_plugins = {}
nik.icons = require "icons"

function nik.get_icon(kind)
    return nik.icons[kind] or ""
end

function nik.is_installed(plugin) return packer_plugins ~= nil and packer_plugins[plugin] ~= nil end

function nik.lazy_load_commands(plugin, commands)
    if type(commands) == "string" then commands = { commands } end
        if nik.is_installed(plugin) and not packer_plugins[plugin].loaded then
            for _, command in ipairs(commands) do
            pcall(
                vim.cmd,
                string.format(
                    'command -nargs=* -range -bang -complete=file %s lua require("packer.load")({"%s"}, { cmd = "%s", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)',
                    command,
                    plugin,
                    command
                )
            )
        end
    end
end

function nik.load_plugin_with_func(plugin, module, func_names)
    if type(func_names) == "string" then func_names = { func_names } end
    for _, func in ipairs(func_names) do
        local old_func = module[func]
        module[func] = function(...)
            module[func] = old_func
            require("packer").loader(plugin)
            module[func](...)
        end
    end
end

function nik.system_open(path)
    path = path or vim.fn.expand "<cfile>"
    if vim.fn.has "mac" == 1 then
        vim.fn.jobstart({ "open", path }, { detach = true })
    elseif vim.fn.has "unix" == 1 then
        vim.fn.jobstart({ "xdg-open", path }, { detach = true })
    else
        astronvim.notify("System open is not supported on this OS!", "error")
    end
end

return nik
