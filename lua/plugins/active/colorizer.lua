-------------------------------------------------------------------------------
--- Colorizer Plugin
--- https://github.com/norcalli/nvim-colorizer.lua
-------------------------------------------------------------------------------

return {
  "norcalli/nvim-colorizer.lua",
  event  = { "BufReadPre", "BufNewFile" },
  config = function()
    local colorizer = require('colorizer')


    -------------------------------------------------------------------------
    ----- Settings

    colorizer.setup({
      "!md",        -- Ignore highlighting in markdown files.
      "!markdown",  -- Ignore highlighting in markdown files.
      "!Lazy",      -- Ignore highlighting in lazy loaded buffers.
    })
  end,
}




