-------------------------------------------------------------------------------
-- Laravel Plugin
-- https://github.com/adalessa/laravel.nvim
-------------------------------------------------------------------------------

-- Import Auto-Save plugin with a protected call:
local laravel_status_ok, laravel = pcall(require, 'laravel')
if not laravel_status_ok then
  return "Error: Auto-Save Plugin could not be loaded. Sure you have installed it in your plugins file?"
end


------------------------------------------------------------
-- Appearance

laravel.setup {
  cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
  keys = {
    { "<leader>la", ":Laravel artisan<cr>" },
    { "<leader>lr", ":Laravel routes<cr>" },
    { "<leader>lm", ":Laravel related<cr>" },
  },
}