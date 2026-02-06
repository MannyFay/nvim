return {
  "artemave/workspace-diagnostics.nvim",
  event        = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "neovim/nvim-lspconfig",
    "folke/trouble.nvim",
  },
  config = function()
    local workspace_diagnostics = require("workspace-diagnostics")

    workspace_diagnostics.setup({
      workspace_files = function()                -- Customize this function to return project files.
        return vim.fn.systemlist("git ls-files")  -- Example to get files from Git.
      end,
      clients = {
        copilot = {
          filetypes = {
            "javascript",
            "typescript",
            "html",
            "css",
            "markdown",
            "yaml",
            "sh",
            "bash",
            "php",
            "lua",
          },
        },
      },
    })

    -- NOTE: Auto-loading on LspAttach is disabled because it blocks file opening
    -- in large projects (~10k files). Use <space>x to manually populate instead.


    ---------------------------------------------------------------------------
    --- Key Mappings

    vim.api.nvim_set_keymap('n', '<space>x', '', {
      noremap = true,
      callback = function()
        for _, client in ipairs(vim.lsp.get_clients()) do
          if client.name ~= "copilot" then
            require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
          end
        end
      end,
      desc = "Populate workspace diagnostics"
    })
  end,
}
