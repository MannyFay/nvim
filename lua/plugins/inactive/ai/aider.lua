-------------------------------------------------------------------------------
-- Aider Plugin
-- https://github.com/joshuavial/aider.nvim
-- AI pair programming with OpenAI - Claude Code alternative for work.
-------------------------------------------------------------------------------

return {
  "joshuavial/aider.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local aider = require("aider")

    aider.setup({
      -- Auto-scroll terminal to bottom on output
      auto_manage_context = true,

      -- Default to opening in a vertical split
      default_bindings = false,

      -- Use dark mode for better integration
      dark_mode = true,
    })


    ---------------------------------------------------------------------------
    ----- Key Mappings

    -- Toggle Aider (similar to Claude Code with <C-,>)
    vim.keymap.set('n', '<C-.>', ':AiderOpen<CR>', { desc = 'Open Aider' })
    vim.keymap.set('t', '<C-.>', '<C-\\><C-n>:AiderOpen<CR>', { desc = 'Toggle Aider from terminal' })

    -- Add current file to Aider context
    vim.keymap.set('n', '<leader>aa', ':AiderAddFile<CR>', { desc = 'Add file to Aider' })

    -- Add current buffer content as context
    vim.keymap.set('n', '<leader>ab', ':AiderAddBuffer<CR>', { desc = 'Add buffer to Aider' })

    -- Send visual selection to Aider
    vim.keymap.set('v', '<leader>as', ':AiderSend<CR>', { desc = 'Send selection to Aider' })

    -- Background Aider (run in background)
    vim.keymap.set('n', '<leader>aB', ':AiderBackground<CR>', { desc = 'Aider in background' })
  end
}
