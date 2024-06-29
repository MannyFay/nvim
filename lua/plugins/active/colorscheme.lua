-------------------------------------------------------------------------------
-- MannyDark Color Scheme
-- https://github.com/MannyFay/mannydark.nvim
-------------------------------------------------------------------------------

return {
  "MannyFay/mannydark.nvim",
  branch = "main",
  priority = 1000, -- Load color scheme before loading anything else.
  config = function()
    vim.cmd("colorscheme mannydark")
  end,
}

-------------------------------------------------------------------------------
-- Appearance
