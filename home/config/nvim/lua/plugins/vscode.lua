-- Conditional plugin loading for VSCode Neovim
-- Disable plugins that conflict with or are redundant in VSCode

if not vim.g.vscode then
  return {}
end

---@type LazySpec
return {
  -- Disable UI plugins (VSCode handles UI)
  { "akinsho/toggleterm.nvim", enabled = false },
  { "stevearc/dressing.nvim", enabled = false },
  { "rcarriga/nvim-notify", enabled = false },
  { "folke/noice.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "rebelot/heirline.nvim", enabled = false },
  { "b0o/incline.nvim", enabled = false },

  -- Disable colorschemes (VSCode handles themes)
  { "catppuccin/nvim", enabled = false },
  { "rebelot/kanagawa.nvim", enabled = false },

  -- Disable window/split management (VSCode handles this)
  { "nvim-zh/colorful-winsep.nvim", enabled = false },
  { "anuvyklack/windows.nvim", enabled = false },
  { "folke/edgy.nvim", enabled = false },

  -- Disable file explorers (VSCode has its own)
  { "nvim-tree/nvim-tree.lua", enabled = false },
  { "stevearc/oil.nvim", enabled = false },

  -- Disable git UI (VSCode has excellent git integration)
  { "lewis6991/gitsigns.nvim", enabled = false },
  { "NeogitOrg/neogit", enabled = false },
  { "sindrets/diffview.nvim", enabled = false },

  -- Disable Telescope (VSCode has quick open/search)
  { "nvim-telescope/telescope.nvim", enabled = false },

  -- Disable LSP UI enhancements (VSCode handles this)
  { "folke/trouble.nvim", enabled = false },
  { "j-hui/fidget.nvim", enabled = false },

  -- Disable dashboard/alpha (not needed in VSCode)
  { "goolord/alpha-nvim", enabled = false },
  { "nvimdev/dashboard-nvim", enabled = false },

  -- Disable indent guides (VSCode has this)
  { "lukas-reineke/indent-blankline.nvim", enabled = false },

  -- Keep these enabled - they enhance editing
  -- { "nvim-treesitter/nvim-treesitter", enabled = true }, -- Syntax highlighting
  -- { "echasnovski/mini.surround", enabled = true }, -- Surround operations
  -- { "numToStr/Comment.nvim", enabled = true }, -- Better comments
  -- { "windwp/nvim-autopairs", enabled = true }, -- Auto pairs
  -- { "folke/flash.nvim", enabled = true }, -- Enhanced motions
  -- { "folke/which-key.nvim", enabled = true }, -- Keybinding help
}
