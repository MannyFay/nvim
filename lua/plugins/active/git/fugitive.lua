-------------------------------------------------------------------------------
-- Vim Fugitive Plugin
-- https://github.com/tpope/vim-fugitive
-- Git wrapper for Vim/Neovim.
-------------------------------------------------------------------------------

return {
  "tpope/vim-fugitive",
  config = function()
    ---------------------------------------------------------------------------
    --- Key Mappings
    
    vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { noremap = true, silent = true, desc = "Git blame" })
  end,
}

