-------------------------------------------------------------------------------
-- File: lspconfig.lua
-- Description: LSP configuration with mason-lspconfig integration
-- https://github.com/neovim/nvim-lspconfig
-------------------------------------------------------------------------------

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
    "artemave/workspace-diagnostics.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap

    -- Diagnostic configuration
    vim.diagnostic.config({
      virtual_text = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = " ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })


    -- LSP Attach
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        -- Navigation
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        -- Actions
        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        -- Diagnostics
        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        -- Fixed deprecated warnings
        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)

        -- Help
        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)
        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    -- Capabilities
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Configure individual servers
    local function default_on_attach(client, bufnr)
      require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
    end

    -- Tailwind CSS
    lspconfig["tailwindcss"].setup({
      capabilities = capabilities,
      on_attach = default_on_attach,
      filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" },
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              { "([\"'`][^\"'`]*.*?[\"'`])", "[\"'`]([^\"'`]*)" }
            },
          },
        },
      },
    })

    -- Svelte
    lspconfig["svelte"].setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        default_on_attach(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
          end,
        })
      end,
    })

    -- GraphQL
    lspconfig["graphql"].setup({
      capabilities = capabilities,
      on_attach = default_on_attach,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })

    -- Emmet
    lspconfig["emmet_ls"].setup({
      capabilities = capabilities,
      on_attach = default_on_attach,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })

    -- Lua
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = default_on_attach,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          completion = { callSnippet = "Replace" },
        },
      },
    })

    -- PHP
    lspconfig["intelephense"].setup({
      capabilities = capabilities,
      on_attach = default_on_attach,
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

    -- CSS
    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = default_on_attach,
      filetypes = { "css", "scss", "less", "sass" },
      settings = {
        css = { validate = true, lint = { unknownAtRules = "ignore" } },
        scss = { validate = true, lint = { unknownAtRules = "ignore" } },
        less = { validate = true, lint = { unknownAtRules = "ignore" } },
      },
    })

    -- Ansible
    lspconfig["ansiblels"].setup({
      capabilities = capabilities,
      on_attach = default_on_attach,
      filetypes = { "yaml", "yml", "ansible" },
    })

    -- YAML
    lspconfig["yamlls"].setup({
      capabilities = capabilities,
      on_attach = default_on_attach,
      filetypes = { "yaml", "yml" },
    })

    -- Bash
    lspconfig["bashls"].setup({
      capabilities = capabilities,
      on_attach = default_on_attach,
      filetypes = { "sh", "bash", "zsh", "fish", "dash", "ksh" },
    })

    -- Copilot (without workspace diagnostics)
    lspconfig["copilot"].setup({
      capabilities = capabilities,
    })

    -- ESLint
    lspconfig.eslint.setup({
      settings = { packageManager = "yarn" },
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
    })
  end,
}
