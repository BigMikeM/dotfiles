return {
  "kanagawa.nvim",
  opts = {
    compile = true,
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = "none",
          },
        },
      },
    },
    overrides = function(colors)
      local theme = colors.theme
      local palette = colors.palette

      return {
        -- Rainbow delimiters (custom colors for wave theme)
        RainbowDelimiterRed = { fg = palette.springViolet2 },
        RainbowDelimiterYellow = { fg = palette.waveAqua1 },
        RainbowDelimiterBlue = { fg = palette.waveRed },
        RainbowDelimiterOrange = { fg = palette.autumnYellow },
        RainbowDelimiterGreen = { fg = palette.dragonBlue },
        RainbowDelimiterViolet = { fg = palette.lightBlue },
        RainbowDelimiterCyan = { fg = palette.boatYellow2 },

        -- Telescope
        TelescopeTitle = { fg = theme.ui.special, bold = true },
        TelescopePromptNormal = { bg = theme.ui.bg_p1 },
        TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
        TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
        TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
        TelescopePreviewNormal = { bg = theme.ui.bg_dim },
        TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

        -- Noice
        NoicePopup = { bg = theme.ui.bg_p1 },
        NoicePopupmenu = { bg = theme.ui.bg_p1 },
        NoicePopupmenuBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
        NoiceCmdlinePopup = { bg = theme.ui.bg_p1 },
        NoiceCmdlinePopupBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
        NoiceCmdlineIcon = { fg = palette.springViolet2 },
        NoiceConfirm = { bg = theme.ui.bg_p1 },
        NoiceConfirmBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },

        -- Flash (motion highlighting)
        FlashBackdrop = { fg = theme.ui.nontext },
        FlashLabel = { bg = palette.autumnRed, fg = theme.ui.bg, bold = true },
        FlashMatch = { bg = palette.waveAqua2, fg = theme.ui.bg },
        FlashCurrent = { bg = palette.springViolet2, fg = theme.ui.bg },

        -- Indent Blankline
        IblIndent = { fg = theme.ui.whitespace },
        IblScope = { fg = palette.springViolet2 },

        -- NeoTree
        NeoTreeNormal = { bg = theme.ui.bg_dim },
        NeoTreeNormalNC = { bg = theme.ui.bg_dim },
        NeoTreeDirectoryIcon = { fg = palette.springBlue },
        NeoTreeGitModified = { fg = palette.autumnYellow },
        NeoTreeGitAdded = { fg = palette.autumnGreen },
        NeoTreeGitDeleted = { fg = palette.autumnRed },

        -- Mini (mini.surround, etc.)
        MiniSurroundInput = { bg = palette.winterYellow, fg = theme.ui.bg },

        -- Which-key
        WhichKey = { fg = palette.springViolet2 },
        WhichKeyGroup = { fg = palette.springBlue },
        WhichKeyDesc = { fg = palette.springGreen },
        WhichKeySeparator = { fg = theme.ui.nontext },
        WhichKeyFloat = { bg = theme.ui.bg_p1 },

        -- Notify
        NotifyBackground = { bg = theme.ui.bg_dim },
        NotifyERRORBorder = { fg = palette.autumnRed },
        NotifyWARNBorder = { fg = palette.autumnYellow },
        NotifyINFOBorder = { fg = palette.springBlue },
        NotifyDEBUGBorder = { fg = theme.ui.nontext },
        NotifyTRACEBorder = { fg = palette.springViolet2 },

        -- LSP
        DiagnosticVirtualTextError = { bg = "none", fg = palette.autumnRed },
        DiagnosticVirtualTextWarn = { bg = "none", fg = palette.autumnYellow },
        DiagnosticVirtualTextInfo = { bg = "none", fg = palette.springBlue },
        DiagnosticVirtualTextHint = { bg = "none", fg = palette.dragonBlue },

        -- Copilot
        CopilotSuggestion = { fg = theme.ui.nontext, italic = true },
        CopilotAnnotation = { fg = theme.ui.nontext, italic = true },

        -- Render Markdown
        RenderMarkdownCode = { bg = theme.ui.bg_p1 },
        RenderMarkdownCodeInline = { bg = theme.ui.bg_p1 },
        RenderMarkdownH1Bg = { bg = theme.ui.bg_p1 },
        RenderMarkdownH2Bg = { bg = theme.ui.bg_p1 },

        -- Edgy (window management)
        EdgyNormal = { bg = theme.ui.bg_dim },
        EdgyTitle = { fg = palette.springViolet2, bold = true },

        -- Mason
        MasonNormal = { bg = theme.ui.bg_dim },
        MasonHeader = { bg = palette.springViolet2, fg = theme.ui.bg, bold = true },
        MasonHighlight = { fg = palette.springBlue },
        MasonHighlightBlock = { bg = palette.springBlue, fg = theme.ui.bg },
        MasonMuted = { fg = theme.ui.nontext },
      }
    end,
  },
}
