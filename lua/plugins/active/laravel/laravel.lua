-------------------------------------------------------------------------------
-- Laravel Plugin
-- https://github.com/adalessa/laravel.nvim
-- Enhance the development experience of Laravel projects.
-------------------------------------------------------------------------------

return {
  "adalessa/laravel.nvim",
  dependencies = {
    "tpope/vim-dotenv",
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
    "kevinhwang91/promise-async",
  },
  cmd = {
    "Sail",
    "Artisan",
    "Composer",
    "Npm",
    "Yarn",
    "Laravel"
  },
  keys = {
    { "<leader>la", ":Laravel artisan<cr>" },
    { "<leader>lr", ":Laravel routes<cr>" },
    { "<leader>lm", ":Laravel related<cr>" },
  },
  event = { "VeryLazy" },
  opts = {},
  config = true,
}
