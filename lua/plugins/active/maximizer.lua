-------------------------------------------------------------------------------
-- Maximizer Plugin
-- https://github.com/declancm/maximize.nvim
-------------------------------------------------------------------------------

return {
  'declancm/maximize.nvim',
  config = true,


  ---------------------------------------------------------------------------
  ----- Key Mappings

  vim.keymap.set("n", "<leader>m", "<cmd>Maximize<CR>"),  -- Toggle minimize/maximize a split.
}

