-- lua/plugins/git/core/constants.lua
-- Shared constants and configuration for all git plugins

local M = {}

-- Git signs configuration
M.signs = {
  add          = { text = '▎' },
  change       = { text = '▎' },
  delete       = { text = ' ' },
  topdelete    = { text = ' ' },
  changedelete = { text = '▎' },
  untracked    = { text = '┆' },
}

-- Git service URLs for PR/MR creation
M.git_services = {
  ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
  ["gitlab.com"] = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
  ["bitbucket.org"] = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
  ["azure.com"] = "https://dev.azure.com/${owner}/_git/${repository}/pullrequestcreate?sourceRef=${branch_name}&targetRef=${target}",
}

-- Neogit mode text with consistent icons
M.neogit_mode_text = {
  M = "   Modified:",
  N = " 󰵺  New file:",
  A = " 󰾛  Staged:",
  D = "   Deleted:",
  C = "   Copied:",
  U = "   Updated:",
  R = "   Renamed:",
  DD = "   Unmerged:",
  AU = "   Unmerged:",
  UD = "   Unmerged:",
  UA = "   Unmerged:",
  DU = "   Unmerged:",
  AA = "   Unmerged:",
  UU = "   Unmerged:",
  ["?"] = "",
}

-- Performance settings
M.performance = {
  gitsigns_debounce = 50,
  neogit_console_timeout = 2000,
  diffview_debounce = 15,
  max_file_length = 40000,
  worktree_interval = 1000,
}

-- File patterns to ignore for git operations
M.ignore_patterns = {
  filetypes = {
    "fugitive",
    "fugitiveblame",
    "gitcommit",
    "gitrebase",
    "help",
    "qf",
    "diff",
    "TelescopePrompt",
    "TelescopeResults",
  },
  buftypes = {
    "nofile",
    "terminal",
    "help",
    "quickfix",
  },
}

-- Blame format configuration
M.blame_format = {
  gitsigns = '<author> • <author_time:%R> • <summary>',
  fugitive_short = '--date=short',
  fugitive_detailed = '--date=iso',
}

-- Diffview layouts
M.diffview_layouts = {
  default = "diff2_horizontal",
  merge_tool = "diff3_horizontal",
  file_history = "diff2_horizontal",
}

-- Default directories and paths
M.paths = {
  git_dir = ".git",
  hooks_dir = ".git/hooks",
  worktree_base = "../worktrees",
}

-- Integration event names for cross-plugin communication
M.events = {
  git_state_changed = "GitStateChanged",
  neogit_refresh = "NeogitStatusRefresh",
  gitsigns_update = "GitSignsUpdate",
  diffview_opened = "DiffviewOpened",
  diffview_closed = "DiffviewClosed",
  worktree_changed = "WorktreeChanged",
}

-- Plugin priority order for loading
M.load_order = {
  "gitsigns",   -- Load first for signs
  "diffview",   -- Load early for neogit integration
  "fugitive",   -- Load for advanced operations
  "neogit",     -- Load main interface last
  "worktree",   -- Load worktree management last
}

-- Default key prefix for all git operations
M.key_prefix = "<leader>g"

-- Health check requirements
M.health_requirements = {
  git_executable = "git",
  git_version_min = "2.0.0",
  required_plugins = {
    "gitsigns",
    "neogit",
    "diffview",
    "fugitive",
  },
  optional_plugins = {
    "git-worktree",
    "telescope",
    "which-key",
  },
}

-- Utility functions for constants
function M.get_git_executable()
  return vim.fn.executable("git") == 1 and "git" or nil
end

function M.get_git_version()
  if not M.get_git_executable() then return nil end

  local version_output = vim.fn.system("git --version")
  local version = version_output:match("git version (%d+%.%d+%.%d+)")
  return version
end

function M.is_git_repo(path)
  path = path or vim.fn.getcwd()
  local git_dir = vim.fn.system("git -C " .. vim.fn.shellescape(path) .. " rev-parse --git-dir 2>/dev/null")
  return vim.v.shell_error == 0
end

function M.get_git_root(path)
  path = path or vim.fn.getcwd()
  if not M.is_git_repo(path) then return nil end

  local git_root = vim.fn.system("git -C " .. vim.fn.shellescape(path) .. " rev-parse --show-toplevel 2>/dev/null")
  if vim.v.shell_error == 0 then
    return vim.trim(git_root)
  end
  return nil
end

function M.get_current_branch(path)
  path = path or vim.fn.getcwd()
  if not M.is_git_repo(path) then return nil end

  local branch = vim.fn.system("git -C " .. vim.fn.shellescape(path) .. " branch --show-current 2>/dev/null")
  if vim.v.shell_error == 0 then
    return vim.trim(branch)
  end
  return nil
end

return M
