-- ~/.dotfiles/nvim/lua/user/plugin_options/lion.lua

-- https://github.com/tommcdo/vim-lion



------------------------------------------------------------------------------
-- Vim Lion Plugin
------------------------------------------------------------------------------


------------------------------------------------------------
-- Appearance

-- Remove as many spaces as possible when aligning
vim.g.lion_squeeze_spaces = 1


------------------------------------------------------------
-- Key Mappings

-- Align on the left of the alignment character:
vim.api.nvim_set_keymap('n', '<Leader>al', '<Plug>(lion-right-align-operator)', { silent = true })

-- Align on the right of the alignment character:
vim.api.nvim_set_keymap('n', '<Leader>ar', '<Plug>(lion-left-align-operator)', { silent = true })

