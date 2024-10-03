-------------------------------------------------------------------------------
-- Copilot Plugin
-- https://github.com/zbirenbaum/copilot.lua
-- Code completion and suggestion engine
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
        debounce     = 75,             -- (Milliseconds) Delay before suggestions are shown.
        keymap = {                     -- Key mappings in insert mode (be careful which keys you choose - insert mode ;) ).
          accept      = '<right>',     -- Right arrow key to accept suggestion.
          -- accept_word = '<leader>cw',  -- Leader + cw to accept word.
          -- accept_line = '<leader>cl',  -- Leader + cl to accept line.
          next        = '<down>',      -- Down arrow key to show next suggestion.
          prev        = '<up>',        -- Up arrow key to show previous suggestion.
          dismiss     = '<left>',      -- Left arrow key to dismiss suggestion.
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

