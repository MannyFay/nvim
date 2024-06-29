return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        'angularls',                       -- Angular language server.
        'ansiblels',                       -- Ansible language server.
        'arduino_language_server',         -- Arduino language server.
        'azure_pipelines_ls',              -- Azure Pipelines language server.
        'bashls',                          -- Bash language server.
        'clangd',                          -- C, C++, Objective-C language server.
        'cmake',                           -- CMake language server.
        'cssls',                           -- CSS language server.
        'cucumber_language_server',        -- Cucumber language server.
        --'denols',                          -- Deno language server.
        'diagnosticls',                    -- Diagnostic Node.js and Composer server.
        'docker_compose_language_service', -- Docker Compose Language Server.
        'dockerls',                        -- Docker language server.
        'emmet_ls',                        -- Emmet HTML completion server.  -- emmet-language-server
        'gradle_ls',                       -- Gradle language server.
        'grammarly',                       -- Grammarly spell checker server.        "emmet_ls",
        'graphql',                         -- GraphQL language server.
        --'hls',                             -- Haskell language server.
        'html',                            -- HTML language server.
        --'htmx',                            -- HTMX language server.
        'intelephense',                    -- PHP language server.
        'jdtls',                           -- Java language server.
        'jsonls',                          -- JSON language server.
        'kotlin_language_server',          -- Kotlin language server.
        'lemminx',                         -- XML language server.
        'ltex',                            -- LaTeX language server.
        'lua_ls',                          -- Lua language server.
        --'autotools_ls',                    -- Make language server.
        'marksman',                        -- Markdown language server.
        'matlab_ls',                       -- MATLAB language server.
        --'pest_ls',                         -- Pest PHP testing framework language server.
        'powershell_es',                   -- PowerShell language server.
        "prismals",
        'prismals',                        -- Prisma language server.
        "psalm",
        'pyright',                         -- Python language server.
        --'r_language_server',               -- R language server.
        --'ruby_ls',                         -- Ruby language server.
        'rust_analyzer',                   -- Rust language server.
        --'salt_ls',                         -- SaltStack language server.
        'spectral',                        -- Spectral OpenAPI linter.
        'sqlls',                           -- SQL language server.
        'svelte',                          -- Svelte language server.
        'tailwindcss',                     -- Tailwind CSS language server.
        'taplo',                           -- TOML language server.
        'terraformls',                     -- Terraform language server.
        'tsserver',                        -- JavaScript/TypeScript language server.
        'volar',                           -- Vue language server.
        'yamlls',                          -- YAML language server.
        --'editorconfig-checker',            -- EditorConfig checker.
        --'nginx_language_server',           -- NGINX language server.
        'vimls',                           -- Vim language server.
        -- 'twigcs',                          -- Twig language server.
        -- 'pint',
        -- 'php-debug-adapter',
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "actionlint",  -- GitHub Actions linter.
        "ansible-lint",  -- Ansible linter.
        "bacon",  -- Rust linter.
        "blade-formatter",  -- Laravel Blade formatter.
        "checkstyle",  -- Java linter.
        "cmakelint",  -- CMake linter.
        "codespell",  -- Check code for common misspellings.
        "commitlint",  -- checks if your commit messages meet the conventional commit format. https://commitlint.js.org/
       -- "prettier", -- prettier formatter
       -- "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint",
        "eslint_d",
        "pint",
        "phpstan",
      },
    })
  end,
}
