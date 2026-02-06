-------------------------------------------------------------------------------
-- Mason Plugin
-- https://github.com/williamboman/mason.nvim
-- Easily install and manage LSP servers, DAP servers, linters, and formatters.
-------------------------------------------------------------------------------

vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
vim.env.PATH = vim.fn.exepath("node"):match("(.+)/[^/]+$") .. ":" .. vim.env.PATH

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "neovim/nvim-lspconfig",
  },
  cmd = "Mason",
  config = function()
    local mason                = require("mason")                -- Import plugin.
    local mason_lspconfig      = require("mason-lspconfig")      -- Import mason-lspconfig.
    local mason_tool_installer = require("mason-tool-installer") -- Import mason-tool-installer.


    ---------------------------------------------------------------------------
    --- Mason Settings

    mason.setup({
      ui = { -- UI of Mason floating window.
        icons = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
        check_outdated_packages_on_open = true,
        border                          = "none",
        backdrop                        = 0,
        width                           = 0.8,
        height                          = 0.9,
      },
    })


    ---------------------------------------------------------------------------
    --- Mason LSP Config Settings

    mason_lspconfig.setup({
      automatic_installation = true,
      ensure_installed = {                 -- List of LSP servers for mason to install.
        -- 'angularls',                       -- Angular language server (temporarily disabled - not recognized by mason-lspconfig).
        'ansiblels',                       -- Ansible language server.
        'arduino_language_server',         -- Arduino language server.
        'azure_pipelines_ls',              -- Azure Pipelines language server.
        'bashls',                          -- Bash language server.
        'clangd',                          -- C, C++, Objective-C language server.
        'cmake',                           -- CMake language server.
        'cssls',                           -- CSS language server.
        'cucumber_language_server',        -- Cucumber language server.
        --'denols',                           -- Deno language server.
        'diagnosticls',                    -- Diagnostic Node.js and Composer server.
        'docker_compose_language_service', -- Docker Compose Language Server.
        'dockerls',                        -- Docker language server.
        'emmet_ls',                        -- Emmet HTML completion server.
        'gradle_ls',                       -- Gradle language server.
        'grammarly',                       -- Grammarly spell checker server.
        'graphql',                         -- GraphQL language server.
        --'hls',                              -- Haskell language server.
        'html',                            -- HTML language server.
        --'htmx',                             -- HTMX language server.
        'intelephense',                    -- PHP language server.
        'jdtls',                           -- Java language server.
        'jsonls',                          -- JSON language server.
        'kotlin_language_server',          -- Kotlin language server.
        'lemminx',                         -- XML language server.
        'ltex',                            -- LaTeX language server.
        'lua_ls',                          -- Lua language server.
        --'autotools_ls',                     -- Make language server.
        'marksman',                        -- Markdown language server.
        'matlab_ls',                       -- MATLAB language server.
        --'pest_ls',                          -- Pest PHP testing framework language server.
        'powershell_es',                   -- PowerShell language server.
        'prismals',                        -- Prisma language server.
        "psalm",                           -- Psalm PHP static analysis tool.
        'pyright',                         -- Python language server.
        --'r_language_server',                -- R language server.
        --'ruby_ls',                          -- Ruby language server.
        'rust_analyzer', -- Rust language server.
        --'salt_ls',                          -- SaltStack language server.
        'spectral',      -- Spectral OpenAPI linter.
        'sqlls',         -- SQL language server.
        'svelte',        -- Svelte language server.
        'tailwindcss',   -- Tailwind CSS language server.
        'taplo',         -- TOML language server.
        'terraformls',   -- Terraform language server.
        -- 'ts_ls',         -- JavaScript/TypeScript language server (disabled - using typescript-tools instead).
        -- 'tsserver',                           -- JavaScript/TypeScript language server (disabled - using typescript-tools instead).
        -- 'volar',  -- Vue language server (disabled - conflicts with typescript-tools).
        'yamlls', -- YAML language server.
        --'nginx_language_server',            -- NGINX language server.
        'vimls',  -- Vim language server.
        -- 'twigcs',                           -- Twig language server.
        -- 'php-debug-adapter',              -- PHP Debug Adapter.
      },
    })


    ---------------------------------------------------------------------------
    --- Mason Linter & Formatter Settings

    mason_tool_installer.setup({
      ensure_installed = {

        ----- Linters:
        "actionlint",           -- GitHub Actions linter.
        "ansible-lint",         -- Ansible linter.
        --"bacon",      -- Rust linter.
        "checkstyle",           -- Java linter.
        "cmakelint",            -- CMake linter.
        "codespell",            -- Check code for common misspellings.
        "commitlint",           -- Checks commit messages format.
        'editorconfig-checker', -- EditorConfig checker.
        -- "eslint-lsp",           -- JavaScript, TypeScript linter.
        "phpstan",              -- PHP linter.
        "pylint",               -- Python linter.
        "shellcheck",           -- Shell script linter.
        "yamllint",             -- YAML linter.

        ----- Formatters:
        "biome",           -- Fast JS/TS/JSON formatter.
        "black",           -- Python formatter.
        "blade-formatter", -- Laravel Blade formatter.
        "prettierd",          -- Prettier formatter (fallback for non-Biome projects).
        --"stylua",           -- Lua formatter.
        "isort",           -- Python formatter.
        "pint",            -- PHP formatter.
        "shfmt",           -- Shell script formatter.
        "vacuum",          -- OpenAPI formatter.
        "yamlfix",         -- YAML formatter.
      },
    })
  end,
}

