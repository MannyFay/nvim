-- Insert this to your Packer plugins file:

-------------------------------------------------------------------------------
-- NvimTree

-- use({
--     'nvim-tree/nvim-tree.lua',
--     requires = 'kyazdani42/nvim-web-devicons',
--     config = function()
--       require('user.plugin_options.nvim-tree')
--     end
-- })




-------------------------------------------------------------------------------
-- Nvim-Tree Plugin
-- https://github.com/nvim-tree/nvim-tree.lua
-- File explorer for Neovim.
-------------------------------------------------------------------------------

-- Import Nvim-Tree plugin with a protected call:
local nvim_tree_status_ok, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_status_ok then
  return "Error: */lua/user/plugin_options/nvim-tree.lua -> NvimTree plugin could not be loaded. Sure you have installed it in your plugins file?"
end

-- Open Nvim-Tree by default if Nvim starts (leave it at this place!):
local function open_nvim_tree()
  require('nvim-tree.api').tree.open()
end

-- Recommended settings of Nvim-Tree documentation:
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


-------------------------------------------------------------------------------
-- Key Mappings

-- Don't show command message in command line:
local options = { noremap = true, silent = true }

vim.keymap.set('n', '<Leader>tt', ':NvimTreeToggle<CR>', options)
vim.keymap.set('n', '<Leader>et', ':NvimTreeFocus<CR>', options)
vim.keymap.set('n', '<Leader>sft', ':NvimTreeFindFile<CR>', options)

