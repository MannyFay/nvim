-- lua/plugins/git/config/gitsigns.lua
-- Professional gitsigns configuration (pure configuration, no side effects)

local constants = require("plugins.git.core.constants")

local config = {
  signs = constants.signs,
  signs_staged = constants.signs,

  -- Performance optimizations
  signs_staged_enable = true,
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  update_debounce = constants.performance.gitsigns_debounce,
  max_file_length = constants.performance.max_file_length,

  -- Watch configuration
  watch_gitdir = {
    interval = constants.performance.worktree_interval,
    follow_files = true,
  },

  -- Attachment settings
  auto_attach = true,
  attach_to_untracked = true,

  -- Blame configuration (disabled by default, controlled by keymaps)
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 100,
    ignore_whitespace = false,
    use_focus = true,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = constants.blame_format.gitsigns,

  -- Sign priority
  sign_priority = 6,
  status_formatter = nil, -- Use default

  -- Preview configuration
  preview_config = {
    border = 'rounded',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1,
  },

  -- Advanced diff settings
  diff_opts = {
    algorithm = "histogram",    -- Better diff algorithm
    internal = false,          -- Use external git for performance
    indent_heuristic = true,   -- Better diff heuristics
  },

  -- Integration settings
  trouble = true,              -- Integrate with trouble.nvim

  -- Buffer-specific attach function
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    -- Only attach to files in git repositories
    if not constants.is_git_repo(vim.fn.expand("%:p:h")) then
      return false
    end

    -- Skip certain file types
    local filetype = vim.bo[bufnr].filetype
    if vim.tbl_contains(constants.ignore_patterns.filetypes, filetype) then
      return false
    end

    -- Skip certain buffer types
    local buftype = vim.bo[bufnr].buftype
    if vim.tbl_contains(constants.ignore_patterns.buftypes, buftype) then
      return false
    end

    -- Buffer-local text objects
    local function map(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      opts.silent = opts.silent ~= false
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Hunk text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select git hunk" })

    -- Visual mode staging (these don't conflict with normal mode)
    map('v', '<leader>gs', function()
      gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')}
    end, { desc = "Stage selection" })

    map('v', '<leader>gr', function()
      gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')}
    end, { desc = "Reset selection" })

    -- Hunk navigation with fallback for non-git files
    map('n', ']h', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true, desc = "Next hunk" })

    map('n', '[h', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true, desc = "Previous hunk" })

    return true -- Attach successful
  end,

  -- Advanced configuration for better integration
  _signs_staged_enable = true,
  _threaded_diff = true,
  _extmark_signs = true,

  -- Custom event handlers for integration
  _on_attach_pre = function(bufnr, ctx)
    -- Notify integration system
    vim.api.nvim_exec_autocmds("User", {
      pattern = constants.events.gitsigns_update,
      data = { bufnr = bufnr, ctx = ctx }
    })
  end,
}

return config
