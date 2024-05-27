-- ~/.dotfiles/nvim/lua/user/plugin_options/nvim-lastplace.lua

-- https://github.com/ethanholz/nvim-lastplace



------------------------------------------------------------------------------
-- Neovim Lastplace Plugin
------------------------------------------------------------------------------

-- Import Nvim Lastplace with a protected call:
local nvim_lastplace_status_ok, nvim_lastplace = pcall(require, 'nvim-lastplace')
if not nvim_lastplace_status_ok then
  return
end


------------------------------------------------------------
-- Appearance

nvim_lastplace.setup({
  lastplace_ignore_buftype = {
    'quickfix',
    'nofile',
    'help'
  },
  lastplace_ignore_filetype = {
    'gitcommit',
    'gitrebase',
    'svn',
    'hgcommit'
  },
  lastplace_open_folds = true
})
