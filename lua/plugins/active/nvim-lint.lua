-------------------------------------------------------------------------------
-- nvim-lint Plugin
-- https://github.com/mfussenegger/nvim-lint
-- Asynchronous linter plugin for Neovim.
-------------------------------------------------------------------------------

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      sh                     = { "shellcheck" },
      bash                   = { "shellcheck" },
      zsh                    = { "shellcheck" },
      yaml                   = { "yamllint" },
      python                 = { "pylint" },
      php                    = { "phpstan" },
      java                   = { "checkstyle" },
      cmake                  = { "cmakelint" },
      dockerfile             = { "hadolint" },
      markdown               = { "markdownlint" },
      css                    = { "stylelint" },
      scss                   = { "stylelint" },
      less                   = { "stylelint" },
      ansible                = { "ansible_lint" },
      ["yaml.ansible"]       = { "ansible_lint" },
      ["yaml.githubaction"]  = { "actionlint" },
    }

    -- Actionlint for GitHub workflow files.
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = { ".github/workflows/*.yml", ".github/workflows/*.yaml" },
      callback = function()
        vim.bo.filetype = "yaml.githubaction"
      end,
    })

    -- Lint on these events.
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = function()
        lint.try_lint()
        lint.try_lint("codespell") -- Run codespell on all filetypes.
      end,
    })

    ---------------------------------------------------------------------------
    ----- Key Mappings

    vim.keymap.set("n", "<leader>ll", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
