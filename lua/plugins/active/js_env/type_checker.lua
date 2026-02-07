-------------------------------------------------------------------------------
-- TypeScript Type Checker Plugin
-- https://github.com/dmmulroy/tsc.nvim
-- TypeScript type checking.
-------------------------------------------------------------------------------

return {
  'dmmulroy/tsc.nvim',
  dependensies = {
    'folke/trouble.nvim',
  },
  config = function()
    local tsc = require('tsc')
    local utils = require('tsc.utils')

    tsc.setup({
      auto_open_qflist = false,
      auto_close_qflist = false,
      auto_focus_qflist = false,
      auto_start_watch_mode = true,  -- Start watch mode on open.
      use_trouble_qflist = true,  -- Use Trouble plugin as quickfix list.
      use_diagnostics = true,  -- Show errors also in Nvim-Tree.
      run_as_monorepo = false,
      bin_path = require('tsc.utils').find_tsc_bin(),
      enable_progress_notifications = false,
      enable_error_notifications = false,
      flags = {
        noEmit = true,  -- Run type-checker only.
        project = function()
          local configs = utils.find_nearest_tsconfig()
          return configs[1] or false
        end,
        watch = true,
      },
      hide_progress_notifications_from_history = true,
      spinner = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
      pretty_errors = true,
    })
  end,
}
