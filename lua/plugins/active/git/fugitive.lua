-------------------------------------------------------------------------------
-- Vim Fugitive Plugin
-- https://github.com/tpope/vim-fugitive
-- Git wrapper for Vim/Neovim.
-------------------------------------------------------------------------------

return {
  "tpope/vim-fugitive",


  ---------------------------------------------------------------------------
  --- Key Mappings

  vim.api.nvim_buf_set_keymap( 0, "n", "<leader>gb", ":Git blame<CR>", { noremap = true, silent = true, nowait = true }),  -- Open Git blame window.
  vim.api.nvim_buf_set_keymap( 0, "n", "<leader>gs", ":G<CR>",         { noremap = true, silent = true, nowait = true }),  -- Open Git status window.
}
