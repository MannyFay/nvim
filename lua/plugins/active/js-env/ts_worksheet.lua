-------------------------------------------------------------------------------
-- TypeScript Worksheet Plugin
-- https://github.com/typed-rocks/ts-worksheet-neovim
-- Live TypeScript/JavaScript evaluation in Neovim
-------------------------------------------------------------------------------



return {
  "typed-rocks/ts-worksheet-neovim",
  opts = {
    severity = vim.diagnostic.severity.WARN,
  },
  config = function(_, opts)
    require("tsw").setup(opts)
  end
}

