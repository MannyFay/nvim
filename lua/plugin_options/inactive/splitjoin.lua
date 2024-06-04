-- Cut this and add it to your Packer plugins file:
-------------------------------------------------------------------------------
-- SplitJoin (split or join list-like syntax constructs (like arrays))

-- use({
--   'bennypowers/splitjoin.nvim',
--   config = function()
--     require('user.plugin_options.splitjoin')
--   end
-- })





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
