-- ~/.dotfiles/nvim/lua/user/plugin_options/hop.lua

-- https://github.com/phaazon/hop.nvim



-------------------------------------------------------------------------------
-- Hop Plugin
-------------------------------------------------------------------------------

-- Import Hop plugin with a protected call:
local hop_status_ok, hop = pcall(require, 'hop')
if not hop_status_ok then
  return
end


------------------------------------------------------------
-- Appearance

hop.setup {
  -- Enable Hop for multi buffer use:
  multi_windows = true,
}


------------------------------------------------------------
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