-- Set key mappings for Nvim-Tree:
local function on_attach(bufnr)
  local api = require('nvim-tree.api')
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set('n', 'cn', api.node.navigate.parent_close, opts('Close Directory'))  -- Close node.
  vim.keymap.set('n', 'r', api.fs.rename_sub, opts('Rename: Omit Filename'))          -- Rename.
  vim.keymap.set('n', 'i', api.node.show_info_popup, opts('Info'))                    -- Show file information.
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))                       -- Open file in actual buffer.
  vim.keymap.set('n', '|', api.node.open.vertical, opts('Open: Vertical Split'))      -- Open file in vertical split.
  vim.keymap.set('n', '-', api.node.open.horizontal, opts('Open: Horizontal Split'))  -- Open file in horizontal split.
  vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))                   -- Yank name of file.
  vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))     -- Yank relative path of file.
  vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))                            -- Copy.
  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))                                   -- Cut.
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))                               -- Paste.
  vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))        -- Jump to parent node.
  vim.keymap.set('n', 'ni', api.fs.create, opts('Create'))                            -- Create new file/directory.
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))                             -- Delete file/directory.
  vim.keymap.set('n', 'B', api.fs.trash, opts('Trash'))                               -- Move file/directory into bin.
  vim.keymap.set('n', 'C', api.tree.collapse_all, opts('Collapse'))                   -- Collapse all.
  vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))                   -- Expand all.
  vim.keymap.set('n', 'TS', api.node.navigate.sibling.first, opts('First Sibling'))   -- To first sibling.
  vim.keymap.set('n', 'BS', api.node.navigate.sibling.last, opts('Last Sibling'))     -- To last sibling.
  vim.keymap.set('n', 'K', api.node.navigate.sibling.prev, opts('Previous Sibling'))  -- To previous sibling.
  vim.keymap.set('n', 'J', api.node.navigate.sibling.next, opts('Next Sibling'))      -- To next sibling.

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
  on_attach                          = on_attach,  -- Call function above to set key mappings.
  hijack_cursor                      = false,      -- true: keeps cursor on first char of item in tree.
  auto_reload_on_write               = true,       -- Reload tree if a file was written.
  disable_netrw                      = true,       -- true: disable file explorer provided by netrw and use NvimTree instead.
  hijack_netrw                       = true,       -- true: let NvimTree to become the default file explorer.
  hijack_unnamed_buffer_when_opening = false,      -- true: Open NvimTree in place of a unnamed buffer.
  root_dirs                          = {},         -- List of preferred root directories as strings (only relevant when `update_focused_file.update_root` is `true`)
  prefer_startup_root                = false,      -- true: Prefer the start-up root directory when updating the root directory of the tree.
  sync_root_with_cwd                 = false,      -- true: change root directory of tree to current directory (used by Project plugin too).
  reload_on_bufenter                 = true,       -- true: reload NvimTree when entering its buffer.
  respect_buf_cwd                    = false,      -- true: Don't change tree root directory to current work directory of file buffer (used by Project plugin too).
  select_prompts                     = false,      -- true: Use UI prompt decorator (like from dressing.nvim or teescompe-ui-select.nvim).

  -- File and directory sorting options:
  sort = {
    sorter        = 'name',  -- Sorts by alphabetical order.
    folders_first = true,    -- true: List directories before files.
    files_first   = false,   -- true: List files before directories.
  },

  -- Look of NvimTree:
  view = {
    centralize_selection        = false,     -- true: Center the selected item in tree.
    cursorline                  = true,      -- true: Highlight the current line in tree.
    debounce_delay              = 15,        -- (default) Idle milliseconds for refreshing (increase there are graphics issues).
    side                        = 'left',    -- Position of NvimTree.
    preserve_window_proportions = false,     -- true: Keep window size proportional to the size of the tree.
    number                      = true,      -- true: Show line numbers in tree.
    relativenumber              = true,      -- true: Show relative line numbers in tree.
    signcolumn                  = 'yes',     -- Provide a column for signs.
    width = {
      min     = 46,                          -- Minimum width of NvimTree.
      max     = -1,                          -- Maximum width of NvimTree (-1 means no limit. Set to same as min to be static).
      padding = 1,                           -- Padding of NvimTree on the right.
    },
    -- For using NvimTree as a floating window:
    float = {
      enable             = false,            -- true: Enable floating window.
      quit_on_focus_loss = true,             -- true: Close floating window when focus is lost.
      -- Floating window options (specified in options.lua in nvim_open_win() function):
      open_win_config = {
        relative = 'editor',
        border   = 'rounded',
        width    = 100,
        height   = 30,
        row      = 1,
        col      = 1,
      },
    },
  },
  renderer = {
    add_trailing           = false,          -- true: Append trailing slash to directory names.
    group_empty            = false,          -- true: Compact directories that contain only a single folder into one node.
    full_name              = false,          -- true: Display names that are longer than the width in floating window.
    root_folder_label      = true,           -- true: Display the root directory.
    indent_width           = 2,              -- Indentation spaces of nesting (minimum = 1).
    special_files          = {},             -- Filenames that get highlighted by 'NvimTreeSpecialFile'.
    symlink_destination    = true,           -- true: Display destination of symlink.
    highlight_git          = true,           -- true: Highlight Git status of files and directories (requires nvim-tree.git.enable).
    highlight_diagnostics  = true,           -- true: Highlight diagnostic messages in tree (requires nvim-tree.diagnostics.enable).
    highlight_opened_files = 'none',         -- Tree highlighting for open files in buffers (options: 'icon', 'name', 'all', 'none').
    highlight_modified     = 'none',         -- Tree highlighting for modified files (options: 'icon', 'name', 'all', 'none').
    highlight_bookmarks    = 'none',         -- Tree highlighting for bookmarks (options: 'icon', 'name', 'all', 'none').
    highlight_clipboard    = 'none',         -- Tree highlighting for clipboard items (options: 'icon', 'name', 'all', 'none').
    indent_markers = {
      enable        = true,                 -- true: Show indent markers when folders are open.
      inline_arrows = true,                  -- true: Display indent markers in the same column as the arrows.
      icons = {
        corner = '└',
        edge   = '│',
        item   = '│',
        bottom = '─',
        none   = ' ',
      }
    },
    icons = {
      web_devicons = {
        file = {
          enable = true,                     -- true: Show web devicons for files.
          color  = true,                     -- true: Use colors of web devicons for file icons.
        },
        folder = {
          enable = false,                    -- true: Show web devicons for folders.
          color  = true,                     -- true: Use colors of web devicons for folder icons.
        },
      },
      git_placement         = 'before',      -- Options 'before' or 'after' filename, 'signcolumn'.
      diagnostics_placement = 'signcolumn',  -- Options 'before' or 'after' filename, 'signcolumn'.
      modified_placement    = 'signcolumn',  -- Options 'before' or 'after' filename, 'signcolumn'.
      bookmarks_placement   = 'signcolumn',  -- Options 'before' or 'after' filename, 'signcolumn'.
      padding               = ' ',           -- Padding between filename and icon.
      symlink_arrow         = ' ➛ ',         -- Icon for symlink.
      show = {
        file         = true,                 -- true: Show type icon before filename.
        folder       = true,                 -- true: Show directory icon before directory name.
        folder_arrow = true,                 -- true: Show arrow icon before directory name.
        git          = true,                 -- true: Show Git status icon.
        modified     = true,                 -- true: Show modified icon.
        diagnostics  = true,                 -- true: Show diagnostic icon.
        bookmarks    = true,                 -- true: Show bookmark icon.
      },
      glyphs = {
        default  = '',                      -- Is overwritten by devicons.
        symlink  = '',                      -- Icon for symlink.
        modified = '',                      -- Icon for modified file.
        folder = {
          arrow_closed = '',                -- Icon for closed folder.
          arrow_open   = '',                -- Icon for open folder.
          default      = '',                -- Icon for folder.
          open         = '',                -- Icon for open folder.
          empty        = '',                -- Icon for empty folder.
          empty_open   = '',                -- Icon for open empty folder.
          symlink      = '',                -- Icon for symlink.
          symlink_open = '➛',                -- Icon for open symlink.
        },
        git = {
          deleted   = '  ',                 -- Icon for deleted file.
          ignored   = ' ◌',                  -- Icon for ignored file.
          renamed   = '  ',                 -- Icon for renamed file.
          staged    = ' 󰾛 ',                 -- Icon for staged file.
          unmerged  = '  ',                 -- Icon for unmerged file.
          unstaged  = ' 󰟐 ',                 -- Icon for unstaged file.
          untracked = ' 󰵺 ',                 -- Icon for untracked file.
        },
      },
    },
  },

  -- Directory management:
  hijack_directories = {
    enable    = true,  -- true: Manage directory navigation by NvimTree.
    auto_open = true,  -- true: Open tree automatically.
  },

  -- Update focused file and un-collapse directories till file:
  update_focused_file = {
    enable      = true,   -- true: Feature is enabled.
    update_root = false,  -- true: Update the root directory if the file is not under current root directory.
    ignore_list = {},     -- List of buffer names / filetypes that will not update the tree.
  },

  -- Open a file or directory in your preferred application:
  system_open = {
    cmd  = '',  -- Empty string for OS default application.
    args = {},  -- List of arguments to pass to the command. Empty list for OS default application.
  },

  -- Git integration:
  git = {
    enable            = true,   -- true: Enable Git integration.
    show_on_dirs      = true,   -- true: Show status icon when directory has no status icon.
    show_on_open_dirs = true,   -- true: Show status icon of children on open directories.
    disable_for_dirs  = {},     -- Disable Git integration when git top-level matches listed paths.
    timeout           = 500,    -- (milliseconds) Timeout for Git status update if it takes longer than this.
    cygwin_support    = false,  -- true: Enable Cygwin support.
  },

  -- LSP and COC diagnostics integration:
  diagnostics = {
    enable            = true,               -- true: Enable diagnostics integration.
    debounce_delay    = 50,                 -- (milliseconds) Debounce time for diagnostics highlight update.
    show_on_dirs      = true,               -- true: Show diagnostic icons on parent directories.
    show_on_open_dirs = true,               -- true: Show diagnostic icons of children on open directories.
    severity = {
      min = vim.diagnostic.severity.HINT,   -- Minimum severity level of diagnostics is a hint.
      max = vim.diagnostic.severity.ERROR,  -- Maximum severity level of diagnostics is an error.
    },
    icons = {
      error   = '',
      hint    = '',
      info    = '',
      warning = '',
    },
  },

  -- Indication which file have unsaved modifications:
  modified ={
    enable            = true,  -- true: Enable modified indicator.
    show_on_dirs      = true,  -- true: Show modified indicator on parent directories.
    show_on_open_dirs = true,  -- true: Show modified indicator of children on open directories.
  },

  -- Filters what to display in NvimTree:
  filters = {
    git_ignored = false,  -- true: Hide files that are ignored by Git.
    dotfiles    = false,  -- true: Hide dotfiles.
    git_clean   = false,  -- true: Hide files with no Git status.
    no_buffer   = false,  -- true: Hide files if they have no buffer.
    custom      = { ".DS_Store" },     -- List of Vim regex patterns to hide files/directories.
    exclude     = {},     -- List of files/directories to exclude from filtering.
  },

  -- Live filtering in tree:
  live_filter = {
    prefix              = '[FILTER]: ',  -- Prefix for live filtering.
    always_show_folders = true,          -- true: Run filter on directories too.
  },

  -- File system watcher to watch for changes:
  filesystem_watchers = {
    enable         = true,  -- true: Enable file system watcher.
    debounce_delay = 50,    -- (milliseconds) Debounce time for file system watcher.
    ignore_dirs    = {},    -- List of Vim regex for absolute directory paths to ignore.
  },

  -- Actions behavior:
  actions = {
    use_system_clipboard = true,                          -- true: Use system clipboard for copy and paste.
    change_dir = {
      enable             = false,                         -- true: Change working directory when changing directories in tree.
      global             = false,                         -- true: Use ':cd' instead of ':lcd' when changing directories.
      restrict_above_cwd = false,                         -- true: Restrict changing to a directory above the global cwd.
    },
    expand_all = {
      max_folder_discovery = 300,                         -- Limit number of directories being explored when expanding directories.
      exclude              = {},                          -- List of directories to exclude from expanding automatically.
    },
    file_popup = {
      open_win_config = {
        col      = 1,
        row      = 1,
        relative = 'cursor',
        border   = 'shadow',
        style    = 'minimal',
      },
    },
    open_file = {
      quit_on_open  = false,                              -- true: Close NvimTree when opening a file.
      eject         = true,                               -- true: Prevent new opened file from opening in tree.
      resize_window = false,                              -- true: Resize tree when opening a file.
      window_picker = {
        enable = false,                                   -- true: Open a window picker when opening a file.
        picker = 'default',                               -- Use default window picker if feature is enabled.
        chars  = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',  -- Chars to use for window picker.
        exclude = {
          filetype = {
            'notify',
            'packer',
            'qf',
            'diff',
            'fugitive',
            'fugitiveblame',
          },
          buftype = {
            'nofile',
            'terminal',
            'help',
          },
        },
      },
    },
    remove_file = {
      close_window = true,                                -- true: Close any window displaying a file when removing it from the tree.
    },
  },

  -- Commands for using the 'put to trash' functionality (must be installed on OS):
  trash = {
    cmd = 'trash',
  },

  -- Tree behavior for working with tabs:
  tab = {
    sync = {
      open = false,   -- true: Open tree automatically if switching a tabpage or open new.
      close = false,  -- true: Close the tree across all tabpages if it is closed in one of them.
      ignore = {},    -- List of buffers/files on new tab that prevent the above two settings.
    },
  },

  -- Notification settings:
  notify = {
    threshold     = vim.log.levels.INFO,  -- Minimum notification level.
    absolute_path = true,                 -- true: Use absolute path for item names in notifications.
  },

  -- Settings how the help is sorted:
  help = {
    sort_by = 'key',  -- Sort mappings in help window alphabetically by their key. 'desc': sort alphabetically by description.
  },

  -- Confirmation settings:
  ui = {
    confirm = {
      remove      = true,   -- true: Prompt before removing.
      trash       = true,   -- true: Prompt before trashing.
      default_yes = false,  -- true: Default answer for prompts is yes.
    },
  },
}

-- Open NvimTree if Neovim starts:
vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })
