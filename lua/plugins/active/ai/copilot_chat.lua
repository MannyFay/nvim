-------------------------------------------------------------------------------
-- Copilot Chat Plugin
-- https://github.com/CopilotC-Nvim/CopilotChat.nvim
-- Copilot chat buffer.
-------------------------------------------------------------------------------

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch       = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim"  },  -- For curl, log wrapper.
    },
    build = "make tiktoken",
    opts  = {
      debug                    = false,                                             -- Enable debugging
      proxy                    = nil,                                               -- [protocol://]host[:port] Use this proxy
      allow_insecure           = false,                                             -- Allow insecure server connections
      -- system_prompt            = prompts.COPILOT_INSTRUCTIONS,                      -- System prompt to use
      model                    = 'gpt-4o',                                          -- GPT model to use, 'gpt-3.5-turbo', 'gpt-4', or 'gpt-4o'
      temperature              = 0.1,                                               -- GPT temperature
      question_header          = '## User ',                                        -- Header to use for user questions.
      answer_header            = '## Copilot ',                                     -- Header to use for AI answers.
      error_header             = '## Error ',                                       -- Header to use for errors.
      separator                = '───',                                             -- Separator to use in chat.
      show_folds               = false,                                             -- Shows folds for sections in chat.
      show_help                = true,                                              -- Shows help message as virtual lines when waiting for user input.
      auto_follow_cursor       = false,                                             -- Auto-follow cursor in chat.
      auto_insert_mode         = false,                                             -- Automatically enter insert mode when opening window and on new prompt.
      insert_at_end            = false,                                             -- Move cursor to end of buffer when inserting text.
      clear_chat_on_new_prompt = false,                                             -- Clears chat on every new prompt.
      highlight_selection      = true,                                              -- Highlight selection in the source buffer when in the chat window.
      context                  = nil,                                               -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
      history_path             = vim.fn.stdpath('data') .. '/copilotchat_history',  -- Default path to stored history
      callback                 = nil,                                               -- Callback to use when ask response is received
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      chat.setup(opts)

      ---------------------------------------------------------------------------
      -- Key Mappings

      vim.keymap.set('n', '<leader>cc', ':CopilotChat<CR>')  -- Open Copilot Chat
    end,
  },
}
