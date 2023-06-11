-- ~/.dotfiles/nvim/lua/user/plugin_option/indent-blankline.lua

-- https://github.com/lukas-reineke/indent-blankline.nvim



------------------------------------------------------------------------------
-- Indent Blankline Plugin
------------------------------------------------------------------------------

-- Import Indent Blankline with a protected call:
local indent_blankline_status_ok, indent_blankline = pcall(require, 'indent_blankline')
if not indent_blankline_status_ok then
  return
end


------------------------------------------------------------
-- Appearance

indent_blankline.setup({
  char_highlight_list = {
    -- Call color variable:
    'IndentBlanklineChar',
  },
    filetype_exclude = {
    'help',
    'terminal',
    'dashboard',
    'packer',
    'lspinfo',
    'TelescopePrompt',
    'TelescopeResults',
  },
  buftype_exclude = {
    'terminal',
    'NvimTree',
  },
  show_trailing_blankline_indent = false,
  show_first_indent_level = true,
})
