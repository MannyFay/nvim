-------------------------------------------------------------------------------
-- Workspace Diagnostics Plugin
-- https://github.com/artemave/workspace-diagnostics.nvim
-- Populates project-wide lsp diagnostics, regardless of what files are opened.
-------------------------------------------------------------------------------

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
      -- Add any other configuration options as needed.
    })

    -- Automatically populate diagnostics when the LSP client attaches:
    local function on_attach(client, bufnr)
      workspace_diagnostics.populate_workspace_diagnostics(client, bufnr)
    end

    -- Auto-command for Lsp-Attach to call on_attach:
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("WorkspaceDiagnosticsGroup", {}),
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client then
          on_attach(client, ev.buf)
        end
      end,
    })


    ---------------------------------------------------------------------------
    --- Key Mappings

    vim.api.nvim_set_keymap('n', '<space>x', '', {
      noremap = true,
      callback = function()
        for _, client in ipairs(vim.lsp.get_clients()) do
          require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
        end
      end,
      desc = "Populate workspace diagnostics"
    })
  end,
}

