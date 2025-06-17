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
        blade           = { "blade-formatter" },
        css             = { "prettierd" },
        graphql         = { "prettierd" },
        html            = { "prettierd" },
        json            = { "prettierd" },
        javascript      = { "prettierd" },
        javascriptreact = { "prettierd" },
        liquid          = { "prettierd" },
        lua             = { "stylua" },
        markdown        = { "prettierd" },
        python          = { "isort", "black", stop_after_first = true },
        shell           = { "shfmt" },
        svelte          = { "prettierd" },
        typescript      = { "prettierd" },
        typescriptreact = { "prettierd" },
        yaml            = { "prettierd" },
        ["*"]           = { "trim_whitespace" },
      },
      -- format_on_save       = {
      --   lsp_fallback = true,
      --   async        = false,
      --   timeout_ms   = 10000,
      -- },
      notify_on_error      = false, -- Conform will notify you when a formatter errors.
      quiet                = true,  -- Conform will suppress all output if quiet is true.
      notify_no_formatters = true,  -- Conform will notify you when no formatters are available for the buffer.
      formatters           = {
        prettierd = {
          condition = function()
            return vim.loop.fs_realpath(".prettierrc.js") ~= nil or vim.loop.fs_realpath(".prettierrc.mjs") ~= nil
          end,
        },
      },
      log_level = vim.log.levels.DEBUG,
    })


    local group = vim.api.nvim_create_augroup("ConformAutoFormat", { clear = true })

    vim.api.nvim_create_autocmd({"BufEnter", "BufLeave"}, {
      group = group,
      callback = function(args)
        if vim.api.nvim_buf_is_valid(args.buf) and vim.bo[args.buf].modifiable and vim.bo[args.buf].buftype == "" then
          require("conform").format({
            bufnr = args.buf,
            lsp_fallback = true,
            async = true,
            timeout_ms = 10000,
          })
        end
      end,
    })

    ---------------------------------------------------------------------------
    ----- Key Mappings

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 10000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
