-- ~/.dotfiles/nvim/lua/user/plugin_options/gitsigns.lua

-- https://github.com/lewis6991/gitsigns.nvim



------------------------------------------------------------------------------
-- Gitsigns Plugin
------------------------------------------------------------------------------

-- Import Gitsigns plugin with a protected call:
local gitsigns_status_ok, gitsigns = pcall(require, 'gitsigns')
if not gitsigns_status_ok then
  return
end


------------------------------------------------------------
-- Appearance

gitsigns.setup {
  signs = {
    add = {
      hl     = 'GitSignsAdd',
      text   = '▎',
      numhl  = 'GitSignsAddNr',
      linehl = 'GitSignsAddLn',
    },
    change = {
      hl     = 'GitSignsChange',
      text   = '▎',
      numhl  = 'GitSignsChangeNr',
      linehl = 'GitSignsChangeLn',
    },
    delete = {
      hl     = 'GitSignsDelete',
      text   = ' ',
      numhl  = 'GitSignsDeleteNr',
      linehl = 'GitSignsDeleteLn',
    },
    topdelete = {
      hl     = 'GitSignsDelete',
      text   = ' ',
      numhl  = 'GitSignsDeleteNr',
      linehl = 'GitSignsDeleteLn',
    },
    changedelete = {
      hl     = 'GitSignsChange',
      text   = '▎',
      numhl  = 'GitSignsChangeNr',
      linehl = 'GitSignsChangeLn',
    },
  },
  -- Create Gitsigns column before line numbers:
  signcolumn = true,
  -- Disable highlighting of line numbers affected by Gitsigns:
  numhl = false,
  -- Disable highlighting of current line if it contains Gitsigns:
  linehl = false,
  -- Disable highlighting of word level changes:
  word_diff = false,
  -- Watch the Git directory for changes:
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  -- Enable Gitsigns for untracked files too:
  attach_to_untracked = true,
  -- Disable Git-Blame information for current line:
  current_line_blame = false,
  current_line_blame_opts = {
    -- Enable displaying virtual text for blame information:
    virt_text = true,
    -- Position of blame information (possible: eol, overlay, right_align):
    virt_text_pos = 'eol',
    -- Milliseconds before displaying blame information:
    delay = 500,
    -- Don't ignore change of white spaces for blame:
    ignore_whitespace = false,
  },
  -- Formatting of blame information:
  current_line_blame_formatter_opts = {
    -- Display time stamps as absolute time (not '2 days ago'):
    relative_time = false,
  },
  -- Priority of Gitsigns against other signs:
  sign_priority = 6,
  -- Refresh interval of Gitsigns in milliseconds:
  update_debounce = 100,
  -- Use the default built-in status formatter:
  status_formatter = nil,
  -- Maximum file size where Gitsigns will be displayed in bytes:
  max_file_length = 40000,
  -- Appearance of the preview window (options passed to nvim_open_win:
  preview_config = {
    border   = 'single',
    style    = 'minimal',
    relative = 'cursor',
    row      = 0,
    col      = 1,
  },
  -- Disable integration with YADM (Yet Another Dotfiles Manager):
  yadm = {
    enable = false,
  },
}
