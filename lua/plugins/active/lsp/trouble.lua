-------------------------------------------------------------------------------
-- Trouble Plugin
-- https://github.com/folke/trouble.nvim
-- Display and work on all linter issues.
-------------------------------------------------------------------------------

return {
  "folke/trouble.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "artemave/workspace-diagnostics.nvim",
  },
  opts = {
    use_diagnostic_signs = true,
    focus                = true,
  }, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",


  -----------------------------------------------------------------------------
  --- Key Mappings

  keys = {
    {
      "<leader>xx", function()
        local exclude = {
          copilot = true,
          null_ls = true,
        }

        for _, client in ipairs(vim.lsp.get_clients()) do
          if not exclude[client.name] then
            require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
          end
        end
        require("trouble").toggle("diagnostics")
      end, desc = "Populate Workspace Diagnostics and Toggle Trouble",

      -- "<leader>xx", function() -- Run workspace diagnostics, then toggle trouble.
      --   for _, client in ipairs(vim.lsp.get_clients()) do
      --     require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
      --   end
      --   require("trouble").toggle("diagnostics")
      -- end, desc = "Populate Workspace Diagnostics and Toggle Trouble",
    },
    -- { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)", },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)", },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)", },
    { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)", },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)", },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)", },
  },
}

