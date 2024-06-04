-- ~/.dotfiles/nvim/lua/user/plugin_options/lualine.lua

-- https://github.com/nvim-lualine/lualine.nvim
-- Fast and easy to configure statusline plugin for Neovim.



------------------------------------------------------------------------------
-- Lualine Plugin
------------------------------------------------------------------------------

-- Import Lualine with a protected call:
local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  return "Error: */lua/user/plugin_options/lualine.lua -> Lualine plugin could not be loaded. Sure you have installed it in your plugins file?"
end

-- Hide Lualine if window is smaller than the given columns:
local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end


------------------------------------------------------------
-- Component Setups

-- Section separator width setup:
-- local separator = function()
--   return ' '
-- end


-- Git branch component setup:
local branch = {
  'branch',
  icons_enabled = true,
  colored       = false,
  icon          = '',
  padding       = {
    left  = 0,
    right = 1,
  },
}

-- Git diagnostics setup:
local diff = {
  'diff',
  symbols = {
    added    = ' ',
    modified = ' ',
    removed  = ' ',
  },
  cond             = hide_in_width,
  colored          = false,
  update_in_insert = true,
  always_visible   = false,
}

-- LSP diagnostics component setup:
local diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  sections = {
    'error',
    'warn',
    'hint',
    'info',
  },
  symbols = {
    error = ' ',
    warn  = ' ',
    hint  = '',
    info  = ' ',
  },
  colored          = false,
  update_in_insert = true,
  always_visible   = false,
  padding = {
    left  = 1,
    right = 0,
  },
}

-- line:column of cursor component setup:
local location = {
  'location',
  padding = {
    left  = 0,
    right = 1,
  },
}

-- Filename component setup:
local filename = {
  'filename',
}

-- File indentation level component setup:
local fileIndentationLevel = function()
  if vim.fn.winwidth(0) > 80 then
    return 'SP:' .. vim.api.nvim_buf_get_option(0, 'shiftwidth')
  else
    return ''
  end
end

-- File encoding component setup:
local fileEncoding = {
  'encoding',
  cond = hide_in_width,
}

-- Vertical progress bar component setup:
local progressBar = function()
  local current_line = vim.fn.line('.')
  local total_lines  = vim.fn.line('$')
  local chars        = { '󰞕󰞕', '██', '██', '▇▇', '▇▇', '▆▆', '▆▆', '▅▅', '▅▅', '▄▄', '▄▄', '▃▃', '▃▃', '▂▂', '▂▂', '▁▁', '▁▁', '󰞒󰞒', }
  local line_ratio   = current_line / total_lines
  local index        = math.ceil(line_ratio * #chars)

  return chars[index]
end


------------------------------------------------------------
-- Appearance

lualine.setup({
  options = {
    icons_enabled = true,
    theme         = 'auto',
    component_separators = {
      left  = '',
      right = '',
    },
    section_separators = {
      left  = '',
      right = '',
    },
    disabled_filetypes = {
      'alpha',
      'dashboard',
      'NvimTree',
      'Outline'
    },
    always_divide_middle = true,
  },

  -- Sections for active buffer:
  sections = {                                                     -- |a|b|c|  <-->  |x|y|z|
    -- Left side:
    lualine_a = { branch },                                        -- Actual branch name.
    lualine_b = { diff },                                          -- LSP diagnostics.
    lualine_c = { diagnostics },                                   -- File name with extension.
    -- Right side:
    lualine_x = { location },                                      -- Line:column of cursor.
    lualine_y = { filename, fileIndentationLevel, fileEncoding },
    lualine_z = { progressBar },                                   -- Show progress because of cursor position.
  },

  -- Sections for inactive buffers:
  inactive_sections = {        -- |a|b|c|  <-->  |x|y|z|
    -- Left side:
    lualine_a = { branch },    -- Actual branch name.
    lualine_b = {},
    lualine_c = {},
    -- Right side:
    lualine_x = {},
    lualine_y = { filename },
    lualine_z = {},
  },
  tabline         = {},
  winbar          = {},
  inactive_winbar = {},
  extensions      = {},
})