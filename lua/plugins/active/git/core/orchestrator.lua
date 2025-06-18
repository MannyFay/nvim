-- lua/plugins/git/core/orchestrator.lua
-- Central orchestration for all git plugins with unified keymaps

local M = {}
local constants = require("plugins.git.core.constants")

-- Keymap definitions with descriptions
local keymaps = {
  -- Core Git Interface
  {
    mode = "n",
    lhs = "<leader>gg",
    rhs = function() require("neogit").open() end,
    opts = { desc = "Git Status (Neogit)" },
  },

  -- Staging & Hunks (Gitsigns)
  {
    mode = "n",
    lhs = "<leader>gs",
    rhs = function() require("gitsigns").stage_hunk() end,
    opts = { desc = "Stage Hunk" },
  },
  {
    mode = "v",
    lhs = "<leader>gs",
    rhs = function() require("gitsigns").stage_hunk({vim.fn.line('.'), vim.fn.line('v')}) end,
    opts = { desc = "Stage Selection" },
  },
  {
    mode = "n",
    lhs = "<leader>gu",
    rhs = function() require("gitsigns").undo_stage_hunk() end,
    opts = { desc = "Unstage Hunk" },
  },
  {
    mode = "n",
    lhs = "<leader>gr",
    rhs = function() require("gitsigns").reset_hunk() end,
    opts = { desc = "Reset Hunk" },
  },
  {
    mode = "v",
    lhs = "<leader>gr",
    rhs = function() require("gitsigns").reset_hunk({vim.fn.line('.'), vim.fn.line('v')}) end,
    opts = { desc = "Reset Selection" },
  },

  -- Diff & Preview
  {
    mode = "n",
    lhs = "<leader>gd",
    rhs = "<cmd>DiffviewOpen<cr>",
    opts = { desc = "Open Diffview" },
  },
  {
    mode = "n",
    lhs = "<leader>gD",
    rhs = "<cmd>DiffviewClose<cr>",
    opts = { desc = "Close Diffview" },
  },
  {
    mode = "n",
    lhs = "<leader>gh",
    rhs = function() require("gitsigns").preview_hunk() end,
    opts = { desc = "Preview Hunk" },
  },
  {
    mode = "n",
    lhs = "<leader>gH",
    rhs = "<cmd>DiffviewFileHistory %<cr>",
    opts = { desc = "File History" },
  },

  -- Blame
  {
    mode = "n",
    lhs = "<leader>gb",
    rhs = function() require("gitsigns").toggle_current_line_blame() end,
    opts = { desc = "Toggle Line Blame" },
  },
  {
    mode = "n",
    lhs = "<leader>gB",
    rhs = "<cmd>GBlameDetailed<cr>",
    opts = { desc = "Detailed Blame (Fugitive)" },
  },

  -- Commit & Push
  {
    mode = "n",
    lhs = "<leader>gc",
    rhs = function() require("neogit").open({ "commit" }) end,
    opts = { desc = "Git Commit" },
  },
  {
    mode = "n",
    lhs = "<leader>gp",
    rhs = function() require("neogit").open({ "push" }) end,
    opts = { desc = "Git Push" },
  },
  {
    mode = "n",
    lhs = "<leader>gP",
    rhs = function() require("neogit").open({ "pull" }) end,
    opts = { desc = "Git Pull" },
  },

  -- Branches & Log
  {
    mode = "n",
    lhs = "<leader>gco",
    rhs = "<cmd>Telescope git_branches<cr>",
    opts = { desc = "Checkout Branch" },
  },
  {
    mode = "n",
    lhs = "<leader>gl",
    rhs = function() require("neogit").open({ "log" }) end,
    opts = { desc = "Git Log" },
  },

  -- Worktree (conditional)
  {
    mode = "n",
    lhs = "<leader>gw",
    rhs = function()
      if pcall(require, "git-worktree") then
        require("telescope").extensions.git_worktree.git_worktrees()
      else
        vim.notify("Git-worktree not available", vim.log.levels.WARN)
      end
    end,
    opts = { desc = "List Worktrees" },
  },
  {
    mode = "n",
    lhs = "<leader>gW",
    rhs = function()
      if pcall(require, "git-worktree") then
        require("telescope").extensions.git_worktree.create_git_worktree()
      else
        vim.notify("Git-worktree not available", vim.log.levels.WARN)
      end
    end,
    opts = { desc = "Create Worktree" },
  },

  -- Advanced Operations (Fugitive)
  {
    mode = "n",
    lhs = "<leader>gC",
    rhs = "<cmd>GCompare<cr>",
    opts = { desc = "Compare with HEAD" },
  },
  {
    mode = "n",
    lhs = "<leader>gE",
    rhs = "<cmd>Gedit<cr>",
    opts = { desc = "Edit Git Object" },
  },
  {
    mode = { "n", "v" },
    lhs = "<leader>gO",
    rhs = "<cmd>GBrowse<cr>",
    opts = { desc = "Browse on GitHub" },
  },

  -- Navigation
  {
    mode = "n",
    lhs = "]h",
    rhs = function() require("gitsigns").next_hunk() end,
    opts = { desc = "Next Hunk" },
  },
  {
    mode = "n",
    lhs = "[h",
    rhs = function() require("gitsigns").prev_hunk() end,
    opts = { desc = "Previous Hunk" },
  },

  -- Text Objects
  {
    mode = { "o", "x" },
    lhs = "ih",
    rhs = ":<C-U>Gitsigns select_hunk<cr>",
    opts = { desc = "Select Hunk" },
  },
}

