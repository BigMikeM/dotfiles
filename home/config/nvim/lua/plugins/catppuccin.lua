return {
  { -- further customize the options set by the community
    "catppuccin",
    opts = {
      flavour = "macchiato",
      integrations = {
        -- Core integrations
        alpha = true,
        cmp = true,
        dashboard = true,
        gitsigns = true,
        indent_blankline = { enabled = true },
        markdown = true,
        mason = true,
        mini = { enabled = true },
        neotree = true,
        neotest = true,
        notify = true,
        nvimtree = true,
        overseer = true,
        semantic_tokens = true,
        telescope = { enabled = true },
        treesitter = true,
        treesitter_context = true,
        ufo = true,
        which_key = true,

        -- LSP & Diagnostics
        lsp_trouble = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },

        noice = true,
        flash = true,
        render_markdown = true,
        rainbow_delimiters = true,
        window_picker = true,

        -- Copilot
        copilot_vim = true,
        copilot_cmp = true,
      },
    },
  },
}
