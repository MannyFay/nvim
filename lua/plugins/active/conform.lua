-------------------------------------------------------------------------------
-- Conform Plugin
-- https://github.com/stevearc/conform.nvim
-- Lightweight yet powerful formatter plugin for Neovim.
-------------------------------------------------------------------------------

return {
  'stevearc/conform.nvim',
  opts = {},
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft     = {
        javascript      = { "prettierd" },
        typescript      = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        svelte          = { "prettierd" },
        css             = { "prettierd" },
        html            = { "prettierd" },
        json            = { "prettierd" },
        yaml            = { "prettierd" },
        markdown        = { "prettierd" },
        graphql         = { "prettierd" },
        liquid          = { "prettierd" },
        lua             = { "stylua" },
        python          = { "isort", "black" },
      },
      format_on_save       = {
        lsp_fallback = true,
        async        = false,
        timeout_ms   = 1000,
      },
      notify_on_error      = true, -- Conform will notify you when a formatter errors.
      notify_no_formatters = true, -- Conform will notify you when no formatters are available for the buffer.
    })


    ---------------------------------------------------------------------------
    ----- Key Mappings

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
