-------------------------------------------------------------------------------
-- None-LS Plugin
-- https://github.com/neovim/nvim-lspconfig
-- Inject LSP diagnostics, code actions, and more.
-------------------------------------------------------------------------------

return {
  "nvimtools/none-ls.nvim",
  event        = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

  null_ls.setup({
      sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.completion.spell,
          require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
      },
  })
  end
}
