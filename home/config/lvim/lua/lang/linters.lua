-- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		command = "shellcheck",
		filetypes = { "shell", "bash", "zsh", "sh" },
	},
	{ command = "pylint" },
	{ command = "taplo" },
	{ command = "yamllint" },
  { command = "luacheck"}
})
