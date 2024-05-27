------------------------------------------------------------------------------
-- Peek Markdown Preview Plugin
-- https://github.com/toppair/peek.nvim
------------------------------------------------------------------------------


-- Import Peek plugin with a protected call:
local peek_status_ok, peek = pcall(require, 'peek')
if not peek_status_ok then
  return "Error: */lua/user/plugin_options/peek.lua -> Peek plugin could not be loaded. Sure you have installed it in your plugins file?"
end


------------------------------------------------------------
-- Appearance

peek.setup({
  auto_load        = true,       -- Automatically open preview on entering markdown buffer.
  close_on_bdelete = true,       -- Close preview by closing buffer.
  syntax           = true,       -- Enable syntax highlighting (affects performance).
  theme            = 'dark',     -- Set theme of the preview (light, dark).
  update_on_change = true,       -- Update preview on text change.
  app              = 'browser',  -- Place to open preview (webview, browser):

  -- File types to recognize as markdown:
  filetype = {
    'markdown',
    'md',
  },

  -- Preview update behavior:
  throttle_at   = 200000,        -- (bytes) Start throttling when file exceeds this amount of size.
  throttle_time = 'auto',        -- (milliseconds) Throttle time before starting new render.
})


--------------------------------------------------------------
-- Commands for command line

vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})


--------------------------------------------------------------
-- Key Mappings

local options = { noremap = true, silent = true }

vim.keymap.set('n', '<Leader>mdo', ':PeekOpen<CR>', options)
vim.keymap.set('n', '<Leader>mdq', ':PeekClose<CR>', options)


-- Preview window commands (has to be focused):
-- k = scroll up
-- j = scroll down
-- u = scroll half page up
-- d = scroll half page down
-- g = scroll to top
-- G = scroll to bottom
