-- lua/plugins/git/integrations/gitsigns.lua
-- Gitsigns integration with other git plugins

local M = {}
local constants = require("plugins.git.core.constants")

-- Integration with Neogit
local function setup_neogit_integration()
  local group = vim.api.nvim_create_augroup("GitsignsNeogitIntegration", { clear = true })

  -- Refresh gitsigns when neogit status changes
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = constants.events.neogit_refresh,
    callback = function()
      local ok, gitsigns = pcall(require, "gitsigns")
      if ok then
        gitsigns.refresh()
      end
    end,
  })

  -- Disable gitsigns blame when neogit status is open (avoid conflicts)
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = constants.events.neogit_refresh,
    callback = function()
      local ok, gitsigns = pcall(require, "gitsigns")
      if ok then
        -- Temporarily disable current line blame in neogit buffers
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.bo[buf].filetype == "NeogitStatus" then
            gitsigns.toggle_current_line_blame(false)
            break
          end
        end
      end
    end,
  })
end

-- Integration with Diffview
local function setup_diffview_integration()
  local group = vim.api.nvim_create_augroup("GitsignsDiffviewIntegration", { clear = true })

  -- Disable gitsigns when diffview is active to avoid conflicts
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = constants.events.diffview_opened,
    callback = function()
      local ok, gitsigns = pcall(require, "gitsigns")
      if ok then
        gitsigns.detach() -- Detach from all buffers temporarily
      end
    end,
  })

  -- Re-enable gitsigns when diffview is closed
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = constants.events.diffview_closed,
    callback = function()
      local ok, gitsigns = pcall(require, "gitsigns")
      if ok then
        gitsigns.attach() -- Re-attach to current buffer
        vim.schedule(function()
          gitsigns.refresh() -- Refresh signs
        end)
      end
    end,
  })
end

-- Integration with Git-Worktree
local function setup_worktree_integration()
  local group = vim.api.nvim_create_augroup("GitsignsWorktreeIntegration", { clear = true })

  -- Refresh gitsigns when switching worktrees
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = constants.events.worktree_changed,
    callback = function(event)
      local ok, gitsigns = pcall(require, "gitsigns")
      if ok then
        vim.schedule(function()
          gitsigns.refresh() -- Refresh all gitsigns
          -- Update git root for new worktree
          if event.data and event.data.path then
            vim.notify("Gitsigns updated for worktree: " .. event.data.path, vim.log.levels.INFO)
          end
        end)
      end
    end,
  })
end

-- Integration with Telescope for better git hunks picker
local function setup_telescope_integration()
  local ok, telescope = pcall(require, "telescope")
  if not ok then return end

  -- Custom telescope picker for git hunks
  local function git_hunks_picker()
    local ok_gs, gitsigns = pcall(require, "gitsigns")
    if not ok_gs then
      vim.notify("Gitsigns not available", vim.log.levels.WARN)
      return
    end

    local ok_builtin, builtin = pcall(require, "telescope.builtin")
    if not ok_builtin then
      vim.notify("Telescope builtin not available", vim.log.levels.WARN)
      return
    end

    -- Use telescope's git_status but with gitsigns integration
    builtin.git_status({
      attach_mappings = function(prompt_bufnr, map)
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        -- Stage hunk when pressing <CR>
        map("i", "<CR>", function()
          local selection = action_state.get_selected_entry()
          if selection then
            actions.close(prompt_bufnr)
            vim.cmd("edit " .. selection.value)
            gitsigns.stage_hunk()
          end
        end)

        -- Preview hunk when pressing <Tab>
        map("i", "<Tab>", function()
          local selection = action_state.get_selected_entry()
          if selection then
            vim.cmd("edit " .. selection.value)
            gitsigns.preview_hunk()
          end
        end)

        return true
      end,
    })
  end

  -- Create user command for git hunks picker
  vim.api.nvim_create_user_command("GitHunks", git_hunks_picker, {
    desc = "Telescope git hunks with gitsigns integration"
  })
end

-- Performance monitoring for gitsigns
local function setup_performance_monitoring()
  local group = vim.api.nvim_create_augroup("GitsignsPerformance", { clear = true })

  local start_time = nil

  -- Monitor gitsigns performance
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "GitSignsUpdate",
    callback = function()
      if start_time then
        local duration = vim.loop.hrtime() - start_time
        local ms = duration / 1000000 -- Convert to milliseconds

        if ms > 100 then -- Warn if gitsigns takes longer than 100ms
          vim.notify(
            string.format("Gitsigns update took %.2fms (slow)", ms),
            vim.log.levels.WARN
          )
        end
      end
      start_time = vim.loop.hrtime()
    end,
  })
end

-- Smart blame toggling based on context
local function setup_smart_blame()
  local blame_enabled = false

  -- Auto-disable blame in certain contexts
  local function auto_disable_blame()
    local filetype = vim.bo.filetype
    local should_disable = vim.tbl_contains({
      "NeogitStatus", "NeogitCommitMessage", "fugitive", "DiffviewFiles"
    }, filetype)

    if should_disable and blame_enabled then
      local ok, gitsigns = pcall(require, "gitsigns")
      if ok then
        gitsigns.toggle_current_line_blame(false)
        blame_enabled = false
      end
    end
  end

  local group = vim.api.nvim_create_augroup("GitsignsSmartBlame", { clear = true })
  vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
    group = group,
    callback = auto_disable_blame,
  })

  -- Track blame state
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "GitSignsUpdate",
    callback = function()
      local ok, gitsigns = pcall(require, "gitsigns")
      if ok then
        -- This is a simplified check - gitsigns doesn't expose blame state directly
        blame_enabled = vim.b.gitsigns_blame_line ~= nil
      end
    end,
  })
end

-- Main setup function
function M.setup()
  -- Set up all integrations
  setup_neogit_integration()
  setup_diffview_integration()
  setup_worktree_integration()
  setup_telescope_integration()
  setup_performance_monitoring()
  setup_smart_blame()

  -- Create integration health check command
  vim.api.nvim_create_user_command("GitsignsIntegrationStatus", function()
    local integrations = {
      { name = "Neogit", available = pcall(require, "neogit") },
      { name = "Diffview", available = pcall(require, "diffview") },
      { name = "Git-Worktree", available = pcall(require, "git-worktree") },
      { name = "Telescope", available = pcall(require, "telescope") },
    }

    print("Gitsigns Integration Status:")
    for _, integration in ipairs(integrations) do
      local status = integration.available and "✓" or "✗"
      local color = integration.available and "✓ Available" or "✗ Not Available"
      print(string.format("  %s %s", status, integration.name))
    end
  end, { desc = "Check gitsigns integration status" })

  vim.notify("Gitsigns integrations loaded", vim.log.levels.DEBUG)
end

return M
