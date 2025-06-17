-------------------------------------------------------------------------------
-- Indent-Blankline Plugin
-- https://github.com/lukas-reineke/indent-blankline.nvim
-- Adds indentation guides to Neovim.
-------------------------------------------------------------------------------

return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  config = function()
    local indent_blankline = require("ibl")

-- Set up highlight groups:
local highlight = {
  'IndentBlanklineChar',
}

-- Pass colors to highlight groups:
local hooks = require('ibl.hooks')
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#252525' })
  vim.api.nvim_set_hl(0, 'hl-IblScope', { fg = '#606366' })
end)

indent_blankline.setup({
  indent = {
    char = '▏',
    highlight = highlight,
  },
  scope = {
    enabled            = true,   -- 'true': Highlight only the intended indentation and the current scope by an underline.
    show_start         = false,  -- Shows an underline on the first line of the scope.
    show_end           = false,  -- Shows an underline on the last line of the scope.
    show_exact_scope   = false,
    injected_languages = true,
  },
  exclude = {
    filetypes = {
      'help',
      'packer',
      'NvimTree',
      'Trouble',
      'dashboard',
      'TelescopePrompt',
      'TelescopeResults',
      'TelescopePreviewer',
      'lspinfo',
      'startify',
      'fugitive',
      'fugitiveblame',
      'gitcommit',
      'gitrebase',
      'svn',
      'hgcommit',
    },
    buftypes = {
      'terminal',
      'nofile',
      'quickfix',
      'prompt',
    },
  },
})
    end,

}
