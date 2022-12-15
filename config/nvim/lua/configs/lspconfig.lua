local lspconfig_installed, lspconfig = pcall(require, "lspconfig")
if not lspconfig_installed then return end

local navic_installed, navic = pcall(require, "nvim-navic")
if not navic_installed then return end

local signs = {
    { name = "DiagnosticSignError", text = nik.get_icon "DiagnosticError" },
    { name = "DiagnosticSignWarn", text = nik.get_icon "DiagnosticWarn" },
    { name = "DiagnosticSignHint", text = nik.get_icon "DiagnosticHint" },
    { name = "DiagnosticSignInfo", text = nik.get_icon "DiagnosticInfo" },
    { name = "DiagnosticSignError", text = nik.get_icon "DiagnosticError" },
}

for _, sign in ipairs(signs) do
    if not sign.texthl then sign.texthl = sign.name end
    vim.fn.sign_define(sign.name, sign)
end

local on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
  	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

lspconfig.sumneko_lua.setup {
    on_attach = on_attach;
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
		    diagnostics = {
			    globals = {'vim'},
		    },
		    workspace = {
			    library = vim.api.nvim_get_runtime_file("", true),
		    },
		    telemetry = {
			    enable = false,
		    },
	    },
	},
}

lspconfig.intelephense.setup {
    on_attach = on_attach;
    settings = {
        intelephense = {
            diagnostics = {
                undefinedTypes = false,
                undefinedFunctions = false,
                undefinedConstants = false,
                undefinedClassConstants = false,
                undefinedMethods = false,
                undefinedProperties = false,
                undefinedVariables = false,
            },
        },
    },
}

lspconfig.tailwindcss.setup {}

lspconfig.tsserver.setup {}
