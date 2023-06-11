-- ~/.dotfiles/nvim/lua/user/plugin_options/treesitter.lua

-- https://github.com/nvim-treesitter/nvim-treesitter



------------------------------------------------------------------------------
-- Treesitter Plugin
------------------------------------------------------------------------------

-- Import Treesitter with a protected call:
local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end


------------------------------------------------------------
-- Appearance

configs.setup {
  -- List of syntax highlight parsers to install:
  ensure_installed = 'all',
  -- Install packages asynchronously (applies only to 'ensure_installed'):
  sync_install = false,
  -- List of syntax highlight parser to ignore:
  ignore_install = { '' },
  -- Create always a pair of brackets:
  autopairs = {
    enable = true,
  },
  highlight = {
    -- Enable syntax highlighting:
    enable = true,
    -- Languages where color highlighting is disabled:
    disable = { '' },
    -- If true, it slows down Neovim and doubles syntax highlighting:
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable  = true,
    disable = { '' }
  },
  context_commentstring = {
    enable         = true,
    enable_autocmd = false,
  },
  textobjects = {
    select = {
      enable    = true,
      lookahead = true,
      keymaps   = {},
    },
  },
  -- Highlighting of matching pairs (parentheses, brackets, tags, etc.):
  matchup = {
    -- Enable extension:
    enable = true,
    -- List of disabled languages:
    disable = { '' },
  },
    playground = {
    enable  = true,
    disable = {},
    -- Time in milliseconds to highlight nodes in playground:
    updatetime = 25,
    -- Don't persist queries across Neovim sessions:
    persist_queries = false,
    keybindings = {
      toggle_query_editor       = '<Nop>',
      toggle_hl_groups          = '<Nop>',
      toggle_injected_languages = '<Nop>',
      toggle_anonymous_nodes    = '<Nop>',
      toggle_language_display   = '<Nop>',
      focus_language            = '<Nop>',
      unfocus_language          = '<Nop>',
      update                    = '<Nop>',
      goto_node                 = '<Nop>',
      show_help                 = '<Nop>',
    },
  },
  -- Autotag extension for auto close and auto rename tags:
  autotag = {
    enable = true,
  },
}

