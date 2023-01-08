local heirline_installed, heirline = pcall(require, "heirline")
if not heirline_installed then return end

local conditions = require "heirline.conditions"
local utils = require "heirline.utils"

local colors = require "kanagawa.colors".setup()

local space = {
    provider = " ",
    hl = { bg = colors.sumiInk0, }
}

local align = { provider = "%=" }

local vimode = {
    init = function(self)
        self.mode = vim.fn.mode(1)
        if not self.once then
            vim.api.nvim_create_autocmd("ModeChanged", {
                pattern = "*:*o",
                command = 'redrawstatus'
            })
            self.once = true
        end
    end,
    static = {
        mode_colors = {
            n = colors.lightBlue ,
            i = colors.springGreen,
            v = colors.oniViolet,
            V =  colors.oniViolet,
            ["\22"] =  colors.oniViolet,
            c =  colors.surimiOrange,
            s =  colors.sakuraPink,
            S =  colors.sakuraPink,
            ["\19"] =  colors.sakuraPink,
            R =  colors.peachRed,
            r =  colors.peachRed,
            ["!"] =  colors.crystalBlue,
            t =  colors.carpYellow,
        }
    },
    provider = function()
        return " "
    end,
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { bg = self.mode_colors[mode], bold = true, }
    end,
    update = {
        "ModeChanged",
    },
}

local git_branch = {
    condition = conditions.is_git_repo,
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    hl = { fg = colors.surimiOrange, bg = colors.sumiInk0 },
    {
        provider = function(self)
            return "  " .. self.status_dict.head .. " "
        end,
        hl = { bold = true }
    },
}

local function get_file_name(file)
    return file:match("^.+/(.+)$")
end

local file_flags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = " ",
        hl = { fg = colors.autumnYellow },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = "",
        hl = { fg = colors.autumnRed },
    },
}

local file_icon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return " " .. self.icon and (" " .. self.icon .. " ")
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end
}

local file_type = {
    provider = function()
        return string.upper(vim.bo.filetype)
    end,
    hl = { fg = utils.get_highlight("Type").fg, bold = true, bg = colors.sumiInk0 },
}

local file_name = {
    provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then
            return "[No Name]"
        end
        if string.find(filename, "/") then
            filename = get_file_name(filename)
        end
        return filename .. " "
        end,
    hl = { fg = colors.fujiWhite },
}

local file_name_block = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
    hl = { bg = colors.sumiInk0 },
}

local file_name_modifier = {
    hl = function()
        if vim.bo.modified then
            return { fg = colors.autumnYellow, bold = true, force=true }
        end
    end,
}

file_name = utils.insert(file_name_block,
    file_icon,
    utils.insert(file_name_modifier, file_name),
    unpack(file_flags),
    { provider = '%<'}
)

local file_path_block = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
}

local file_path_modifier = {
    hl = function()
        if vim.bo.modified then
          return { bold = true, force=true }
        end
    end,
}

local file_path = {
    provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then
            return "[No Name]"
        end
        return filename .. " "
    end,
}

file_path = utils.insert(file_path_block,
    file_icon,
    utils.insert(file_path_modifier, file_path),
    unpack(file_flags),
    { provider = '%<'}
)

local git_status = {
    condition = conditions.is_git_repo,
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    hl = { fg = colors.autumnGreen, bg = colors.sumiInk0 },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and ("  " .. count .. " ")
        end,
    hl = { fg = colors.autumnGreen },
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and ("  " .. count .. " ")
        end,
        hl = { fg = colors.autumnRed },
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and ("  " .. count .. " ")
        end,
        hl = { fg = colors.autumnYellow },
    },
}

local diagnostics = {
    condition = conditions.has_diagnostics,
    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,
    update = { "DiagnosticChanged", "BufEnter" },
    {
        provider = function(self)
            return self.errors > 0 and (" " .. " " .. self.errors .. " ")
        end,
        hl = { fg = colors.samuraiRed },
    },
    {
        provider = function(self)
            return self.warnings > 0 and (" " .. " " .. self.warnings .. " ")
        end,
        hl = { fg = colors.roninYellow },
    },
    {
        provider = function(self)
            return self.info > 0 and (" " .. " " .. self.info .. " ")
        end,
        hl = { fg = colors.waveAqua1 },
    },
    {
        provider = function(self)
            return self.hints > 0 and (" " .. " " .. self.hints .. " ")
        end,
        hl = { fg = colors.dragonBlue },
    },
    hl = { bg = colors.sumiInk0 }
}

