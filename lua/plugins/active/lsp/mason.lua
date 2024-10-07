-------------------------------------------------------------------------------
-- Mason Plugin
-- https://github.com/williamboman/mason.nvim
-- Easily install and manage LSP servers, DAP servers, linters, and formatters.
-------------------------------------------------------------------------------

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  cmd = "Mason",
  config = function()
    local mason                = require("mason")                 -- Import plugin.
    local mason_lspconfig      = require("mason-lspconfig")       -- Import mason-lspconfig.
    local mason_tool_installer = require("mason-tool-installer")  -- Import mason-tool-installer.


    ---------------------------------------------------------------------------
    --- Mason Settings

    mason.setup({
      ui = {                          -- UI of Mason floating window.
        icons = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
      },
    })


    ---------------------------------------------------------------------------
    --- Mason LSP Config Settings

    mason_lspconfig.setup({
      ensure_installed = {                  -- List of servers for mason to install.
        'angularls',                        -- Angular language server.
        'ansiblels',                        -- Ansible language server.
        'arduino_language_server',          -- Arduino language server.
        'azure_pipelines_ls',               -- Azure Pipelines language server.
        'bashls',                           -- Bash language server.
        'clangd',                           -- C, C++, Objective-C language server.
        'cmake',                            -- CMake language server.
        'cssls',                            -- CSS language server.
        'cucumber_language_server',         -- Cucumber language server.
        --'denols',                           -- Deno language server.
        'diagnosticls',                     -- Diagnostic Node.js and Composer server.
        'docker_compose_language_service',  -- Docker Compose Language Server.
        'dockerls',                         -- Docker language server.
        'emmet_ls',                         -- Emmet HTML completion server.
        'gradle_ls',                        -- Gradle language server.
        'grammarly',                        -- Grammarly spell checker server.
        'graphql',                          -- GraphQL language server.
        --'hls',                              -- Haskell language server.
        'html',                             -- HTML language server.
        --'htmx',                             -- HTMX language server.
        'intelephense',                     -- PHP language server.
        'jdtls',                            -- Java language server.
        'jsonls',                           -- JSON language server.
        'kotlin_language_server',           -- Kotlin language server.
        'lemminx',                          -- XML language server.
        'ltex',                             -- LaTeX language server.
        'lua_ls',                           -- Lua language server.
        --'autotools_ls',                     -- Make language server.
        'marksman',                         -- Markdown language server.
        'matlab_ls',                        -- MATLAB language server.
        --'pest_ls',                          -- Pest PHP testing framework language server.
        'powershell_es',                    -- PowerShell language server.
        'prismals',                         -- Prisma language server.
        "psalm",                            -- Psalm PHP static analysis tool.
        'pyright',                          -- Python language server.
        --'r_language_server',                -- R language server.
        --'ruby_ls',                          -- Ruby language server.
        'rust_analyzer',                    -- Rust language server.
        --'salt_ls',                          -- SaltStack language server.
        'spectral',                         -- Spectral OpenAPI linter.
        'sqlls',                            -- SQL language server.
        'svelte',                           -- Svelte language server.
        'tailwindcss',                      -- Tailwind CSS language server.
        'taplo',                            -- TOML language server.
        'terraformls',                      -- Terraform language server.
        'ts_ls',                           -- JavaScript/TypeScript language server.
        --'tsserver',                           -- JavaScript/TypeScript language server.
        'volar',                            -- Vue language server.
        'yamlls',                           -- YAML language server.
        --'editorconfig-checker',             -- EditorConfig checker.
        --'nginx_language_server',            -- NGINX language server.
        'vimls',                            -- Vim language server.
        -- 'twigcs',                           -- Twig language server.
        -- 'php-debug-adapter',              -- PHP Debug Adapter.
      },
    })


    ---------------------------------------------------------------------------
    --- Mason Linter & Formatter Settings

    mason_tool_installer.setup({
      ensure_installed = {

        ----- Linters:
        "actionlint",       -- GitHub Actions linter.
        "ansible-lint",     -- Ansible linter.
        --"bacon",            -- Rust linter.
        "checkstyle",       -- Java linter.
        "cmakelint",        -- CMake linter.
        "codespell",        -- Check code for common misspellings.
        "commitlint",       -- Checks commit messages format.
        "eslint-lsp",       -- JavaScript, TypeScript linter.
        "phpstan",          -- PHP linter.
        "pylint",           -- Python linter.

        ----- Formatters:
        "black",            -- Python formatter.
        "blade-formatter",  -- Laravel Blade formatter.
        "prettierd",        -- Prettier formatter.
        --"stylua",           -- Lua formatter.
        "isort",            -- Python formatter.
        "pint",             -- PHP formatter.
      },
    })



  end,
}

