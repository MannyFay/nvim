--  This plugin is archived on GitHub.

-- Add this to your Packer plugins file:
-------------------------------------------------------------------------------
-- Null-LS (linter)

-- use({
--   'jose-elias-alvarez/null-ls.nvim',
--   requires = 'nvim-lua/plenary.nvim',
--   config = function()
--     require('user.plugin_options.null-ls')
--   end,
-- })



-------------------------------------------------------------------------------
-- Null-LS Plugin
-- https://github.com/jose-elias-alvarez/null-ls.nvim
-------------------------------------------------------------------------------

-- Import Null-LS plugin safely:
local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
  return
end



-------------------------------------------------------------------------------
-- Appearance

null_ls.setup({
  -- sources = {}
})