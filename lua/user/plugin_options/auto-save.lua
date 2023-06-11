-- ~/.dotfiles/nvim/lua/user/plugin_options/auto-save.lua

-- https://github.com/Pocco81/auto-save.nvim



-------------------------------------------------------------------------------
-- Auto-Save Pluging
-------------------------------------------------------------------------------

-- Import Auto-Save plugin with a protected call:
local auto_save_status_ok, auto_save = pcall(require, 'auto-save')
if not auto_save_status_ok then
  return
end


------------------------------------------------------------
-- Appearance

auto_save.setup {

}
