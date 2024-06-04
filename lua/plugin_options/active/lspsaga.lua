------------------------------------------------------------------------------
-- LSP Saga Plugin
-- https://github.com/nvimdev/lspsaga.nvim
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
    width = 0.6,
    height = 0.5,
    edit = "<CR>",
  },
  -- ui = {
  --   title = true,
  --   border = "single",
  -- },
  symbol_in_winbar = {
    enable          = true,
    separator       = " ",
    ignore_patterns = {},
    hide_keyword    = true,
    show_file       = true,
    folder_level    = 5,
    -- respect_root = true,
    color_mode      = true,
    delay           = 300,
  },
  callhierarchy = {
    layout = 'float'  -- Options: 'normal', 'float'
  },
  code_action = {
    num_shortcut     = true,
    show_server_name = false,
    extend_gitsigns  = false,
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
vim.api.nvim_set_hl(0, "SagaFileName", { fg = "#ababab" })
vim.api.nvim_set_hl(0, "SagaFolderName", { fg = "#569CD6" })
vim.api.nvim_set_hl(0, "SagaWinbarSep", { fg = "#606366" })

    --[[ SagaWinbarSep = { link = 'Operator' }, ]]
    --[[ SagaFileName = { link = 'Comment' }, ]]
    --[[ SagaFolderName = { link = 'Comment' }, ]]

-- https://github.com/nvimdev/lspsaga.nvim/blob/main/lua/lspsaga/highlight.lua

------------------------------------------------------------
-- Key Mappings

local keymap = vim.keymap.set
keymap('n','gd', '<cmd>Lspsaga peek_definition<CR>')
