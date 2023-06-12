-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		command = "shellharden",
		filetypes = { "shell", "bash", "zsh", "sh" },
	},
	{ command = "markdownlint" },
	{ command = "stylua", filetypes = { "lua" } },
	{ command = "black" },
})

lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py", "*.lua" }
