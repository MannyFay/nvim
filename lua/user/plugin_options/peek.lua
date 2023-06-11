-- ~/.dotfiles/nvim/lua/user/plugin_options/peek.lua

-- https://github.com/toppair/peek.nvim



------------------------------------------------------------------------------
-- Peek Plugin
------------------------------------------------------------------------------

-- Import Peek plugin with a protected call:
local peek_status_ok, peek = pcall(require, 'peek')
if not peek_status_ok then
  return
end


------------------------------------------------------------
-- Appearance

peek.setup({
  -- Automatically open preview:
  auto_load = true,
  -- Close preview by closing buffer:
  close_on_bdelete = true,
  -- Enable syntax highlighting (affects performance):
  syntax = true,
  -- Set theme of the preview (light, dark):
  theme = 'dark',
  update_on_change = true,
  -- Place to open preview (webview, browser):
  app = 'browser',
  -- File types to recognize as markdown:
  filetype = {
    'markdown',
    'md',
  },
  -- relevant if update_on_change is true
  -- start throttling when file exceeds this amount of bytes in size
  throttle_at = 200000,
  throttle_time = 'auto',
})

-- Create commands for toggeling Peek in command line:
vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})

--------------------------------------------------------------
-- Key Mappings

-- Don't show command message in command line:
local options = { noremap = true, silent = true }

vim.keymap.set('n', '<Leader>mdo', ':PeekOpen<CR>', options)
vim.keymap.set('n', '<Leader>mdq', ':PeekClose<CR>', options)

