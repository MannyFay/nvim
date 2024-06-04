-- Add this to your Packer plugins file:
-------------------------------------------------------------------------------
-- Guess Indent (set indentation because of the rest of a file)

-- use({
--   'nmac427/guess-indent.nvim',
--   config = function()
--     require('user.plugin_options.guess-indent')
--   end
-- })




-- https://github.com/NMAC427/guess-indent.nvim
-- https://github.com/Darazaki/indent-o-matic if guess indent is to slow!



------------------------------------------------------------------------------
-- Guess Indent Plugin
------------------------------------------------------------------------------

-- Import Guess Indent with a protected call:
local guess_indent_status_ok, guess_indent = pcall(require, 'guess-indent')
if not guess_indent_status_ok then
  return
end


------------------------------------------------------------
-- Appearance

guess_indent.setup({
  -- Enable automatic execution of plugin:
  auto_cmd = true,
  -- Don't overwrite settings of .editorconfig file:
  override_editorconfig = false,
  -- Filetypes where automatic execution of plugin is disabled:
  filetype_exclude = {
    'netrw',
    'tutor',
  },
  -- Buffer types where automatic execution of plugin is disabled:
  buftype_exclude = {
    'help',
    'nofile',
    'terminal',
    'prompt',
  },
})