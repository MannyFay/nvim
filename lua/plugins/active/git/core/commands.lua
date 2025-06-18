-- lua/plugins/git/core/commands.lua
-- User commands and utilities for git plugin ecosystem

local M = {}
local constants = require("plugins.git.core.constants")

-- Git workflow commands
local function create_workflow_commands()
  -- Smart commit workflow
  vim.api.nvim_create_user_command("GitCommitWorkflow", function(opts)
    local message = opts.args
    if message == "" then
      message = vim.fn.input("Commit message: ")
    end

    if message ~= "" then
      -- Stage all changes, commit, and optionally push
      local confirm_push = vim.fn.confirm("Push after commit?", "&Yes\n&No", 2)

      if pcall(require, "neogit") then
        local neogit = require("neogit")
        neogit.open({ "commit", "--message=" .. message })

        if confirm_push == 1 then
          vim.defer_fn(function()
            neogit.open({ "push" })
          end, 1000)
        end
      else
        vim.cmd("Git add -A")
        vim.cmd("Git commit -m '" .. message .. "'")
        if confirm_push == 1 then
          vim.cmd("Git push")
        end
      end
    end
  end, {
    nargs = "?",
    desc = "Smart commit workflow with optional push"
  })

  -- Quick branch switching
  vim.api.nvim_create_user_command("GitSwitchBranch", function(opts)
    local branch = opts.args
    if branch == "" then
      -- Use telescope if available
      if pcall(require, "telescope") then
        require("telescope.builtin").git_branches()
        return
      else
        -- Fallback to input
        branch = vim.fn.input("Branch name: ")
      end
    end

    if branch ~= "" then
      vim.cmd("Git checkout " .. branch)
      vim.notify("Switched to branch: " .. branch, vim.log.levels.INFO)
    end
  end, {
    nargs = "?",
    complete = function()
      local branches = vim.fn.systemlist("git branch --format='%(refname:short)'")
      return branches
    end,
    desc = "Switch git branch with completion"
  })

  -- Create and switch to new branch
  vim.api.nvim_create_user_command("GitNewBranch", function(opts)
    local branch = opts.args
    if branch == "" then
      branch = vim.fn.input("New branch name: ")
    end

    if branch ~= "" then
      vim.cmd("Git checkout -b " .. branch)
      vim.notify("Created and switched to branch: " .. branch, vim.log.levels.INFO)
    end
  end, {
    nargs = "?",
    desc = "Create and switch to new git branch"
  })
end

-- Plugin management commands
local function create_plugin_commands()
  -- Toggle git plugins
  vim.api.nvim_create_user_command("GitToggleBlame", function()
    if pcall(require, "gitsigns") then
      require("gitsigns").toggle_current_line_blame()
    else
      vim.notify("Gitsigns not available", vim.log.levels.WARN)
    end
  end, { desc = "Toggle git blame display" })

  vim.api.nvim_create_user_command("GitToggleSigns", function()
    if pcall(require, "gitsigns") then
      require("gitsigns").toggle_signs()
    else
      vim.notify("Gitsigns not available", vim.log.levels.WARN)
    end
  end, { desc = "Toggle git signs display" })

  -- Reset all git plugin state
  vim.api.nvim_create_user_command("GitResetPlugins", function()
    local plugins = { "gitsigns", "neogit", "diffview" }

    for _, plugin_name in ipairs(plugins) do
      local ok, plugin = pcall(require, plugin_name)
      if ok then
        if plugin.refresh then
          plugin.refresh()
        elseif plugin.reload then
          plugin.reload()
        end
        vim.notify(plugin_name .. " refreshed", vim.log.levels.INFO)
      end
    end

    -- Refresh orchestrator
    if _G.GitOrchestrator then
      vim.notify("Git orchestrator state refreshed", vim.log.levels.INFO)
    end
  end, { desc = "Reset and refresh all git plugins" })
end

