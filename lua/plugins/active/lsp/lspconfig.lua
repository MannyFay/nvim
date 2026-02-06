-------------------------------------------------------------------------------
-- LSP Config Plugin (Neovim 0.11+ native API)
-- https://github.com/neovim/nvim-lspconfig
-- Language Server Protocol client configurations for various LSP servers.
-------------------------------------------------------------------------------

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },

  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()


    ---------------------------------------------------------------------------
    -- LSP Attach Keymaps

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        -- Navigation
        opts.desc = "Show LSP references"
        vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
        opts.desc = "Go to declaration"
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        opts.desc = "Show LSP definitions"
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
        opts.desc = "Show LSP implementations"
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
        opts.desc = "Show LSP type definitions"
        vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        -- Code actions
        opts.desc = "See available code actions"
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        opts.desc = "Smart rename"
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        -- Diagnostics
        opts.desc = "Show buffer diagnostics"
        vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
        opts.desc = "Show line diagnostics"
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        opts.desc = "Go to previous diagnostic"
        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)
        opts.desc = "Go to next diagnostic"
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)

        -- Help and documentation
        opts.desc = "Show documentation for what is under cursor"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        opts.desc = "Restart LSP"
        vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })



    ---------------------------------------------------------------------------
    -- Diagnostic Configuration

    local diagnostic_signs = {
      Error = " ",
      Warn  = " ",
      Hint  = " ",
      Info  = " ",
    }

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
          [vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
          [vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
          [vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
        },
      },
      virtual_text = {
        spacing = 4,
      },
      underline = {
        [vim.diagnostic.severity.ERROR] = true,
        [vim.diagnostic.severity.WARN] = true,
        [vim.diagnostic.severity.INFO] = true,
        [vim.diagnostic.severity.HINT] = true,
      },
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
      },
    })



    ---------------------------------------------------------------------------
    -- LSP Server Configurations (Neovim 0.11+ native API)

    -- Tailwind CSS:
    vim.lsp.config('tailwindcss', {
      capabilities = capabilities,
      filetypes = {
        "html", "css", "scss", "javascript", "javascriptreact",
        "typescript", "typescriptreact", "svelte",
      },
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              { "([\"'`][^\"'`]*.*?[\"'`])", "[\"'`]([^\"'`]*)" },
            },
          },
        },
      },
    })

    -- Svelte:
    vim.lsp.config('svelte', {
      capabilities = capabilities,
    })

    -- GraphQL:
    vim.lsp.config('graphql', {
      capabilities = capabilities,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })

    -- Emmet:
    vim.lsp.config('emmet_ls', {
      capabilities = capabilities,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })

    -- Lua:
    vim.lsp.config('lua_ls', {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
            unusedLocalExclude = { "_*" },
          },
          completion = { callSnippet = "Replace" },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    })

    -- PHP:
    vim.lsp.config('intelephense', {
      capabilities = capabilities,
      filetypes = { "php", "blade" },
      settings = {
        intelephense = {
          filetypes = { "php", "blade" },
          files = {
            associations = { "*.php", "*.blade.php" },
            maxSize = 5000000,
          },
        },
      },
    })

    -- CSS:
    vim.lsp.config('cssls', {
      capabilities = capabilities,
      filetypes = { "css", "scss", "less", "sass" },
      settings = {
        css = { validate = true, lint = { unknownAtRules = "ignore" } },
        scss = { validate = true, lint = { unknownAtRules = "ignore" } },
        less = { validate = true, lint = { unknownAtRules = "ignore" } },
      },
    })

    -- Ansible:
    vim.lsp.config('ansiblels', {
      capabilities = capabilities,
      filetypes = { "yaml.ansible", "ansible" },
    })

    -- YAML:
    vim.lsp.config('yamlls', {
      capabilities = capabilities,
      filetypes = { "yaml", "yml" },
    })

    -- Bash:
    vim.lsp.config('bashls', {
      capabilities = capabilities,
      filetypes = { "sh", "bash", "zsh", "fish", "dash", "ksh" },
    })

    -- ESLint:
    vim.lsp.config('eslint', {
      capabilities = capabilities,
      settings = { packageManager = "yarn" },
    })

    -- Biome (formatting disabled - handled by conform.nvim):
    vim.lsp.config('biome', {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "jsonc" },
      cmd = { "biome", "lsp-proxy" },
    })

    -- Enable all configured servers:
    vim.lsp.enable({
      'tailwindcss', 'svelte', 'graphql', 'emmet_ls', 'lua_ls',
      'intelephense', 'cssls', 'ansiblels', 'yamlls', 'bashls',
      'eslint', 'biome',
    })
  end,
}
