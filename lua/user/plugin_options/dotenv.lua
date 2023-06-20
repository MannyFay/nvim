-- ~/.dotfiles/nvim/lua/user/plugin_options/dotenv.lua

-- https://github.com/ellisonleao/dotenv.nvim



-------------------------------------------------------------------------------
-- Dotenv Pluging
-------------------------------------------------------------------------------

-- Import Dotenv plugin with a protected call:
local dotenv_status_ok, dotenv = pcall(require, 'dotenv')
if not dotenv_status_ok then
  return
end


------------------------------------------------------------
-- Appearance

dotenv.setup({
  -- Load .env if buffer gets opened:
  enable_on_load = true,
   -- Show error notification if .env file is not found and if .env is loaded:
  verbose = false,
})

