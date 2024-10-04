-------------------------------------------------------------------------------
-- Laravel Plugin
-- https://github.com/adalessa/laravel.nvim
-- Enhance the development experience of Laravel projects.
-------------------------------------------------------------------------------

return {
  "adalessa/laravel.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "tpope/vim-dotenv",
    "MunifTanjim/nui.nvim",
    "nvimtools/none-ls.nvim",
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
  config = true,
}
