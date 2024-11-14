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
    local tsconfig_path = utils.find_nearest_tsconfig() or false

    tsc.setup({
      auto_open_qflist = true,
      auto_close_qflist = false,
      auto_focus_qflist = false,
      auto_start_watch_mode = true,  -- Start watch mode on open.
      use_trouble_qflist = true,  -- Use Trouble plugin as quickfix list.
      use_diagnostics = true,  -- Show errors also in Nvim-Tree.
      run_as_monorepo = false,
      -- bin_path = utils.find_tsc_bin(),
      bin_path = require('tsc.utils').find_tsc_bin(),
      enable_progress_notifications = true,
      enable_error_notifications = true,
      flags = {
        noEmit = true,  -- Run type-checker only.
        -- project = function()
        --   return utils.find_nearest_tsconfig()
        -- end,
       project = tsconfig_path,
--           project = function()
--     local config = utils.find_nearest_tsconfig()
--     return config or false  -- Set to `false` if config is not found
--   end,
--         project = utils.find_nearest_tsconfig and function()
--   return utils.find_nearest_tsconfig()
-- end or false,
        watch = true,
      },
      hide_progress_notifications_from_history = true,
      spinner = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
      pretty_errors = true,
    })
  end,
}
