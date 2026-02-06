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
        css             = { "biome", "prettierd", stop_after_first = true },
        graphql         = { "prettierd" },
        html            = { "prettierd" },
        json            = { "biome", "prettierd", stop_after_first = true },
        jsonc           = { "biome", "prettierd", stop_after_first = true },
        javascript      = { "biome", "prettierd", stop_after_first = true },
        javascriptreact = { "biome", "prettierd", stop_after_first = true },
        liquid          = { "prettierd" },
        lua             = { "stylua" },
        markdown        = { "prettierd" },
        python          = { "isort", "black", stop_after_first = true },
        sh              = { "shfmt" },
        bash            = { "shfmt" },
        zsh             = { "shfmt" },
        svelte          = { "prettierd" },
        typescript      = { "biome", "prettierd", stop_after_first = true },
        typescriptreact = { "biome", "prettierd", stop_after_first = true },
        yaml            = { "prettierd" },
        ["*"]           = { "trim_whitespace" },
      },
      notify_on_error      = false, -- Conform will notify you when a formatter errors.
      quiet                = true,  -- Conform will suppress all output if quiet is true.
      notify_no_formatters = true,  -- Conform will notify you when no formatters are available for the buffer.
      formatters           = {
        -- Biome: Use if biome.json exists in project.
        biome = {
          condition = function()
            return vim.fs.find({ "biome.json", "biome.jsonc" }, {
              upward = true,
              path = vim.api.nvim_buf_get_name(0),
            })[1] ~= nil
          end,
        },
        -- Prettierd: Fallback for projects using Prettier.
        prettierd = {
          condition = function()
            return vim.fs.find({
              ".prettierrc",
              ".prettierrc.js",
              ".prettierrc.cjs",
              ".prettierrc.mjs",
              ".prettierrc.json",
              ".prettierrc.yaml",
              ".prettierrc.yml",
              ".prettierrc.toml",
              "prettier.config.js",
              "prettier.config.cjs",
              "prettier.config.mjs",
            }, {
              upward = true,
              path = vim.api.nvim_buf_get_name(0),
            })[1] ~= nil
          end,
        },
      },
      log_level = vim.log.levels.DEBUG,
    })


    ---------------------------------------------------------------------------
    --- Format on Save

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("ConformAutoFormat", { clear = true }),
      callback = function(args)
        if vim.api.nvim_buf_is_valid(args.buf) and vim.bo[args.buf].modifiable and vim.bo[args.buf].buftype == "" then
          require("conform").format({
            bufnr = args.buf,
            lsp_fallback = true,
            async = false,
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
