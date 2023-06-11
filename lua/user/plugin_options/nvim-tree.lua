-- ~/.dotfiles/nvim/lua/user/plugin_options/nvim-tree.lua

-- https://github.com/nvim-tree/nvim-tree.lua



------------------------------------------------------------------------------
-- Nvim-Tree Plugin
------------------------------------------------------------------------------

-- Import Nvim-Tree plugin with a protected call:
local nvim_tree_status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not nvim_tree_status_ok then
  return
end

-- Import Nvim-Tree config with a protected call:
--[[ local config_status_ok, nvim_tree_config = pcall(require, 'nvim-tree.config') ]]
--[[ if not config_status_ok then ]]
--[[   return ]]
--[[ end ]]

-- Assign call back function for custom behavior of Nvim-Tree:
--[[ local tree_cb = nvim_tree_config.nvim_tree_callback ]]

-- Open Nvim-Tree by default if Nvim starts:
-- Load the NvimTreeOpen command (Leave it at this place!):
local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end


--------------------------------------------------------------
-- Key Mappings

-- Don't show command message in command line:
local options = { noremap = true, silent = true }

vim.keymap.set('n', '<Leader>tt', ':NvimTreeToggle<CR>', options)
vim.keymap.set('n', '<Leader>et', ':NvimTreeFocus<CR>', options)
vim.keymap.set('n', '<Leader>sft', ':NvimTreeFindFile<CR>', options)

local function on_attach(bufnr)
  local api = require('nvim-tree.api')
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Close node:
  vim.keymap.set('n', 'cn', api.node.navigate.parent_close, opts('Close Directory'))
  -- Rename:
  vim.keymap.set('n', 'r', api.fs.rename_sub, opts('Rename: Omit Filename'))
  -- Show file information:
  vim.keymap.set('n', 'i', api.node.show_info_popup, opts('Info'))
  -- Open file in actual buffer:
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  -- Open file in vertical split:
  vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
  -- Open file in horizontal split:
  vim.keymap.set('n', 'h', api.node.open.horizontal, opts('Open: Horizontal Split'))
  -- Yank name of file:
  vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
  -- Yank relative path of file:
  vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
  -- Copy:
  vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
  -- Cut:
  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
  -- Paste:
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  -- Jump to parent node:
  vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
  -- Create new file/directory:
  vim.keymap.set('n', 'n', api.fs.create, opts('Create'))
  -- Delete file/directory:
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  -- Move file/directory into bin:
  vim.keymap.set('n', 'B', api.fs.trash, opts('Trash'))
  -- Collapse all:
  vim.keymap.set('n', 'C', api.tree.collapse_all, opts('Collapse'))
  -- Expand all:
  vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
  -- First sibling:
  vim.keymap.set('n', 'TS', api.node.navigate.sibling.first, opts('First Sibling'))
  -- Last sibling:
  vim.keymap.set('n', 'BS', api.node.navigate.sibling.last, opts('Last Sibling'))
  -- Previous sibling:
  vim.keymap.set('n', 'K', api.node.navigate.sibling.prev, opts('Previous Sibling'))
  -- Next sibling:
  vim.keymap.set('n', 'J', api.node.navigate.sibling.next, opts('Next Sibling'))

  -- Deactivated Key Mappings:
  vim.keymap.set('n', '<Nop>', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', '<Nop>', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', '<Nop>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
  vim.keymap.set('n', '<Nop>', api.node.open.tab, opts('Open: New Tab'))
  vim.keymap.set('n', '<Nop>', api.node.open.preview, opts('Open Preview'))
  vim.keymap.set('n', '<Nop>', api.node.run.cmd, opts('Run Command'))
  vim.keymap.set('n', '<Nop>', api.marks.bulk.move, opts('Move Bookmarked'))
  vim.keymap.set('n', '<Nop>', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
  vim.keymap.set('n', '<Nop>', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
  vim.keymap.set('n', '<Nop>', api.node.navigate.git.prev, opts('Prev Git'))
  vim.keymap.set('n', '<Nop>', api.node.navigate.git.next, opts('Next Git'))
  vim.keymap.set('n', '<Nop>', api.fs.rename_basename, opts('Rename: Basename'))
  vim.keymap.set('n', '<Nop>', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
  vim.keymap.set('n', '<Nop>', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
  vim.keymap.set('n', '<Nop>', api.live_filter.clear, opts('Clean Filter'))
  vim.keymap.set('n', '<Nop>', api.live_filter.start, opts('Filter'))
  vim.keymap.set('n', '<Nop>', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', '<Nop>', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', '<Nop>', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', '<Nop>', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  vim.keymap.set('n', '<Nop>', api.marks.toggle, opts('Toggle Bookmark'))
  vim.keymap.set('n', '<Nop>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<Nop>', api.node.open.no_window_picker, opts('Open: No Window Picker'))
  vim.keymap.set('n', '<Nop>', api.tree.close, opts('Close'))
  vim.keymap.set('n', '<Nop>', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', '<Nop>', api.tree.reload, opts('Refresh'))
  vim.keymap.set('n', '<Nop>', api.node.run.system, opts('Run System'))
  vim.keymap.set('n', '<Nop>', api.tree.search_node, opts('Search'))
  vim.keymap.set('n', '<Nop>', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
end


--------------------------------------------------------------
-- Settings

nvim_tree.setup {
  -- Settings for Project plugin:
  sync_root_with_cwd  = true,
  respect_buf_cwd     = true,
  update_focused_file = {
    enable    = true,
    auto_open = false,
    -- Don't switch automatically the project root:
    update_root = false
  },
  -- Settings of Nvim Tree:
  on_attach = on_attach,
  disable_netrw = true,
  hijack_netrw = true,
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = true,
  diagnostics = {
    enable = true,
    icons = {
      hint    = '',
      info    = '',
      warning = '',
      error   = '',
    },
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    icons = {
      show = {
        folder_arrow = true,
      },
      glyphs = {
        folder = {
          default    = '',
          open       = '',
          empty      = '',
          empty_open = '',
          symlink    = '',
        },
        git = {
          unstaged  = '  U  ',
          staged    = '  S  ',
          unmerged  = ' ',
          renamed   = '  R  ',
          untracked = '  N  ',
          deleted   = '    ',
          ignored   = ' ◌',
        },
      },
    },
    indent_markers = {
      enable = false,
    },
  },
  system_open = {
    cmd  = nil,
    args = {},
  },
  filters = {
    dotfiles = false,
    custom   = {},
  },
  git = {
    enable  = true,
    ignore  = false,
    show_on_dirs = true,
    timeout = 500,
  },
  view = {
    width            = 46,
    hide_root_folder = false,
    side             = 'left',
    number           = false,
    relativenumber   = false,
            float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "",
            width = 30,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },
  trash = {
    cmd             = 'trash',
    require_confirm = true,
  },
  actions = {
    open_file = {
      quit_on_open  = false,
      window_picker = {
        enable = false,
      },
    },
  },
}

-- Open NvimTree if Neovim starts:
vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })

