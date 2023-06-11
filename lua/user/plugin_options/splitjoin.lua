-- ~/.config/nvim/lua/user/plugins/plugin_options/splitjoin.lua

-- https://github.com/bennypowers/splitjoin.nvim



------------------------------------------------------------------------------
-- Splitjoin Plugin
------------------------------------------------------------------------------

 -- Import Splitjoin with a protected call:
local splitjoin_status_ok, splitjoin = pcall(require, 'splitjoin')
if not splitjoin_status_ok then
  return
end


------------------------------------------------------------
-- Appearance

splitjoin.setup({
  lazy = true,
  keys = {
    { '<Leader>jo', function() splitjoin.join() end, desc = 'Join the object under cursor' },
    { '<Leader>so,', function() splitjoin.split() end, desc = 'Split the object under cursor' },
  },
})

