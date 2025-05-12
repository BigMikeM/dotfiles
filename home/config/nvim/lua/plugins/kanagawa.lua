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
      -- local theme = colors.theme
      local palette = colors.palette
      return {
        -- Borderless Telescope UI:
        -- TelescopeTitle = { fg = theme.ui.special, bold = true },
        -- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
        -- TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
        -- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
        -- TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
        -- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
        -- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
        -- Custom rainbow delimiters support: (only set up for wave)
        -- Colors listed in order by of use, e.g. the first color is the outermost delimiter and so on
        RainbowDelimiterRed = { fg = palette.springViolet2 },
        RainbowDelimiterYellow = { fg = palette.waveAqua1 },
        RainbowDelimiterBlue = { fg = palette.waveRed },
        RainbowDelimiterOrange = { fg = palette.autumnYellow },
        RainbowDelimiterGreen = { fg = palette.dragonBlue },
        RainbowDelimiterViolet = { fg = palette.lightBlue },
        RainbowDelimiterCyan = { fg = palette.boatYellow2 },
        -- -- Darker background for popups to contrast with editor view
        -- Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
        -- PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
        -- PmenuSbar = { bg = theme.ui.bg_m1 },
        -- PmenuThumb = { bg = theme.ui.bg_p2 },
      }
    end,
  },
}
