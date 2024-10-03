-------------------------------------------------------------------------------
--- Peek Plugin
--- https://github.com/toppair/peek.nvim
--- Advanced markdown previewer
-------------------------------------------------------------------------------

return {
  "toppair/peek.nvim",
  event  = { "VeryLazy" },
  build  = "deno task --quiet build:fast",
  config = function()
    local peek = require("peek")


      -------------------------------------------------------------------------
      ----- Settings

      peek.setup({
        auto_load        = true,       -- Automatically open preview on entering markdown buffer.
        close_on_bdelete = true,       -- Close preview by closing buffer.
        syntax           = true,       -- Enable syntax highlighting (affects performance).
        theme            = 'dark',     -- Set theme of the preview (light, dark).
        update_on_change = true,       -- Update preview on text change.
        app              = 'browser',  -- Place to open preview (web-view, browser)

        -- File types to recognize as markdown:
        filetype = {
          'markdown',
          'md',
        },

        -- Preview update behavior:
        throttle_at   = 200000,        -- (bytes) Start throttling when file exceeds this amount of size.
        throttle_time = 'auto',        -- (milliseconds) Throttle time before starting new render.
      })



      -------------------------------------------------------------------------
      ----- Commands

      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})



      -------------------------------------------------------------------------
      ----- Key Mappings

      -- TODO: Find new key mappings this because m is min/max buffer.
      -- vim.keymap.set('n', '<Leader>mdo', ':PeekOpen<CR>')
      -- vim.keymap.set('n', '<Leader>mdq', ':PeekClose<CR>')

      -- Preview window commands (has to be focused):
      -- k = scroll up
      -- j = scroll down
      -- u = scroll half page up
      -- d = scroll half page down
      -- g = scroll to top
      -- G = scroll to bottom
  end,
}
