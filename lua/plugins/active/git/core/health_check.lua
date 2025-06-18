-- lua/plugins/git/core/health.lua
-- Comprehensive health check system for git plugin ecosystem

local M = {}
local constants = require("plugins.git.core.constants")

-- Health check result structure
local function create_result(status, message, advice)
  return {
    status = status, -- "ok", "warn", "error"
    message = message,
    advice = advice,
  }
end

-- Check git executable and version
local function check_git_executable()
  local results = {}

  -- Check if git is available
  if not constants.get_git_executable() then
    table.insert(results, create_result(
      "error",
      "Git executable not found",
      "Install Git: https://git-scm.com/downloads"
    ))
    return results
  end

  table.insert(results, create_result("ok", "Git executable found", nil))

  -- Check git version
  local version = constants.get_git_version()
  if version then
    local min_version = constants.health_requirements.git_version_min
    table.insert(results, create_result(
      "ok",
      string.format("Git version: %s", version),
      version < min_version and string.format("Consider upgrading to %s+", min_version) or nil
    ))
  else
    table.insert(results, create_result(
      "warn",
      "Could not determine git version",
      "Check git installation"
    ))
  end

  return results
end

-- Check git repository status
local function check_git_repository()
  local results = {}
  local cwd = vim.fn.getcwd()

  if not constants.is_git_repo(cwd) then
    table.insert(results, create_result(
      "warn",
      "Not in a git repository",
      "Some git features will be limited"
    ))
    return results
  end

  table.insert(results, create_result("ok", "In git repository", nil))

  -- Check git root
  local git_root = constants.get_git_root(cwd)
  if git_root then
    table.insert(results, create_result(
      "ok",
      string.format("Git root: %s", git_root),
      nil
    ))
  end

  -- Check current branch
  local branch = constants.get_current_branch(cwd)
  if branch then
    table.insert(results, create_result(
      "ok",
      string.format("Current branch: %s", branch),
      nil
    ))
  end

  return results
end

-- Check plugin availability and loading
local function check_plugins()
  local results = {}

  -- Check required plugins
  for _, plugin_name in ipairs(constants.health_requirements.required_plugins) do
    local ok, plugin = pcall(require, plugin_name)
    if ok then
      table.insert(results, create_result(
        "ok",
        string.format("Plugin '%s' loaded", plugin_name),
        nil
      ))
    else
      table.insert(results, create_result(
        "error",
        string.format("Plugin '%s' not available", plugin_name),
        string.format("Install or check configuration for %s", plugin_name)
      ))
    end
  end

  -- Check optional plugins
  for _, plugin_name in ipairs(constants.health_requirements.optional_plugins) do
    local ok, plugin = pcall(require, plugin_name)
    if ok then
      table.insert(results, create_result(
        "ok",
        string.format("Optional plugin '%s' available", plugin_name),
        nil
      ))
    else
      table.insert(results, create_result(
        "warn",
        string.format("Optional plugin '%s' not available", plugin_name),
        string.format("Consider installing %s for enhanced functionality", plugin_name)
      ))
    end
  end

  return results
end

-- Check keymapping conflicts
local function check_keymap_conflicts()
  local results = {}
  local conflicts = {}

  -- Get all current keymaps for normal mode
  local keymaps = vim.api.nvim_get_keymap("n")
  local git_prefix = constants.key_prefix

  -- Track git-related keymaps
  local git_keymaps = {}
  for _, keymap in ipairs(keymaps) do
    if keymap.lhs:match("^" .. vim.pesc(git_prefix)) then
      if git_keymaps[keymap.lhs] then
        table.insert(conflicts, keymap.lhs)
      else
        git_keymaps[keymap.lhs] = true
      end
    end
  end

  if #conflicts > 0 then
    table.insert(results, create_result(
      "error",
      string.format("Keymap conflicts detected: %s", table.concat(conflicts, ", ")),
      "Review and resolve conflicting keymaps"
    ))
  else
    table.insert(results, create_result(
      "ok",
      "No keymap conflicts detected",
      nil
    ))
  end

  -- Check if orchestrator is loaded
  if _G.GitOrchestrator then
    table.insert(results, create_result(
      "ok",
      "Git orchestrator is active",
      nil
    ))
  else
    table.insert(results, create_result(
      "warn",
      "Git orchestrator not loaded",
      "Check orchestrator configuration"
    ))
  end

  return results
end

