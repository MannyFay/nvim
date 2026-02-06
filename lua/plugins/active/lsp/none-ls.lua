-------------------------------------------------------------------------------
-- None-LS Plugin
-- https://github.com/nvimtools/none-ls.nvim
-- Inject LSP code actions (diagnostics handled by nvim-lint).
-------------------------------------------------------------------------------

return {
  "nvimtools/none-ls.nvim",
  event        = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config       = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Code actions:
        null_ls.builtins.code_actions.gitsigns,    -- Code actions for Git operations at cursor position.
        null_ls.builtins.code_actions.refactoring, -- Code actions for refactoring operations at cursor position.
      },
    })
  end
}
