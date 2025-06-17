-------------------------------------------------------------------------------
-- Alternate Toggler Plugin
-- https://github.com/rmagatti/alternate-toggler
-- Toggle the current word based on a pre-defined map of alternatives.
-------------------------------------------------------------------------------

return {
  'rmagatti/alternate-toggler',
  event = { "BufReadPost" },
  config = function()
    local alternate_toggler = require('alternate-toggler')


    ---------------------------------------------------------------------------
    ----- Settings

    alternate_toggler.setup({
      ["true"] = "false",
      ["True"] = "False",
      ["TRUE"] = "FALSE",
      ["Yes"] = "No",
      ["YES"] = "NO",
      ["1"] = "0",
      ["<"] = ">",
      ["("] = ")",
      ["["] = "]",
      ["{"] = "}",
      ['"'] = "'",
      ['""'] = "''",
      ["+"] = "-",
      ["==="] = "!=="

    })
  end,

  vim.keymap.set('n', '<leader>at', '<cmd>ToggleAlternate<CR>', { noremap = true, silent = true })
}

