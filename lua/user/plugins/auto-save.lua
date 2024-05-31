--------------------------------------------------------------------------------
-- Auto-Save Plugin
-- https://github.com/okuuva/auto-save.nvim
--------------------------------------------------------------------------------

-- Autosave files by go to normal mode or change buffer

require {
	"okuuva/auto-save.nvim",
	cmd = "ASToggle",
	event = { "InsertLeave", "TextChanged" },
	config = function()
  execution_message = {
    enabled           = true,                               -- Enable plugin.
    message = function()
      return ("Saved at " .. vim.fn.strftime("%H:%M:%S")) -- Message to print on save.
    end,
    dim               = 0.18,                             -- Dim the color of `message`.
    cleaning_interval = 1250,                             -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
  },
--  trigger_events = { "InsertLeave", "TextChanged" },                                     -- Vim events that trigger auto-save. See :h events
--    immediate_events = { "BufLeave", "FocusLost" },
--    defer_save = { "InsertLeave", "TextChanged" },
--    cancel_defered_save = { "InsertEnter" },

  -- Import Auto-Save plugin with a protected call:
--  local auto_save_status_ok, auto_save = pcall(require, 'auto-save')
--  if not auto_save_status_ok then
--    return "Error: Auto-Save Plugin could not be loaded. Sure you have installed it in your plugins file?"
--  end

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
	end,
}