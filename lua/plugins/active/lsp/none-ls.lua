-------------------------------------------------------------------------------
-- None-LS Plugin
-- https://github.com/nvimtools/none-ls.nvim
-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
-- Inject LSP diagnostics, code actions, and more.
-------------------------------------------------------------------------------

return {
  "nvimtools/none-ls.nvim",
  event        = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  config       = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Code actions:
        null_ls.builtins.code_actions.gitsigns,    -- Code actions for Git operations at cursor position.
        null_ls.builtins.code_actions.refactoring, -- Code actions for refactoring operations at cursor position.

        -- Linters:
        null_ls.builtins.completion.spell,
        null_ls.builtins.code_actions.textlint,            -- Linter for text and Markdown.
        null_ls.builtins.diagnostics.actionlint,           -- Linter for GitHub Actions workflow files.
        null_ls.builtins.diagnostics.ansiblelint,          -- Linter for Ansible files.
        null_ls.builtins.diagnostics.checkmake,            -- Linter for Makefiles.
        null_ls.builtins.diagnostics.checkstyle.with({     -- Linter for Java.
          extra_args = { "-c", "/google_checks.xml" },     -- or "/sun_checks.xml" or path to self written rules
        }),
        null_ls.builtins.diagnostics.codespell,            -- Linter for spelling mistakes.
        null_ls.builtins.diagnostics.commitlint,           -- Linter for commit messages.
        null_ls.builtins.diagnostics.cppcheck,             -- Linter for C++.
        null_ls.builtins.diagnostics.djlint,               -- HTML template linter and formatter.
        null_ls.builtins.diagnostics.dotenv_linter,        -- Linter for .env files.
        null_ls.builtins.diagnostics.editorconfig_checker, -- Linter for EditorConfig files.
        null_ls.builtins.diagnostics.hadolint,             -- Linter for Dockerfiles.
        null_ls.builtins.diagnostics.markdownlint,         -- Linter for Markdown.
        null_ls.builtins.diagnostics.phpcs,                -- Linter for PHP.
        null_ls.builtins.diagnostics.pylint,               -- Linter for Python.
        null_ls.builtins.diagnostics.shellcheck,           -- Linter for shell scripts.
        null_ls.builtins.diagnostics.spectral,             -- Linter for JSON, YAML, OpenAPI files.
        null_ls.builtins.diagnostics.sqlfluff.with({       -- Linter for SQL.
          extra_args = { "--dialect", "mssql" },           -- change to your dialect
        }),
        null_ls.builtins.diagnostics.stylelint,            -- Linter for CSS, SCSS, Sass, and Less.
        null_ls.builtins.diagnostics.stylint,              -- Linter for CSS pre-processors.
        null_ls.builtins.diagnostics.swiftlint,            -- Linter for Swift.
        null_ls.builtins.diagnostics.tidy,                 -- Clean and fix HTML and XML.
        null_ls.builtins.diagnostics.twigcs,               -- Linter for Twig.
        null_ls.builtins.diagnostics.vacuum,               -- Linter for OpenAPI files.
        null_ls.builtins.diagnostics.vint,                 -- Linter for Vim script.
        null_ls.builtins.diagnostics.zsh,                  -- Linter for Zsh scripts.
        require("none-ls.diagnostics.eslint_d"),           -- requires none-ls-extras.nvim
        require("none-ls.diagnostics.yamllint"),           -- Linter for YAML.
      },
    })
  end
}