local lsp_active = {
    condition = conditions.lsp_attached,
    update = {'LspAttach', 'LspDetach'},
    {
        provider = "  ",
        hl = { bg = colors.sumiInk0 }
    },
    {
        provider  = function()
            local names = {}
            for _, server in pairs(vim.lsp.buf_get_clients(0)) do
                table.insert(names, server.name)
            end
            return table.concat(names, " ")
        end,
        hl = { fg = colors.springGreen, bold = true, bg = colors.sumiInk0 },
    },
    {
        provider = " ",
        hl = { bg = colors.sumiInk0 }
    },
}

local ruler =  {
    provider = " " .. "%7(%l/%3L%):%2c %P" .. " ",
    hl = { bg = colors.sumiInk0 }
}

local scroll_bar = {
    static = {
        -- sbar = { '█', '▇', '▆', '▅', '▄', '▃', '▂', '▁', ' ' }
        sbar = { ' ', '▁', '▂', '▃', '▄', '▆', '▆', '▇', '█' }
    },
    provider = function(self)
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
        return string.rep(self.sbar[i], 2)
    end,
    hl = { fg = colors.peachRed, bg = colors.sumiInk0 },
}

local terminal_name = {
    provider = function()
        local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
        return " " .. tname .. " "
    end,
    hl = { bold = true, bg = colors.sumiInk0 },
}

local navic_bar = {
    condition = require("nvim-navic").is_available,
    static = {
        type_hl = {
            File = "Directory",
            Module = "@include",
            Namespace = "@namespace",
            Package = "@include",
            Class = "@structure",
            Method = "@method",
            Property = "@property",
            Field = "@field",
            Constructor = "@constructor",
            Enum = "@field",
            Interface = "@type",
            Function = "@function",
            Variable = "@variable",
            Constant = "@constant",
            String = "@string",
            Number = "@number",
            Boolean = "@boolean",
            Array = "@field",
            Object = "@type",
            Key = "@keyword",
            Null = "@comment",
            EnumMember = "@field",
            Struct = "@structure",
            Event = "@keyword",
            Operator = "@operator",
            TypeParameter = "@type",
        },
        enc = function(line, col, winnr)
            return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
        end,
        dec = function(c)
            local line = bit.rshift(c, 16)
            local col = bit.band(bit.rshift(c, 6), 1023)
            local winnr = bit.band(c,  63)
            return line, col, winnr
        end
    },
    init = function(self)
        local data = require("nvim-navic").get_data() or {}
        local children = {}
        for i, d in ipairs(data) do
            local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
            local child = {
                {
                    provider = d.icon,
                    hl = self.type_hl[d.type],
                },
                {
                    provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ''),
                    on_click = {
                        minwid = pos,
                        callback = function(_, minwid)
                            local line, col, winnr = self.dec(minwid)
                            vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), {line, col})
                        end,
                        name = "heirline_navic",
                    },
                },
            }
            if #data > 1 and i < #data then
                table.insert(child, {
                    provider = " ",
                })
            end
            table.insert(children, child)
        end
        self.child = self:new(children, 1)
    end,
    provider = function(self)
        return self.child:eval()
    end,
    hl = { fg = colors.fujiWhite },
    update = 'CursorMoved'
}

local terminal_status_line = {
    condition = function()
        return conditions.buffer_matches({ buftype = { "terminal" } })
    end,
    vimode, space, file_type, space, terminal_name, align,
    ruler, space, scroll_bar,space, vimode
}

local default_statusline = {
    condition = function()
        return not conditions.buffer_matches({ buftype = { "terminal" } })
    end,
	vimode, git_branch, git_status, file_name, align,
    diagnostics, lsp_active, ruler, scroll_bar, space, vimode
}

local status_line = { terminal_status_line, default_statusline }

local winbar = {
    {
        condition = function()
            return conditions.buffer_matches({
                buftype = { "nofile", "prompt", "help", "quickfix", "terminal" },
                filetype = { "^git.*", "fugitive" },
            })
        end,
        init = function()
            vim.opt_local.winbar = nil
        end
    },
    { navic_bar, align, file_path }
}

heirline.setup(status_line, winbar)
