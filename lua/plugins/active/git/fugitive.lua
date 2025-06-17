-------------------------------------------------------------------------------
-- Vim Fugitive Plugin
-- https://github.com/tpope/vim-fugitive
-- Advanced Git operations to compare, browse, edit Git objects, and more.
-------------------------------------------------------------------------------

return {
  "tpope/vim-fugitive",


  ---------------------------------------------------------------------------
  --- Key Mappings

  vim.api.nvim_buf_set_keymap( 0, "n", "<leader>gb", ":Git blame<CR>", { noremap = true, silent = true, nowait = true }),  -- Open Git blame window.
}

