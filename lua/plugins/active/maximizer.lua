-------------------------------------------------------------------------------
-- Maximizer Plugin
-- https://github.com/declancm/maximize.nvim
-- Maximize and minimize splits through the whole screen.
-------------------------------------------------------------------------------

return {
  'declancm/maximize.nvim',
  config = true,


  -----------------------------------------------------------------------------
  --- Key Mappings

  vim.keymap.set("n", "<leader>m", "<cmd>Maximize<CR>"),  -- Toggle minimize/maximize a split.
}

