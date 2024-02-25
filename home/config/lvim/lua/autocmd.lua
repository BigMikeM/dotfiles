vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.json", "*.jsonc", "*.md" },
	command = "setlocal wrap",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "zsh",
	callback = function()
		-- let treesitter use bash highlight for zsh files as well
		require("nvim-treesitter.highlight").attach(0, "bash")
	end,
})
