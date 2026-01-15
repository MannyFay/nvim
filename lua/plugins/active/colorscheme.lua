-------------------------------------------------------------------------------
-- MannyDark Color Scheme
-- https://github.com/MannyFay/mannydark.nvim
-------------------------------------------------------------------------------

return {
  "MannyFay/mannydark.nvim",
  ---------------------------------------
  -- Uncomment this if you are working on the scheme locally:
  dev = true,  -- Loads local dev.path instead of Git remote.
  lazy = false,
  ---------------------------------------
  -- Comment out if you are working on the scheme locally:
  -- branch = "main",
  ---------------------------------------
  priority = 1000, -- Load color scheme before loading anything else.
  config = function()
    require("mannydark").setup({
      -- Style: "dark" | "bright" | "red-green-dark" | "red-green-bright"
      style = "dark",
      -- Transparent background
      transparent = false,
      -- Dim inactive windows
      dim_inactive = false,
      -- Apply colors to :terminal
      terminal_colors = true,
      -- Per-element styling
      styles = {
        comments  = { italic = false, bold = false },
        keywords  = {},
        functions = {},
        variables = {},
        strings   = {},
        types     = {},
      },
      -- Override colors: function(colors) colors.blue = "#0000FF" end
      on_colors = nil,
      -- Override highlights: function(hl, colors) hl.Normal = { fg = colors.white } end
      on_highlights = nil,
    })
  end,
}

