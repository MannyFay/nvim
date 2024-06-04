-- Insert this to your Packer plugins file:

--------------------------------------------------------------
-- Autosave files by go to normal mode or change buffer

-- use({
--   'pocco81/auto-save.nvim',                                                   -- https://github.com/Pocco81/auto-save.nvim
--   config = function()
--     require('user.plugin_options.auto-save')
--   end
-- })




-------------------------------------------------------------------------------
-- Auto-Save Plugin
-- https://github.com/Pocco81/auto-save.nvim
-------------------------------------------------------------------------------

-- Import Auto-Save plugin with a protected call:
local auto_save_status_ok, auto_save = pcall(require, 'auto-save')
if not auto_save_status_ok then
  return "Error: Auto-Save Plugin could not be loaded. Sure you have installed it in your plugins file?"
end


------------------------------------------------------------
-- Appearance

auto_save.setup {
  enabled           = true,                               -- Enable plugin.
  execution_message = {
    message = function()
      return ("Saved at " .. vim.fn.strftime("%H:%M:%S")) -- Message to print on save.
    end,
    dim               = 0.18,                             -- Dim the color of `message`.
    cleaning_interval = 1250,                             -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
  },
  trigger_events = {                                      -- Vim events that trigger auto-save. See :h events
    'InsertLeave',
    'TextChanged'
  },

  -- Function that determines whether to save the current buffer or not (true: if buffer is ok to be saved. false: if it's not ok to be saved.
  condition = function(buf)
    local fn    = vim.fn
    local utils = require("auto-save.utils.data")

    if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {"harpoon"}) then
      return true
    end
      return false
  end,


  -- Writing behavior:
  write_all_buffers = true,       -- Write all buffers when the current one meets `condition`.
  debounce_delay    = 135,        -- Saves the file at most every `debounce_delay` milliseconds.
  callbacks = {                   -- Functions to be executed at different intervals.
    enabling              = nil,  -- Ran when enabling auto-save.
    disabling             = nil,  -- Ran when disabling auto-save.
    before_asserting_save = nil,  -- Ran before checking `condition`.
    before_saving         = nil,  -- Ran before doing the actual save.
    after_saving          = nil,  -- Ran after doing the actual save.
  },
}
