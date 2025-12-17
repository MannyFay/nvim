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
    vim.cmd("colorscheme mannydark")
  end,
}

