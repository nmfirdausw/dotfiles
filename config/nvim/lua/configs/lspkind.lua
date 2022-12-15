local lspkind_installed, lspkind = pcall(require, "lspkind")
if not lspkind_installed then return end

nik.lspkind = {
	mode = 'symbol_text',
	preset = 'codicons',
	symbol_map = {
        NONE = "",
        Array = "",
        Boolean = "⊨",
		Text = "",
		Method = "",
		Function = "",
        Constructor = "",
		Field = "ﰠ",
		Variable = "",
        Class = "",
		Interface = "",
		Module = "",
        Namespace = "",
        Null = "NULL",
        Property = "",
        Unit = "",
		Value = "",
		Enum = "",
		Keyword = "",
        Key = "",
        Snippet = "",
		Color = "",
		File = "",
        Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "פּ",
		Event = "",
		Operator = "",
        Object = "⦿",
		TypeParameter = " ",
        Package = "",
	},
}

lspkind.init(nik.lspkind)
