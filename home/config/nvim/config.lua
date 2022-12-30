-- doom_config - Doom Nvim user configurations file

doom.use_package("rebelot/kanagawa.nvim", "sainnhe/sonokai", "sainnhe/edge")
doom.use_package({
  "ur4ltz/surround.nvim",
  config = function()
    require("surround").setup({ mappings_style = "sandwich" })
  end,
}, {
  "catppuccin/nvim",
  as = "catppuccin",
  config = function()
    require("catppuccin").setup({
      flavor = "latte",
      integrations = {
        notify = true,
        mini = true,
        ts_rainbow = true,
        dap = true,
        cmp = true,
        markdown = true,
        telescope = true,
        neogit = true,
        nvimtree = true,
        hop = true,
        gitsigns = true,
      },
    })
  end,
})

doom.preserve_edit_pos = true
doom.smartcase = true
doom.max_columns = 80
doom.colorscheme = "kanagawa"

vim.o.cmdheight = 1
vim.g.edge_style = "aura"
vim.g.edge_enable_italic = 1
vim.g.edge_show_eob = 0
vim.o.guifont = "MonoLisa Nerd Font:h10:#e-subpixelantialias"
vim.g.neovide_scale_factor = 0.8
vim.g.neovide_refresh_rate = 165
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0

doom.use_autocmd({
  "FileType",
  "zsh",
  function()
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})

doom.indent = 2
doom.core.treesitter.settings.show_compiler_warning_message = false
doom.core.reloader.settings.reload_on_save = false

-- vim: sw=2 sts=2 ts=2 expandtab