-- Check plugin integrations
local function check_integrations()
  local results = {}

  -- Check if integration modules are loaded
  local integrations = {
    "plugins.git.integrations.gitsigns",
    "plugins.git.integrations.neogit",
    "plugins.git.integrations.diffview",
    "plugins.git.integrations.fugitive",
    "plugins.git.integrations.worktree",
  }

  for _, integration in ipairs(integrations) do
    local ok, _ = pcall(require, integration)
    if ok then
      table.insert(results, create_result(
        "ok",
        string.format("Integration loaded: %s", integration:match("([^.]+)$")),
        nil
      ))
    else
      table.insert(results, create_result(
        "warn",
        string.format("Integration not loaded: %s", integration:match("([^.]+)$")),
        "Check integration configuration"
      ))
    end
  end

  return results
end

-- Check performance metrics
local function check_performance()
  local results = {}

  -- Check file size limits
  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file ~= "" then
    local file_size = vim.fn.getfsize(current_file)
    if file_size > constants.performance.max_file_length * 100 then -- approx conversion
      table.insert(results, create_result(
        "warn",
        string.format("Large file detected (%d bytes)", file_size),
        "Git plugins may be slower on large files"
      ))
    else
      table.insert(results, create_result(
        "ok",
        "File size within performance limits",
        nil
      ))
    end
  end

  -- Check debounce settings
  local gitsigns_ok, gitsigns_config = pcall(require, "gitsigns.config")
  if gitsigns_ok and gitsigns_config.config then
    local debounce = gitsigns_config.config.update_debounce
    if debounce > 200 then
      table.insert(results, create_result(
        "warn",
        string.format("Gitsigns debounce is high (%dms)", debounce),
        "Consider lowering for better responsiveness"
      ))
    else
      table.insert(results, create_result(
        "ok",
        string.format("Gitsigns debounce optimal (%dms)", debounce),
        nil
      ))
    end
  end

  return results
end

-- Format and display health check results
local function display_results(results, category)
  print(string.format("\n=== %s ===", category))

  for _, result in ipairs(results) do
    local icon = result.status == "ok" and "✓" or
                 result.status == "warn" and "⚠" or "✗"
    local color = result.status == "ok" and "\27[32m" or
                  result.status == "warn" and "\27[33m" or "\27[31m"

    print(string.format("%s%s\27[0m %s", color, icon, result.message))

    if result.advice then
      print(string.format("    → %s", result.advice))
    end
  end
end

-- Run comprehensive health check
function M.check_all()
  print("🔍 Git Plugin Health Check")
  print("=" .. string.rep("=", 50))

  local all_results = {}

  -- Run all health checks
  local checks = {
    { name = "Git Executable", func = check_git_executable },
    { name = "Git Repository", func = check_git_repository },
    { name = "Plugin Loading", func = check_plugins },
    { name = "Keymap Conflicts", func = check_keymap_conflicts },
    { name = "Plugin Integrations", func = check_integrations },
    { name = "Performance", func = check_performance },
  }

  local total_errors = 0
  local total_warnings = 0

  for _, check in ipairs(checks) do
    local results = check.func()
    display_results(results, check.name)

    -- Count issues
    for _, result in ipairs(results) do
      if result.status == "error" then
        total_errors = total_errors + 1
      elseif result.status == "warn" then
        total_warnings = total_warnings + 1
      end
    end

    vim.list_extend(all_results, results)
  end

  -- Summary
  print(string.format("\n=== Summary ==="))
  if total_errors == 0 and total_warnings == 0 then
    print("✅ Git configuration is healthy!")
  else
    print(string.format("Issues found: %d errors, %d warnings", total_errors, total_warnings))
    if total_errors > 0 then
      print("🔧 Address errors for optimal functionality")
    end
  end

  return all_results
end

-- Quick health check (essential checks only)
function M.quick_check()
  local git_ok = constants.get_git_executable() ~= nil
  local repo_ok = constants.is_git_repo()
  local plugins_ok = pcall(require, "gitsigns") and pcall(require, "neogit")

  if git_ok and repo_ok and plugins_ok then
    print("✅ Git setup is functional")
    return true
  else
    print("❌ Git setup has issues - run :GitHealthCheck for details")
    return false
  end
end

-- Auto health check on startup (if in git repo)
function M.auto_check()
  if constants.is_git_repo() then
    vim.defer_fn(function()
      if not M.quick_check() then
        vim.notify("Git setup issues detected. Run :GitHealthCheck", vim.log.levels.WARN)
      end
    end, 1000) -- Delay to let plugins load
  end
end

-- Setup health check system
function M.setup()
  -- Create user commands
  vim.api.nvim_create_user_command("GitHealthCheck", M.check_all, {
    desc = "Run comprehensive git plugin health check"
  })

  vim.api.nvim_create_user_command("GitQuickCheck", M.quick_check, {
    desc = "Run quick git plugin health check"
  })

  -- Auto-run health check
  M.auto_check()

  vim.notify("Git health check system loaded", vim.log.levels.DEBUG)
end

return M
