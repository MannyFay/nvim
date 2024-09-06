-------------------------------------------------------------------------------
-- Copilot Plugin
-- https://github.com/zbirenbaum/copilot.lua
-------------------------------------------------------------------------------

return {
  "zbirenbaum/copilot.lua",
  cmd    = 'Copilot',
  event  = { "InsertEnter" },
  config = function()
    local copilot = require("copilot")


    ---------------------------------------------------------------------------
    ----- Settings

    copilot.setup({
      panel = {
        enabled      = true,
        auto_refresh = false,
        keymap = {
          jump_prev = '[[',
          jump_next = ']]',
          accept    = '<CR>',
          refresh   = 'gr',
          open      = '<M-CR>'
        },
        layout = {
          position = 'bottom',         -- top, left, right
          ratio    = 0.4
        },
      },
      suggestion = {
        enabled      = true,
        auto_trigger = true,
        debounce     = 75,             -- (milliseconds)
        keymap = {
          accept      = '<right>',     -- Right arrow key to accept suggestion.
          accept_word = false,
          accept_line = false,
          next        = '<M-]>',
          prev        = '<M-[>',
          dismiss     = '<C-]>',
        },
      },
      filetypes = {
        yaml       = true,
        markdown   = true,
        help       = false,
        gitcommit  = false,
        gitrebase  = false,
        hgcommit   = false,
        svn        = false,
        cvs        = false,
        html       = true,
        css        = true,
        javascript = true,
        typescript = true,
        php        = true,
        ['.']      = false,
      },
      copilot_node_command  = 'node',  -- Node.js version must be higher than 16.x.
      server_opts_overrides = {},


    })

  end,
}