-- Setup which-key groups
local function setup_which_key_groups()
  local ok, wk = pcall(require, "which-key")
  if not ok then return end

  wk.register({
    ["<leader>g"] = {
      name = " Git",
      g = "Status",
      s = "Stage",
      u = "Unstage",
      r = "Reset",
      d = "Diff",
      h = "Hunk/History",
      b = "Blame",
      c = "Commit/Compare",
      p = "Push/Pull",
      l = "Log",
      w = "Worktree",
      O = "Open/Browse",
      E = "Edit",
    },
  })
end

-- Git repository detection
local function is_git_repo()
  local git_dir = vim.fn.system("git rev-parse --git-dir 2>/dev/null")
  return vim.v.shell_error == 0
end

-- Setup keymaps with git repo detection
local function setup_keymaps()
  if not is_git_repo() then
    -- Only setup core git interface for non-git directories
    vim.keymap.set("n", "<leader>gg", function()
      vim.notify("Not in a git repository", vim.log.levels.WARN)
    end, { desc = "Git Status (not in repo)" })
    return
  end

  -- Setup all keymaps for git repositories
  for _, keymap in ipairs(keymaps) do
    local modes = type(keymap.mode) == "table" and keymap.mode or { keymap.mode }
    for _, mode in ipairs(modes) do
      vim.keymap.set(mode, keymap.lhs, keymap.rhs, keymap.opts)
    end
  end
end

-- Auto-detect git repository changes
local function setup_git_detection()
  local group = vim.api.nvim_create_augroup("GitOrchestrator", { clear = true })

  -- Detect when entering/leaving git repositories
  vim.api.nvim_create_autocmd({ "DirChanged", "BufEnter" }, {
    group = group,
    callback = function()
      vim.schedule(function()
        setup_keymaps()
      end)
    end,
  })

  -- Refresh integration when git state changes
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = { "GitSignsUpdate", "NeogitStatusRefresh" },
    callback = function()
      -- Notify other integrations
      vim.api.nvim_exec_autocmds("User", { pattern = "GitStateChanged" })
    end,
  })
end

-- Plugin conflict detection and resolution
local function resolve_plugin_conflicts()
  -- Disable conflicting fugitive mappings when neogit is active
  vim.api.nvim_create_autocmd("User", {
    pattern = "NeogitStatusRefresh",
    callback = function()
      -- Remove conflicting fugitive status buffers
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local ft = vim.bo[buf].filetype
        if ft == "fugitive" and vim.api.nvim_buf_get_name(buf):match("%.git/index") then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end
    end,
  })
end

-- Main setup function
function M.setup()
  -- Only setup if git is available
  if vim.fn.executable("git") == 0 then
    vim.notify("Git executable not found", vim.log.levels.ERROR)
    return
  end

  setup_keymaps()
  setup_which_key_groups()
  setup_git_detection()
  resolve_plugin_conflicts()

  -- Expose orchestrator state for health checks
  _G.GitOrchestrator = {
    is_git_repo = is_git_repo,
    keymaps = keymaps,
    constants = constants,
  }

  vim.notify("Git orchestrator loaded", vim.log.levels.INFO)
end

return M
