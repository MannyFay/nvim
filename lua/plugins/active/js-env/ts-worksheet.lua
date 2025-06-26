-------------------------------------------------------------------------------
-- TypeScript Worksheet Plugin
-- https://github.com/typed-rocks/ts-worksheet-neovim
-- Live TypeScript/JavaScript evaluation in Neovim
-------------------------------------------------------------------------------

return {
  "typed-rocks/ts-worksheet-neovim",

  -- Lazy loading configuration
  cmd = { "Tsw" },                    -- Load when :Tsw command is used
  ft = {
    "typescript",
    "javascript",
    "typescriptreact",                     -- .tsx files
    "javascriptreact"                      -- .jsx files
  },

  -- Plugin configuration
  opts = {
    type = vim.diagnostic.severity.INFO, -- Use INFO level for hints (less intrusive)
  },

  -- Key mappings (optional)
  keys = {
    {
      "<leader>tw",
      "<cmd>Tsw<cr>",
      desc = "Run TypeScript Worksheet",
      ft = { "typescript", "javascript" },
    },
    {
      "<leader>twv",
      "<cmd>Tsw show_variables=true<cr>",
      desc = "Run TS Worksheet with variables",
      ft = { "typescript", "javascript" },
    },
    {
      "<leader>twd",
      "<cmd>Tsw rt=deno<cr>",
      desc = "Run TS Worksheet with Deno",
      ft = { "typescript", "javascript" },
    },
    {
      "<leader>twb",
      "<cmd>Tsw rt=bun<cr>",
      desc = "Run TS Worksheet with Bun",
      ft = { "typescript", "javascript" },
    },
  },

  -- Dependencies
  dependencies = {
    "nvim-lua/plenary.nvim", -- Usually needed for file operations
  },

  -- Post-installation setup
  config = function(_, opts)
    require("ts-worksheet").setup(opts)

    -- Optional: Setup custom autocmds or additional configuration
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "typescript", "javascript" },
      callback = function()
        -- Custom setup per TypeScript/JavaScript buffer
        vim.api.nvim_buf_set_var(0, "ts_worksheet_enabled", true)
      end,
    })
  end,
}
