-------------------------------------------------------------------------------
-- Treesitter Plugin
-- https://github.com/nvim-treesitter/nvim-treesitter
-------------------------------------------------------------------------------

-- Import Treesitter with a protected call:
local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return "Error: */lua/user/plugin_options/treesitter.lua -> Treesitter plugin could not be loaded. Sure you have installed it in your plugins file?"
end

-- Import Treesitter Auto Tag with a protected call:
-- https://github.com/windwp/nvim-ts-autotag
local ts_auto_tag_status_ok, ts_auto_tag = pcall(require, 'nvim-ts-autotag')
if not ts_auto_tag_status_ok then
  return "Error: */lua/plugin_options/active/treesitter.lua -> Treesitter Auto Tag plugin could not be loaded. Sure you have installed it in your plugins file?"
end



-------------------------------------------------------------------------------
-- TreeSitter Appearance

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
    disable = { 'all' },
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
}



-------------------------------------------------------------------------------
-- TreeSitter Context CommentString Appearance

require('ts_context_commentstring').setup {}
vim.g.skip_ts_context_commentstring_module = true



-------------------------------------------------------------------------------
-- TreeSitter Auto Tag Appearance

ts_auto_tag.setup({
  opts = {
    enable_close          = true,  -- Auto close tags
    enable_rename         = true,  -- Auto rename pairs of tags
    enable_close_on_slash = false  -- Auto close on trailing </
  },
  -- Also override individual filetype configs, these take priority.
  -- Empty by default, useful if one of the "opts" global settings
  -- doesn't work well in a specific filetype
  -- per_filetype = {
  --   ["html"] = {
  --     enable_close = false
  --   }
  -- }
})
