return {
  'MannyFay/mannydark.nvim',
  priority = 1000, -- Load scheme before all other plugins.
  config = function()
    vim.cmd [[
      try
        colorscheme mannydark
      catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme default
        set background=dark
      endtry
    ]]
  end,
}