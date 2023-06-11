-- ~/.dotfiles/nvim/lua/user/plugin_options/lspsaga.lua

-- https://github.com/nvimdev/lspsaga.nvim



------------------------------------------------------------------------------
-- LSP Saga Plugin
------------------------------------------------------------------------------

-- Import LSP Saga plugin with a protected call:
local lspsaga_status_ok, lspsaga = pcall(require, 'lspsaga')
if not lspsaga_status_ok then
  return
end


------------------------------------------------------------
-- Appearance

lspsaga.setup({
  -- keybinds for navigation in lspsaga window
  scroll_preview = {
    scroll_down = "<C-j>",
    scroll_up   = "<C-k>"
  },
  -- use enter to open file with definition preview
  definition = {
    edit = "<CR>",
  },
  ui = {
    title = true,
    border = "single",
  },
    symbol_in_winbar = {
    enable = true,
    separator = "   ",
    ignore_patterns={},
    hide_keyword = true,
    show_file = true,
    folder_level = 5,
    respect_root = true,
    color_mode = true,
  },
})

vim.api.nvim_set_hl(0, "TitleString", { fg = "#ababab", bg = "#252525" })
vim.api.nvim_set_hl(0, "TitleIcon", { fg = "#252525", bg = "#252525" })
vim.api.nvim_set_hl(0, "SagaBorder", { fg = "#252525", bg = "#252525" })
vim.api.nvim_set_hl(0, "SagaNormal", { bg = "#252525" })
vim.api.nvim_set_hl(0, "SagaExpand", { fg = "#252525", bg = "#252525" })
vim.api.nvim_set_hl(0, "SagaCollapse", { fg = "#252525", bg = "#252525" })
vim.api.nvim_set_hl(0, "SagaCount", { fg = "#252525", bg = "#252525" })
vim.api.nvim_set_hl(0, "SagaBeacon", { fg = "#252525", bg = "#252525" })

-- https://github.com/nvimdev/lspsaga.nvim/blob/main/lua/lspsaga/highlight.lua

------------------------------------------------------------
-- Key Mappings

local keymap = vim.keymap.set
keymap('n','gd', '<cmd>Lspsaga peek_definition<CR>')
