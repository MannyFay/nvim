-------------------------------------------------------------------------------
-- Copilot Chat Plugin
-- https://github.com/CopilotC-Nvim/CopilotChat.nvim
-------------------------------------------------------------------------------


-- Import Copilot Chat plugin with a protected call:
local copilot_chat_status_ok, copilot_chat = pcall(require, 'CopilotChat')
if not copilot_chat_status_ok then
  return "Error: */lua/user/plugin_options/copilot-chat.lua -> Copilot Chat plugin could not be loaded. Sure you have installed it in your plugins file?"
end


------------------------------------------------------------
-- Copilot Chat Plugin

copilot_chat.setup({
  debug = true,
})
