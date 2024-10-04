-------------------------------------------------------------------------------
-- Treesitter-Auto-Tag Plugin
-- https://github.com/windwp/nvim-ts-autotag
-- Use treesitter to auto-close and auto-rename html tags.
-------------------------------------------------------------------------------

return {
  "windwp/nvim-ts-autotag",
  config = function()
    local ts_autotag = require('nvim-ts-autotag')

    ts_autotag.setup({
      opts = {
        enable_close          = true,  -- Auto close tags
        enable_rename         = true,  -- Auto rename pairs of tags
        enable_close_on_slash = true,  -- Auto close on trailing </
      },
      -- Also override individual filetype configs, these take priority.
      -- Empty by default, useful if one of the "opts" global settings
      -- doesn't work well in a specific filetype
      -- per_filetype = {
      --   ["html"] = {
      --     enable_close = false
      --   }
      -- }
    })
  end,
}

