-- ~/.dotfiles/nvim/lua/user/plugin_options/null-ls.lua

-- https://github.com/jose-elias-alvarez/null-ls.nvim



-------------------------------------------------------------------------------
-- Null-LS Plugin
-------------------------------------------------------------------------------

-- Import Null-LS plugin safely:
local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
  return
end



------------------------------------------------------------
-- Appearance

null_ls.setup({
  --[[ sources = { ]]
  --[[    ]]
  --[[ } ]]




})
