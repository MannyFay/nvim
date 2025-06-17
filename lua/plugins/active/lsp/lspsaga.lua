-------------------------------------------------------------------------------
--- LSPsaga Plugin
--- https://nvimdev.github.io/lspsaga/
-------------------------------------------------------------------------------

return {
  'nvimdev/lspsaga.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons',     -- optional
  },
  config = function()
    local saga = require('lspsaga')
    local opts = { noremap = true, silent = true }
    local map = vim.keymap.set

    -- map('n', '<C')

    -- saga.init_lsp_saga {
    --   server_filetype_map = {},
    -- }

    saga.setup({})

    map('n', '<leader>sh', '<cmd>Lspsaga hover_doc<CR>', opts)
  end,
}
