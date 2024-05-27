-- Insert this to your Packer plugins file:

-------------------------------------------------------------------------------
-- Hop

-- use({
--   'phaazon/hop.nvim',
--   config = function()
--     require('user.plugin_options.hop')
--   end,
-- })

-- ~/.dotfiles/nvim/lua/user/plugin_options/hop.lua




-------------------------------------------------------------------------------
-- Hop Plugin
-- https://github.com/phaazon/hop.nvim
-- Fast motions with visual feedback.
-------------------------------------------------------------------------------

-- Import Hop plugin with a protected call:
local hop_status_ok, hop = pcall(require, 'hop')
if not hop_status_ok then
  return "Error: Hop plugin could not be loaded. Sure you have installed it in your plugins file?"
end


-------------------------------------------------------------------------------
-- Appearance

hop.setup {
  multi_windows = true,  -- Enable Hop for multi buffer use.
}


-------------------------------------------------------------------------------
-- Key Mappings

-- Hop to character in (multiple) buffer:
vim.api.nvim_set_keymap(
    "n", "<Leader>c", ":HopChar1MW<CR>",
    { noremap = false, silent = true }
)

-- Hop to word in (multiple) buffer:
vim.api.nvim_set_keymap(
    "n", "<Leader>w", ":HopWordMW<CR>",
    { noremap = false, silent = true }
)

-- Hop to pattern in (multiple) buffer:
vim.api.nvim_set_keymap(
    "n", "<Leader>p", ":HopPatternMW<CR>",
    { noremap = false, silent = true }
)

-- Hop to a line start in (multiple) buffer (  l):
vim.api.nvim_set_keymap(
    "n", "<Leader>l", ":HopLineMW<CR>",
    { noremap = false, silent = true }
)
