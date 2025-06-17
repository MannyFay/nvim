-------------------------------------------------------------------------------
-- Last Place Plugin
-- https://github.com/ethanholz/nvim-lastplace
-- Set cursor on the place where the file was leaved.
-------------------------------------------------------------------------------

return {
  "ethanholz/nvim-lastplace",
  config = function()
    local nvim_lastplace = require("nvim-lastplace")
    nvim_lastplace.setup({
      lastplace_ignore_buftype = {
        'quickfix',
        'nofile',
        'help'
      },
      lastplace_ignore_filetype = {
        'gitcommit',
        'gitrebase',
        'svn',
        'hgcommit'
      },
      lastplace_open_folds = true
    })
  end,
}
