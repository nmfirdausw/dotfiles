vim.cmd "packadd packer.nvim"

local packer = require "packer"
local plugins = require "plugins"

packer.startup {
	function(use)
		for key, plugin in pairs(plugins) do
			if type(key) == "string" and not plugin[1] then
				plugin[1] = key
			end
			use(plugin)
		end
	end,
}
