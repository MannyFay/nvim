-- Insert this to your Packer plugins file:

-------------------------------------------------------------------------------
-- Which Key

-- use({
--   'folke/which-key.nvim',
--   config = function()
--     require('user.plugin_options.which-key')
--   end,
-- })



-------------------------------------------------------------------------------
-- WhichKey Plugin Options
-- https://github.com/folke/which-key.nvim
-- Display possible keybindings after pressing the leader key.
-------------------------------------------------------------------------------

-- Import WhichKey plugin with a protected call:
local whichkey_status_ok, whichkey = pcall(require, "which-key")
if not whichkey_status_ok then
  return "Error: Which-Key Plugin could not be loaded. Sure you have installed it in your plugins file?"
end

vim.o.timeout    = true  -- Turn on after timeout length is elapsed.
vim.o.timeoutlen = 500   -- Milliseconds till Which-Key waits to activate.



-------------------------------------------------------------------------------
-- Configuration

whichkey.setup {

}
