-------------------------------------------------------------------------------
-- Treesitter Plugin
-- https://github.com/nvim-treesitter/nvim-treesitter
-------------------------------------------------------------------------------

-- Import Treesitter with a protected call:
local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return "Error: */lua/user/plugin_options/treesitter.lua -> Treesitter plugin could not be loaded. Sure you have installed it in your plugins file?"
end


------------------------------------------------------------
-- Appearance

configs.setup {
  modules          = { },
  ensure_installed = { 'all' },  -- List of syntax highlight parsers to install.
  sync_install     = false,      -- Install packages asynchronously (applies only to 'ensure_installed').
  auto_install     = false,      -- Automatically install missing parsers in a buffer.
  ignore_install   = { 'all' },  -- List of syntax highlight parser to ignore.
  autopairs = {                  -- Create always a pair of brackets.
    enable = true,
  },
  highlight = {
    -- Enable syntax highlighting:
    enable = false,
    -- Languages where color highlighting is disabled:
    disable = { '' },
    -- If true, it slows down Neovim and doubles syntax highlighting:
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable  = true,
    disable = { '' }
  },
  -- context_commentstring = {
  --   enable         = true,
  --   enable_autocmd = false,
  -- },
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
    enable                = true,
    enable_rename         = true,
    enable_close          = true,
    enable_close_on_slash = true,
    filetypes             = { "html" , "xml", "php", "blade" },
  },
}

require('ts_context_commentstring').setup {}

vim.g.skip_ts_context_commentstring_module = true