-------------------------------------------------------------------------------
-- Vim Fugitive Plugin
-- https://github.com/tpope/vim-fugitive
-- Advanced Git operations to compare, browse, edit Git objects, and more.
-------------------------------------------------------------------------------

return {
  "tpope/vim-fugitive",
  config = function()
    ---------------------------------------------------------------------------
    --- Key Mappings
    
    vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { noremap = true, silent = true, desc = "Git blame" })
  end,
}

