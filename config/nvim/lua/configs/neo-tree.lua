local neotree_installed, neotree = pcall(require, "neo-tree")
if not neotree_installed then return end

neotree.setup({
    close_if_last_window = true,
    enable_diagnostics = false,
    popup_border_style = "single",
    source_selector = {
        winbar = true,
        content_layout = "center",
        tab_labels = {
            filesystem = nik.get_icon "FolderClosed" .. " File",
            buffers = nik.get_icon "DefaultFile" .. " Bufs",
            git_status = nik.get_icon "Git" .. " Git",
            diagnostics = nik.get_icon "Diagnostic" .. " Diagnostic",
        },
    },
    default_component_configs = {
        indent = { padding = 0 },
        icon = {
            folder_closed = nik.get_icon "FolderClosed",
            folder_open = nik.get_icon "FolderOpen",
            folder_empty = nik.get_icon "FolderEmpty",
            default = nik.get_icon "DefaultFile",
        },
        modified = {
            symbol = '',
        },
        git_status = {
            symbols = {
                added = nik.get_icon "GitAdd",
                deleted = nik.get_icon "GitDelete",
                modified = nik.get_icon "GitChange",
                renamed = nik.get_icon "GitRenamed",
                untracked = nik.get_icon "GitUntracked",
                ignored = nik.get_icon "GitIgnored",
                unstaged = nik.get_icon "GitUnstaged",
                staged = nik.get_icon "GitStaged",
                conflict = nik.get_icon "GitConflict",
            },
        },
    },
    window = {
        width = 30,
        mappings = {
            ["<space>"] = false,
            o = "open",
            O = function(state) nik.system_open(state.tree:get_node():get_id()) end,
            H = "prev_source",
            L = "next_source",
        },
    },
    filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        window = { mappings = { h = "toggle_hidden" } },
    },
    event_handlers = {
        { event = "neo_tree_buffer_enter", handler = function(_) vim.opt_local.signcolumn = "auto" end },
    },
})
