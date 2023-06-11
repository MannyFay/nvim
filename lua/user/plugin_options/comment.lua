-- ~/.dotfiles/nvim/lua/user/plugin_options/comment.lua

-- https://github.com/numtostr/comment.nvim



------------------------------------------------------------------------------
-- Comment Plugin
------------------------------------------------------------------------------

-- Import Comment plugin with a protected call:
local comment_status_ok, comment = pcall(require, 'Comment')
if not comment_status_ok then
  return
end


------------------------------------------------------------
-- Appearance

comment.setup({
  -- Put [[ before and ]] after the content of the Lua comment:
  pre_hook = function(ctx)
    local U = require 'Comment.utils'
    local location = nil

    if ctx.ctype == U.ctype.block then
      location = require('ts_context_commentstring.utils').get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require('ts_context_commentstring.utils').get_visual_start_location()
    end

    return require('ts_context_commentstring.internal').calculate_commentstring {
      key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
      location = location,
    }
  end,
  -- Add a space after and before the comment symbol:
  padding = true,
  -- Stay with cursor on it's position if commenting stuff:
  sticky = true,
  -- Ignore empty lines while (un)comment:
  ignore = '^%s*$',
  -- Mappings (normal mode):
  toggler = {
    -- Line-comment:
    line = '<Leader>/',
    -- Block-comment:
    block = '<Nop>'
  },
  -- Operator-pending mappings (normal and visual mode):
  opleader = {
    -- Line-comment:
    line = '<Leader>/',
    -- Block-comment:
    block = '<Nop>',
  },
  -- Extra mappings:
  extra = {
    -- Add comment on the line above:
    above = '<Nop>',
    -- Add comment on the line below:
    below = '<Nop>',
    -- Add comment at the end of line:
    eol = '<Nop>',
  },
  -- Enable keybindings (if 'false', it won't create any mappings!):
  mappings = {
    -- Enable operator-pending mappings:
    basic = true,
    -- Enable extra mappings:
    extra = false,
  },
  -- Function to call before (un)comment:
  -- pre_hook = nil,
  -- Function to call after (un)comment:
  post_hook = nil,
})
