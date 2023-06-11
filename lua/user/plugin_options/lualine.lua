-- ~/.dotfiles/nvim/lua/user/plugin_options/lualine.lua

-- https://github.com/nvim-lualine/lualine.nvim



------------------------------------------------------------------------------
-- Lualine Plugin
------------------------------------------------------------------------------

-- Import Lualine with a protected call:
local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  return
end


------------------------------------------------------------
-- Appearance

-- Hide Lualine if window is smaller than the given columns:
local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

-- Display Git branches:
local branch = {
  'branch',
  icons_enabled = true,
  colored       = true,
  icon          = '',
  padding       = {
    left  = 0,
    right = 1,
  },
}

-- Display errors and warnings:
local diagnostics = {
  'diagnostics',
  padding = 1,
  sources = { 'nvim_diagnostic' },
  sections = {
    'error',
    'warn',
  },
  symbols = {
    error = ' ',
    warn  = ' ',
    hint  = ' ',
    info  = ' ',
  },
  colored          = false,
  update_in_insert = false,
  always_visible   = true,
}

local filename = {
  'filename',
}

-- Display Git diagnostics:
local diff = {
  'diff',
  colored = true,
  symbols = {
    added    = ' ',
    modified = ' ',
    removed  = ' ',
  },
  cond = hide_in_width
}

-- Display default indentation in file:
local spaces = function()
  return 'spaces: ' .. vim.api.nvim_buf_get_option(0, 'shiftwidth')
end

-- Display line:column of cursor:
local location = {
  'location',
  padding = 1,
}

-- Display progress bar of cursor position in file:
local progress = function()
  local current_line = vim.fn.line('.')
  local total_lines  = vim.fn.line('$')
  local chars = { '󰞕󰞕', '██', '██', '▇▇', '▇▇', '▆▆', '▆▆', '▅▅', '▅▅', '▄▄', '▄▄', '▃▃', '▃▃', '▂▂', '▂▂', '▁▁', '▁▁', '󰞒󰞒', }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local separator = function()
  return '   '
end

lualine.setup({
  options = {
    icons_enabled = true,
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
  sections = {
    -- Legend:
    -- +-------------------------------------------------+
    -- | a | b | c                             x | y | z |
    -- +-------------------------------------------------+
    lualine_a = { branch, separator },
    lualine_b = { diagnostics, separator },
    lualine_c = { filename },
    lualine_x = { diff, spaces, separator, 'encoding', separator },
    -- Show line and column number of cursor:
    lualine_y = { location, separator },
    -- Show progress because of cursor position on the right:
    lualine_z = { progress },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline         = {},
  winbar          = {},
  inactive_winbar = {},
  extensions      = {},
})

