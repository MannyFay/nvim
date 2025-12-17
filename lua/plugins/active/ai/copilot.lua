-------------------------------------------------------------------------------
-- Copilot Plugin
-- https://github.com/zbirenbaum/copilot.lua
-- Code completion and suggestion engine.
-------------------------------------------------------------------------------

return {
  "zbirenbaum/copilot.lua",
  cmd    = 'Copilot',
  event  = { "InsertEnter" },
  config = function()
    local copilot = require("copilot")


    ---------------------------------------------------------------------------
    -- Settings

    copilot.setup({
      panel                 = {
        enabled      = true,
        auto_refresh = false,
        keymap       = {
          jump_prev = '[[',
          jump_next = ']]',
          accept    = '<CR>',
          refresh   = 'gr',
          open      = '<M-CR>'
        },
        layout       = {
          position = 'bottom', -- top, left, right
          ratio    = 0.4
        },
      },
      suggestion            = {
        enabled      = true,
        auto_trigger = true,
        debounce     = 75,     -- (Milliseconds) Delay before suggestions are shown.
        keymap       = {       -- Key mappings in insert mode (be careful which keys you choose - insert mode ;) ).
          accept  = '<right>', -- Right arrow key to accept suggestion.
          -- accept_word = '<leader>cw',  -- Leader + cw to accept word.
          -- accept_line = '<leader>cl',  -- Leader + cl to accept line.
          next    = '<down>', -- Down arrow key to show next suggestion.
          prev    = '<up>',   -- Up arrow key to show previous suggestion.
          dismiss = '<left>', -- Left arrow key to dismiss suggestion.
        },
      },
      filetypes             = {
        -- Enabled file types:
        css        = true,
        html       = true,
        javascript = true,
        lua        = true,
        markdown   = true,
        php        = true,
        typescript = true,
        yaml       = true,
        yml        = true,
        sh         = true,
        bash       = true,

        -- Disabled file types:
        cvs        = false,
        gitcommit  = false,
        gitrebase  = false,
        help       = false,
        hgcommit   = false,
        svn        = false,
        -- ['*']      = false,
      },
      copilot_node_command  = vim.fn.exepath("node"), -- Node.js version must be higher than 16.x.
      server_opts_overrides = nil,
    })
  end,
}
