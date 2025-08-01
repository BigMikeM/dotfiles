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
      local palette = colors.palette
      return {
        -- Custom rainbow delimiters support: (only set up for wave)
        -- Colors listed in order by of use, e.g. the first color is the outermost delimiter and so on
        RainbowDelimiterRed = { fg = palette.springViolet2 },
        RainbowDelimiterYellow = { fg = palette.waveAqua1 },
        RainbowDelimiterBlue = { fg = palette.waveRed },
        RainbowDelimiterOrange = { fg = palette.autumnYellow },
        RainbowDelimiterGreen = { fg = palette.dragonBlue },
        RainbowDelimiterViolet = { fg = palette.lightBlue },
        RainbowDelimiterCyan = { fg = palette.boatYellow2 },
      }
    end,
  },
}
