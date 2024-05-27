-- ~/.dotfiles/nvim/lua/user/plugin_options/comment.lua

-- https://github.com/numtostr/comment.nvim



------------------------------------------------------------------------------
-- Comment Plugin
------------------------------------------------------------------------------

-- Import Comment plugin with a protected call:
local comment_status_ok, comment = pcall(require, 'Comment')
if not comment_status_ok then
  return "Error: */lua/user/plugin_options/comment.lua -> Comment plugin could not be loaded. Sure you have installed it in your plugins file?"
end


------------------------------------------------------------
-- Appearance

comment.setup({
  padding = true,         -- Add a space after and before the comment symbol.
  sticky  = true,         -- Stay with cursor on it's position if commenting stuff.
  ignore  = '^%s*$',      -- Ignore empty lines while (un)comment.
  -- Mappings (normal mode):
  toggler = {
    line  = '<Leader>/',  -- Command for line-comment.
    block = '<Nop>'       -- Command for block-comment (<Nop> = no command).
  },
  -- Operator-pending mappings (normal and visual mode):
  opleader = {
    line  = '<Leader>/',  -- Command for Line-comment.
    block = '<Leader>/s', -- Command for block-comment.
  },
  -- Extra mappings:
  extra = {
    above = '<Nop>',      -- Add comment on the line above (<Nop> = no command).
    below = '<Nop>',      -- Add comment on the line below (<Nop> = no command).
    eol   = '<Nop>',      -- Add comment at the end of line (<Nop> = no command).
  },
  -- Enable keybindings (if 'false', it won't create any mappings!):
  mappings = {
    basic = true,         -- Enable operator-pending mappings.
    extra = false,        -- Enable extra mappings.
  },
  -- pre_hook = nil,      -- Function to call before (un)comment.
  post_hook = nil,        -- Function to call after (un)comment.
})
