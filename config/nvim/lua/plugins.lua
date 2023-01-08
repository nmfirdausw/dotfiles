return {
    ["wbthomason/packer.nvim"] = {
        setup = function()
            nik.lazy_load_commands("packer.nvim", {
                "PackerSnapshot",
                "PackerSnapshotRollback",
                "PackerSnapshotDelete",
                "PackerInstall",
                "PackerUpdate",
                "PackerSync",
                "PackerClean",
                "PackerCompile",
                "PackerStatus",
                "PackerProfile",
                "PackerLoad",
            })
        end,
    },

    ["lewis6991/impatient.nvim"] = {},

    ["nvim-lua/plenary.nvim"] = { module = "plenary" },

    ["MunifTanjim/nui.nvim"] = { module = "nui" },

    ["stevearc/dressing.nvim"] = {
        opt = true,
        setup = function() nik.load_plugin_with_func("dressing.nvim", vim.ui, { "input", "select" }) end,
        config = function() require "configs.dressing" end,
    },

    ["nvim-tree/nvim-web-devicons"] = {
        module = "nvim-web-devicons",
        config = function() require "configs.nvim-web-devicons" end,
    },

    ["rebelot/kanagawa.nvim"] = {
        config = function() require "configs.kanagawa" end,
    },

    ["onsails/lspkind.nvim"] = {
        module = "lspkind",
        config = function() require "configs.lspkind" end,
    },

	["SmiteshP/nvim-navic"] = {
	    module = "nvim-navic",
        config = function() require "configs.navic" end,
	},

    ["neovim/nvim-lspconfig"] = {
        module = "lspconfig",
        after = "nvim-navic",
        setup = function() table.insert(nik.file_plugins, "nvim-lspconfig") end,
        config = function() require "configs.lspconfig" end,
    },

    ["ray-x/lsp_signature.nvim"] = {
        config = function() require "configs.lsp-signature" end,
    },

    ["https://git.sr.ht/~whynothugo/lsp_lines.nvim"] = {
        config = function() require "configs.lsp-lines" end,
    },

    ["j-hui/fidget.nvim"] = {
        config = function() require "configs.fidget" end,
    },

    ["rafamadriz/friendly-snippets"] = { opt = true },

    ["L3MON4D3/LuaSnip"] = {
        module = "luasnip",
        wants = "friendly-snippets",
        config = function() require "configs.luasnip" end,
    },

    ["hrsh7th/nvim-cmp"] = {
        event = "InsertEnter",
        config = function() require "configs.cmp" end
    },

    ["saadparwaiz1/cmp_luasnip"] = { after = "nvim-cmp" },

    ["hrsh7th/cmp-buffer"] = { after = "nvim-cmp" },

    ["hrsh7th/cmp-path"] = { after = "nvim-cmp" },

    ["hrsh7th/cmp-nvim-lsp"] = { after = "nvim-cmp" },

    ["nvim-treesitter/nvim-treesitter"] = {
        module = "nvim-treesitter",
        setup = function()
        table.insert(nik.file_plugins, "nvim-treesitter")
        nik.lazy_load_commands("nvim-treesitter", {
            "TSBufDisable",
            "TSBufEnable",
            "TSBufToggle",
            "TSDisable",
            "TSEnable",
            "TSToggle",
            "TSInstall",
            "TSInstallInfo",
            "TSInstallSync",
            "TSModuleInfo",
            "TSUninstall",
            "TSUpdate",
            "TSUpdateSync",
        })
        end,
        run = function() require("nvim-treesitter.install").update { with_sync = true }() end,
        config = function() require "configs.treesitter" end,
    },

    ["p00f/nvim-ts-rainbow"] = { after = "nvim-treesitter" },

    ["windwp/nvim-ts-autotag"] = { after = "nvim-treesitter" },

    ["JoosepAlviste/nvim-ts-context-commentstring"] = { after = "nvim-treesitter" },

    ["numToStr/Comment.nvim"] = {
        module = "Comment",
        keys = { "gc", "gb" },
        config = function() require "configs.Comment" end,
    },

    ["windwp/nvim-autopairs"] = {
        event = "InsertEnter",
        config = function() require "configs.autopairs" end
    },

    ["lukas-reineke/indent-blankline.nvim"] = {
        opt = true,
        setup = function() table.insert(nik.file_plugins, "indent-blankline.nvim") end,
        config = function() require "configs.indent-blankline" end,
    },

    ["lewis6991/gitsigns.nvim"] = {
        disable = vim.fn.executable "git" == 0,
        ft = "gitcommit",
        setup = function() table.insert(nik.git_plugins, "gitsigns.nvim") end,
        config = function() require "configs.gitsigns" end,
    },

    ["akinsho/toggleterm.nvim"] = {
        module = "toggleterm",
        setup = function() nik.lazy_load_commands("toggleterm.nvim", "ToggleTerm") end,
        config = function() require "configs.toggleterm" end,
    },

    ["nvim-neo-tree/neo-tree.nvim"] = {
        module = "neo-tree",
        setup = function()
            nik.lazy_load_commands("neo-tree.nvim", "Neotree")
            vim.g.neo_tree_remove_legacy_commands = true
        end,
        config = function() require "configs.neo-tree" end,
    },

    ["nvim-telescope/telescope.nvim"] = {
        module = "telescope",
        setup = function() nik.lazy_load_commands("telescope.nvim", "Telescope") end,
        config = function() require "configs.telescope" end,
    },

    ["nvim-telescope/telescope-fzf-native.nvim"] = {
        after = "telescope.nvim",
        disable = vim.fn.executable "make" == 0,
        run = "make",
        config = function() require("telescope").load_extension "fzf" end,
    },

    ["rebelot/heirline.nvim"] = {
        event = "VimEnter",
        config = function() require "configs.heirline" end
    },

    ["xiyaowong/nvim-transparent"] = {
        config = function() require "configs.transparent" end,
    },

    ["ggandor/leap.nvim"] = {
        config = function() require "configs.leap" end,
    },
}
