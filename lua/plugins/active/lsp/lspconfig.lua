-------------------------------------------------------------------------------
-- LSP Config Plugin
-- https://github.com/neovim/nvim-lspconfig
-- Language Server Protocol client configurations for various LSP servers.
-------------------------------------------------------------------------------

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "mason.nvim", config = true },
    { "williamboman/mason-lspconfig.nvim", config = true },
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
    "artemave/workspace-diagnostics.nvim",
  },

  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()

    ---------------------------------------------------------------------------
    -- LSP Attach Keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(ev)
        local keymap = vim.keymap
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

        -- Code actions
        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        -- Diagnostics
        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)
        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)

        -- Help and documentation
        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)
        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })



    ---------------------------------------------------------------------------
    -- Diagnostic Highlighting

    -- Diagnostic signs in the gutter column:
    local diagnostic_signs = {
      Error = " ",
      Warn  = " ",
      Hint  = " ",
      Info  = " ",
    }

    -- Activate the diagnostic signs in the gutter column:
    for type, icon in pairs(diagnostic_signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Diagnostic virtual text configuration:
    vim.diagnostic.config({
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
    -- Helper function for workspace diagnostics

    local function setup_workspace_diagnostics(client, bufnr)
      if client.name ~= "copilot" then
        require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
      end
    end



    ---------------------------------------------------------------------------
    -- Mason LSP Setup Handlers

    if mason_lspconfig.setup_handlers then
      mason_lspconfig.setup_handlers({

        -- Default handler for all LSP servers:
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = setup_workspace_diagnostics,
          })
        end,

        -- Tailwind CSS:
        ["tailwindcss"] = function()
          lspconfig["tailwindcss"].setup({
            capabilities = capabilities,
            on_attach = setup_workspace_diagnostics,
            filetypes = {
              "html", "css", "scss", "javascript", "javascriptreact",
              "typescript", "typescriptreact", "svelte"
            },
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
        end,

        -- Svelte:
        ["svelte"] = function()
          lspconfig["svelte"].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              setup_workspace_diagnostics(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = { "*.js", "*.ts" },
                callback = function(ctx)
                  client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                end,
              })
            end,
          })
        end,

        -- GraphQL:
        ["graphql"] = function()
          lspconfig["graphql"].setup({
            capabilities = capabilities,
            on_attach = setup_workspace_diagnostics,
            filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
          })
        end,

        -- Emmet:
        ["emmet_ls"] = function()
          lspconfig["emmet_ls"].setup({
            capabilities = capabilities,
            on_attach = setup_workspace_diagnostics,
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
          })
        end,

        -- Lua:
        ["lua_ls"] = function()
          lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = setup_workspace_diagnostics,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                  unusedLocalExclude = { "_*" },
                },
                completion = { callSnippet = "Replace" },
                workspace = {
                  checkThirdParty = false,
                },
                telemetry = { enable = false },
              },
            },
          })
        end,

        -- PHP:
        ["intelephense"] = function()
          lspconfig["intelephense"].setup({
            capabilities = capabilities,
            on_attach = setup_workspace_diagnostics,
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
        end,

        -- CSS:
        ["cssls"] = function()
          lspconfig["cssls"].setup({
            capabilities = capabilities,
            on_attach = setup_workspace_diagnostics,
            filetypes = { "css", "scss", "less", "sass" },
            settings = {
              css = { validate = true, lint = { unknownAtRules = "ignore" } },
              scss = { validate = true, lint = { unknownAtRules = "ignore" } },
              less = { validate = true, lint = { unknownAtRules = "ignore" } },
            },
          })
        end,

        -- Ansible:
        ["ansiblels"] = function()
          lspconfig["ansiblels"].setup({
            capabilities = capabilities,
            on_attach = setup_workspace_diagnostics,
            filetypes = { "yaml", "yml", "ansible" },
          })
        end,

        -- YAML:
        ["yamlls"] = function()
          lspconfig["yamlls"].setup({
            capabilities = capabilities,
            on_attach = setup_workspace_diagnostics,
            filetypes = { "yaml", "yml" },
          })
        end,

        -- Bash:
        ["bashls"] = function()
          lspconfig["bashls"].setup({
            capabilities = capabilities,
            on_attach = setup_workspace_diagnostics,
            filetypes = { "sh", "bash", "zsh", "fish", "dash", "ksh" },
          })
        end,

        -- Volar (Vue Language Server):
        -- DISABLED: Conflicts with typescript-tools.nvim
        -- Uncomment this handler and comment out typescript-tools if you need Vue support
        -- ["volar"] = function()
        --   lspconfig["volar"].setup({
        --     capabilities = capabilities,
        --     on_attach = setup_workspace_diagnostics,
        --     filetypes = { "vue" },
        --     init_options = {
        --       typescript = {
        --         tsdk = vim.fn.expand("~/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib"),
        --       },
        --       vue = {
        --         hybridMode = false,
        --       },
        --     },
        --   })
        -- end,
      })
    end

    -- ESLint disabled - using Biome instead
    -- lspconfig.eslint.setup({
    --   capabilities = capabilities,
    --   settings = { packageManager = "yarn" },
    --   on_attach = function(client, bufnr)
    --     setup_workspace_diagnostics(client, bufnr)
    --     vim.api.nvim_create_autocmd("BufWritePre", {
    --       buffer = bufnr,
    --       command = "EslintFixAll",
    --     })
    --   end,
    -- })
  end,
}

