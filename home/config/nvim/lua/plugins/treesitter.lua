-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "python",
      "javascript",
      "bash",
      "rust",
      "toml",
      "markdown",
      "yaml",
      "gitignore",
      "gitcommit",
      "gitattributes",
      "git_rebase",
      "git_config",
    },
  },
}
