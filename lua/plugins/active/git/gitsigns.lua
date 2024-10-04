-------------------------------------------------------------------------------
-- Git-Signs Plugin
-- https://github.com/lewis6991/gitsigns.nvim
-- Git integration for buffers.
-------------------------------------------------------------------------------

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local gitsigns = require("gitsigns")


    ---------------------------------------------------------------------------
    --- Settings

    gitsigns.setup({
      signs = {
        add          = { text = '▎',  },
        change       = { text = '▎',  },
        delete       = { text = ' ', },
        topdelete    = { text = ' ', },
        changedelete = { text = '▎',  },
        untracked    = { text = '┆'   },
      },
      signs_staged = {
        add          = { text = '▎',  },
        change       = { text = '▎',  },
        delete       = { text = ' ', },
        topdelete    = { text = ' ', },
        changedelete = { text = '▎',  },
        untracked    = { text = '┆'   },
      },
      -- signs_staged_enabled = true,                                              -- Enable Gitsigns for staged changes.
      signcolumn           = true,                                              -- Create Gitsigns column before line numbers.
      numhl                = false,                                             -- Disable highlighting of line numbers affected by Gitsigns.
      linehl               = false,                                             -- Disable highlighting of current line if it contains Gitsigns.
      word_diff            = false,                                             -- Disable highlighting of word level changes.
      watch_gitdir         = {                                                  -- Watch the Git directory for changes.
        interval     = 1000,
        follow_files = true,
      },
      auto_attach             = true,                                           -- Enable Gitsigns for all buffers.
      attach_to_untracked     = true,                                           -- Enable Gitsigns for untracked files too.
      current_line_blame      = true,                                           -- Blame information for current line.
      current_line_blame_opts = {                                               -- Git-Blame options for current line.
        virt_text         = true,                                               -- Enable displaying virtual text for blame information.
        virt_text_pos     = 'eol',                                              -- Position of blame information (possible: eol, overlay, right_align).
        delay             = 10,                                                 -- Milliseconds before displaying blame information.
        ignore_whitespace = false,                                              -- Don't ignore change of white spaces for blame.
        use_focus         = true,                                               -- Use focus mode for blame information.
      },
      current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',  -- Format of the blame information.
      sign_priority    = 6,                                                     -- Priority of Gitsigns against other signs.
      update_debounce  = 100,                                                   -- Refresh interval of Gitsigns in milliseconds.
      status_formatter = nil,                                                   -- Use the default built-in status formatter.
      max_file_length  = 40000,                                                 -- Maximum file size where Gitsigns will be displayed in lines.
      preview_config   = {                                                      -- Appearance of the preview window (options passed to nvim_open_win).
        border   = 'single',
        style    = 'minimal',
        relative = 'cursor',
        row      = 0,
        col      = 1,
      },
    })


    ---------------------------------------------------------------------------
    --- Key Mappings

    vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", {})                -- Preview hunk (the part before the change).
    vim.keymap.set("n", "<leader>gb", ":Gitsigns blame<CR>", {})                       -- Preview file blame in buffer.
    vim.keymap.set("n", "<leader>glb", ":Gitsigns toggle_current_line_blame<CR>", {})  -- Show blame information.

  end,
}

