-- ~/.dotfiles/nvim/lua/user/plugin_options/vim-pasta.lua

-- https://github.com/sickill/vim-pasta



------------------------------------------------------------------------------
-- Vim Pasta Plugin
------------------------------------------------------------------------------

------------------------------------------------------------
-- Appearance

-- Disabled file types:
vim.g.pasta_disabled_filetype = {
  'fugitive',
  'nerdtree',
  'python',
  'coffee',
  'markdown',
  'yaml',
  'slim',
  'netrw',
  'startify',
  'ctrllp',
}

-- Enabled file types (if empty, all not disabled are enabled):
vim.g.pasta_enabled_filetype = { '' }


------------------------------------------------------------
-- Key Mappings

local opts = { noremap = true, silent = true }

--[[ vim.g.pasta_paste_before_mapping = ',P' ]]
-- vim.g.vim_pasta_after_mapping = 'p'

vim.api.nvim_set_keymap('n', 'p', '"_dP', opts)
vim.api.nvim_set_keymap('x', 'p', '"_dP', opts)
vim.api.nvim_set_keymap('v', 'p', '"_dP', opts)