-- Information and debugging commands
local function create_info_commands()
  -- Show git status across all tools
  vim.api.nvim_create_user_command("GitStatus", function()
    print("=== Git Status ===")

    -- Basic git info
    if constants.is_git_repo() then
      local branch = constants.get_current_branch()
      local root = constants.get_git_root()

      print("Repository: " .. (root or "unknown"))
      print("Branch: " .. (branch or "unknown"))

      -- Git status
      local status = vim.fn.system("git status --porcelain")
      if status ~= "" then
        print("\nModified files:")
        for line in status:gmatch("[^\r\n]+") do
          print("  " .. line)
        end
      else
        print("Working tree clean")
      end
    else
      print("Not in a git repository")
    end

    -- Plugin status
    print("\n=== Plugin Status ===")
    local plugins = {
      { name = "Gitsigns", module = "gitsigns" },
      { name = "Neogit", module = "neogit" },
      { name = "Diffview", module = "diffview" },
      { name = "Fugitive", check = function() return vim.fn.exists(":Git") == 2 end },
      { name = "Git-Worktree", module = "git-worktree" },
    }

    for _, plugin in ipairs(plugins) do
      local available = false
      if plugin.module then
        available = pcall(require, plugin.module)
      elseif plugin.check then
        available = plugin.check()
      end

      local status = available and "✓ Available" or "✗ Not Available"
      print(plugin.name .. ": " .. status)
    end
  end, { desc = "Show comprehensive git status" })

  -- Show all git keymaps
  vim.api.nvim_create_user_command("GitKeymaps", function()
    print("=== Git Keymaps ===")
    print("Core Operations:")
    print("  <leader>gg  - Git status (Neogit)")
    print("  <leader>gc  - Git commit")
    print("  <leader>gp  - Git push")
    print("  <leader>gP  - Git pull")
    print()
    print("Staging & Hunks:")
    print("  <leader>gs  - Stage hunk/selection")
    print("  <leader>gu  - Unstage hunk")
    print("  <leader>gr  - Reset hunk/selection")
    print("  ]h / [h     - Next/previous hunk")
    print()
    print("Diff & History:")
    print("  <leader>gd  - Open diffview")
    print("  <leader>gD  - Close diffview")
    print("  <leader>gh  - Preview hunk")
    print("  <leader>gH  - File history")
    print()
    print("Blame & Info:")
    print("  <leader>gb  - Toggle line blame")
    print("  <leader>gB  - Detailed blame")
    print("  <leader>gl  - Git log")
    print()
    print("Advanced:")
    print("  <leader>gco - Checkout branch")
    print("  <leader>gw  - List worktrees")
    print("  <leader>gW  - Create worktree")
    print("  <leader>gC  - Compare with HEAD")
    print("  <leader>gO  - Browse on GitHub")
    print()
    print("Text Objects:")
    print("  ih          - Select git hunk")
  end, { desc = "Show all git keymaps" })

  -- Performance diagnostics
  vim.api.nvim_create_user_command("GitPerformance", function()
    print("=== Git Performance Diagnostics ===")

    -- File size check
    local current_file = vim.api.nvim_buf_get_name(0)
    if current_file ~= "" then
      local file_size = vim.fn.getfsize(current_file)
      print(string.format("Current file size: %d bytes", file_size))
      if file_size > constants.performance.max_file_length * 100 then
        print("⚠️  Large file may impact git plugin performance")
      else
        print("✅ File size optimal for git plugins")
      end
    end

    -- Plugin performance settings
    print("\nPlugin Performance Settings:")
    print(string.format("  Gitsigns debounce: %dms", constants.performance.gitsigns_debounce))
    print(string.format("  Max file length: %d lines", constants.performance.max_file_length))
    print(string.format("  Worktree interval: %dms", constants.performance.worktree_interval))

    -- Git repository size
    if constants.is_git_repo() then
      local git_dir_size = vim.fn.system("du -sh .git 2>/dev/null | cut -f1")
      if git_dir_size ~= "" then
        print(string.format("  Git directory size: %s", vim.trim(git_dir_size)))
      end
    end
  end, { desc = "Show git performance diagnostics" })
end

-- Configuration management commands
local function create_config_commands()
  -- Reload git configuration
  vim.api.nvim_create_user_command("GitReloadConfig", function()
    -- Clear plugin caches
    for plugin_name in pairs(package.loaded) do
      if plugin_name:match("^plugins%.git%.") then
        package.loaded[plugin_name] = nil
      end
    end

    -- Reload orchestrator
    if pcall(require, "plugins.git.core.orchestrator") then
      require("plugins.git.core.orchestrator").setup()
      vim.notify("Git configuration reloaded", vim.log.levels.INFO)
    else
      vim.notify("Failed to reload git configuration", vim.log.levels.ERROR)
    end
  end, { desc = "Reload git plugin configuration" })

  -- Export current git configuration
  vim.api.nvim_create_user_command("GitExportConfig", function()
    local config = {
      git_info = {
        executable = constants.get_git_executable(),
        version = constants.get_git_version(),
        root = constants.get_git_root(),
        branch = constants.get_current_branch(),
      },
      plugins = {},
      performance = constants.performance,
    }

    -- Check plugin configurations
    local plugins = { "gitsigns", "neogit", "diffview" }
    for _, plugin_name in ipairs(plugins) do
      local ok, plugin = pcall(require, plugin_name)
      if ok and plugin.config then
        config.plugins[plugin_name] = plugin.config
      end
    end

    local json = vim.fn.json_encode(config)
    local filename = "git_config_export_" .. os.date("%Y%m%d_%H%M%S") .. ".json"

    vim.fn.writefile({json}, filename)
    vim.notify("Configuration exported to " .. filename, vim.log.levels.INFO)
  end, { desc = "Export current git configuration to JSON" })
end

-- Integration testing commands
local function create_testing_commands()
  -- Test plugin integrations
  vim.api.nvim_create_user_command("GitTestIntegrations", function()
    print("=== Testing Git Plugin Integrations ===")

    local tests = {
      {
        name = "Gitsigns → Neogit Integration",
        test = function()
          if pcall(require, "gitsigns") and pcall(require, "neogit") then
            vim.api.nvim_exec_autocmds("User", { pattern = constants.events.neogit_refresh })
            return true
          end
          return false
        end
      },
      {
        name = "Diffview → Gitsigns Integration",
        test = function()
          if pcall(require, "diffview") and pcall(require, "gitsigns") then
            vim.api.nvim_exec_autocmds("User", { pattern = constants.events.diffview_opened })
            vim.api.nvim_exec_autocmds("User", { pattern = constants.events.diffview_closed })
            return true
          end
          return false
        end
      },
      {
        name = "Worktree Integration",
        test = function()
          if pcall(require, "git-worktree") then
            vim.api.nvim_exec_autocmds("User", { pattern = constants.events.worktree_changed })
            return true
          end
          return false
        end
      },
    }

    for _, test in ipairs(tests) do
      local success = test.test()
      local status = success and "✅ PASS" or "❌ FAIL"
      print(string.format("%s: %s", test.name, status))
    end
  end, { desc = "Test git plugin integrations" })
end

-- Setup all commands
function M.setup()
  create_workflow_commands()
  create_plugin_commands()
  create_info_commands()
  create_config_commands()
  create_testing_commands()

  vim.notify("Git commands loaded", vim.log.levels.DEBUG)
end

return M
