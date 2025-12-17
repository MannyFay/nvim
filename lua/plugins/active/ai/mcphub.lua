-------------------------------------------------------------------------------
-- Copilot Chat Plugin
-- https://github.com/ravitemer/mcphub.nvim?tab=readme-ov-file
-- Make Neovim a MCP Hub client.
-------------------------------------------------------------------------------



return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for HTTP requests
  },
  -- Optional: Lazy load only when command is called
  cmd = "MCPHub",

  -- Build step: Install required npm package globally
  build = "npm install -g mcp-hub@latest",

  config = function()
    require("mcphub").setup({
      -- MCP Hub Server Configuration
      port = 37373, -- Default port
      config = vim.fn.expand("~/.config/mcphub/servers.json"), -- Config file path

      -- Performance Settings
      shutdown_delay = 60 * 10 * 1000, -- 10 minutes before shutdown
      mcp_request_timeout = 60000, -- 1 minute timeout

      -- Auto-management
      auto_approve = false, -- Manually approve MCP tool calls
      auto_toggle_mcp_servers = true, -- Let LLMs start/stop servers

      -- UI Configuration
      ui = {
        window = {
          width = 0.8,
          height = 0.8,
          align = "center",
          border = "rounded",
        },
      },

      -- Logging
      log = {
        level = vim.log.levels.WARN,
        to_file = false,
      },

      -- Callbacks
      on_ready = function(hub)
        vim.notify("MCPHub is ready!", vim.log.levels.INFO)
      end,

      on_error = function(err)
        vim.notify("MCPHub error: " .. err, vim.log.levels.ERROR)
      end,
    })
  end,

  -- Optional: Add keymaps
  keys = {
    { "<leader>mh", "<cmd>MCPHub<cr>", desc = "Open MCPHub" },
  },
}

