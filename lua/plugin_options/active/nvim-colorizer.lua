-- ~/.dotfiles/nvim/lua/user/nvim-colorizer.lua

-- https://github.com/norcalli/nvim-colorizer.lua



-------------------------------------------------------------------------------
-- Nvim Colorizer Plugin
-------------------------------------------------------------------------------

-- Import nvim-colorizer plugin safely:
local colorizer_status, colorizer = pcall(require, 'colorizer')
if not colorizer_status then
  return
end

-- Attaches to every FileType mode:
-- require 'colorizer'.setup()


------------------------------------------------------------
-- Appearance

-- Run colorizer on every buffer:
vim.cmd([[
  augroup Colorizer
    autocmd!
    autocmd BufEnter * ColorizerAttachToBuffer
  augroup END
]])

colorizer.setup({
  -- Enable highlighting in all file types:
  '*';
})
