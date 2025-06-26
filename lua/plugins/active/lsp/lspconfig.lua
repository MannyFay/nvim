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
  opts = {
    event = "BufReadPre",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()

    vim.diagnostic.config({
      virtual_text = true, -- optional: inline text
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN]  = " ",
          [vim.diagnostic.severity.HINT]  = " ",
          [vim.diagnostic.severity.INFO]  = " ",
        },
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })



    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local keymap = vim.keymap
        local opts = { buffer = ev.buf, silent = true }

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
        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)
        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })


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




    -- local diagnosticIcons = {
    --   Error = ' ', Warn = ' ', Hint = ' ', Info = ' ',
    -- }
    -- for type, icon in pairs(diagnosticIcons) do
    --   local hl = "DiagnosticSign" .. type
    --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    -- end

    if mason_lspconfig.setup_handlers then
      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              if client.name ~= "copilot" then
                require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
              end
            end,
          })
        end,

        ["tailwindcss"] = function()
          lspconfig["tailwindcss"].setup({
            capabilities = capabilities,
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

        ["svelte"] = function()
          lspconfig["svelte"].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = { "*.js", "*.ts" },
                callback = function(ctx)
                  client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                end,
              })
            end,
          })
        end,

        ["graphql"] = function()
          lspconfig["graphql"].setup({
            capabilities = capabilities,
            filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
          })
        end,

        ["emmet_ls"] = function()
          lspconfig["emmet_ls"].setup({
            capabilities = capabilities,
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
          })
        end,

        ["lua_ls"] = function()
          lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
                completion = { callSnippet = "Replace" },
              },
            },
          })
        end,

        ["intelephense"] = function()
          lspconfig["intelephense"].setup({
            intelephense = {
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
            },
          })
        end,

        ["cssls"] = function()
          lspconfig["cssls"].setup({
            capabilities = capabilities,
            filetypes = { "css", "scss", "less", "sass" },
            settings = {
              css = { validate = true, lint = { unknownAtRules = "ignore" } },
              scss = { validate = true, lint = { unknownAtRules = "ignore" } },
              less = { validate = true, lint = { unknownAtRules = "ignore" } },
            },
          })
        end,

        ["ansiblels"] = function()
          lspconfig["ansiblels"].setup({
            capabilities = capabilities,
            filetypes = { "yaml", "yml", "ansible" },
          })
        end,

        ["yamlls"] = function()
          lspconfig["yamlls"].setup({
            capabilities = capabilities,
            filetypes = { "yaml", "yml" },
          })
        end,

        ["bashls"] = function()
          lspconfig["bashls"].setup({
            capabilities = capabilities,
            filetypes = { "sh", "bash", "zsh", "fish", "dash", "ksh" },
          })
        end,
      })
    end

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








-- -------------------------------------------------------------------------------
-- -- LSP Config Plugin
-- -- https://github.com/neovim/nvim-lspconfig
-- -- Language Server Protocol client configurations for various LSP servers.
-- -------------------------------------------------------------------------------

-- return {
--   "neovim/nvim-lspconfig",
--   event        = { "BufReadPre", "BufNewFile" },
--   dependencies = {
--     "hrsh7th/cmp-nvim-lsp",
--     { "mason.nvim",                          config = true }, -- Ensure mason is loaded first
--     { "williamboman/mason-lspconfig.nvim",   config = true }, -- then mason-lspconfig
--     { "antosha417/nvim-lsp-file-operations", config = true },
--     { "folke/neodev.nvim",                   opts = {} },
--     "artemave/workspace-diagnostics.nvim",
--     -- 'jose-elias-alvarez/nvim-lsp-ts-utils',
--   },
--   opts         = {
--     event = "BufReadPre",
--     -- servers = {
--     --   "angularls",
--     --   "ansiblels",
--     --   "bashls",
--     --   "cssls",
--     --   "emmet_ls",
--     --   "graphql",
--     --   "intelephense",
--     --   "lua_ls",
--     --   "svelte",
--     --   -- tailwindcss = {},
--     --   "ts_ls",
--     --   "yamlls",
--     -- },
--   },
--   config       = function()
--     local lspconfig       = require("lspconfig")                -- Import LSP Config plugin.
--     local mason_lspconfig = require("mason-lspconfig")          -- Import Mason LSP Config plugin.
--     local cmp_nvim_lsp    = require("cmp_nvim_lsp")             -- Import CMP NVIM LSP plugin.
--     local capabilities    = cmp_nvim_lsp.default_capabilities() -- Enable autocompletion (assign to every LSP server config).
--     -- local eslint          = require("lspconfig.eslint")         -- Import ESLint LSP plugin.

--     vim.api.nvim_create_autocmd("LspAttach", {
--       group    = vim.api.nvim_create_augroup("UserLspConfig", {}),
--       callback = function(ev)
--         -- Buffer local mappings.
--         -- See `:help vim.lsp.*` for documentation on any of the below functions


--         -----------------------------------------------------------------------
--         --- Key Mappings

--         local keymap = vim.keymap
--         local opts   = { buffer = ev.buf, silent = true }

--         opts.desc    = "Show LSP references"
--         keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

--         opts.desc = "Go to declaration"
--         keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

--         opts.desc = "Show LSP definitions"
--         keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

--         opts.desc = "Show LSP implementations"
--         keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

--         opts.desc = "Show LSP type definitions"
--         keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

--         opts.desc = "See available code actions"
--         keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

--         opts.desc = "Smart rename"
--         keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

--         opts.desc = "Show buffer diagnostics"
--         keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

--         opts.desc = "Show line diagnostics"
--         keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

--         opts.desc = "Go to previous diagnostic"
--         keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

--         opts.desc = "Go to next diagnostic"
--         keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

--         opts.desc = "Show documentation for what is under cursor"
--         keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

--         opts.desc = "Restart LSP"
--         keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
--       end,
--     })


--     local diagnosticIcons = { -- Diagnostic symbols in the gutter column.
--       Error = ' ',
--       Warn  = ' ',
--       Hint  = ' ',
--       Info  = ' ',
--     }

--     for type, icon in pairs(diagnosticIcons) do
--       local hl = "DiagnosticSign" .. type
--       vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
--     end


--     ---------------------------------------------------------------------------
--     --- Language Server Handler Settings

--     mason_lspconfig.setup_handlers({

--       ----- Default handler for installed servers:
--       function(server_name)
--         lspconfig[server_name].setup({
--           capabilities = capabilities,
--           on_attach = function(client, bufnr)                                              -- Attach the following to every buffer.
--             require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr) -- Populate Workspace-Diagnostics plugin information.
--             -- require("workspace-diagnostics").populate_workspace_diagnostics(client, 0) -- Populate Workspace-Diagnostics plugin information.
--           end,
--         })
--       end,

--       -- INFO: This is commented out because of the 'typescript-tools' plugin:
--       ----- TypeScript:
--       -- ["ts_ls"] = function()
--       --   lspconfig["ts_ls"].setup({
--       --     capabilities = capabilities,
--       --     on_attach = function(client, bufnr)
--       --       require('nvim-lsp-ts-utils').setup_client(client)
--       --     end,
--       --     filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
--       --   })
--       -- end,

--       ----- Tailwind CSS:
--       ["tailwindcss"] = function()
--         lspconfig["tailwindcss"].setup({
--           capabilities = capabilities,
--           on_attach    = function(client, bufnr)
--           end,
--           filetypes    = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" },
--           settings     = {
--             tailwindCSS = {
--               experimental = {
--                 classRegex = {
--                   { "([\"'`][^\"'`]*.*?[\"'`])", "[\"'`]([^\"'`]*).*?[\"'`]" }
--                 },
--               },
--             },
--           },
--         })
--       end,

--       ----- Svelte:
--       ["svelte"] = function()
--         lspconfig["svelte"].setup({
--           capabilities = capabilities,
--           on_attach    = function(client, bufnr)
--             vim.api.nvim_create_autocmd("BufWritePost", {
--               pattern  = { "*.js", "*.ts" },
--               callback = function(ctx)
--                 -- Here use ctx.match instead of ctx.file
--                 client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
--               end,
--             })
--           end,
--         })
--       end,
--       ----- GraphQL:
--       ["graphql"] = function()
--         lspconfig["graphql"].setup({
--           capabilities = capabilities,
--           filetypes    = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
--         })
--       end,
--       ----- Emmet:
--       ["emmet_ls"] = function()
--         lspconfig["emmet_ls"].setup({
--           capabilities = capabilities,
--           filetypes    = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
--         })
--       end,
--       ----- Lua:
--       ["lua_ls"] = function()
--         lspconfig["lua_ls"].setup({
--           capabilities = capabilities,
--           settings     = {
--             Lua = {
--               diagnostics = {
--                 globals = { "vim" }, -- Recognize "vim" global.
--               },
--               completion = {
--                 callSnippet = "Replace",
--               },
--             },
--           },
--         })
--       end,
--       ----- PHP:
--       ["intelephense"] = function()
--         lspconfig["intelephense"].setup({
--           intelephense = {
--             capabilities = capabilities,
--             filetypes    = { "php", "blade" },
--             settings     = {
--               intelephense = {
--                 filetypes = { "php", "blade" },
--                 files     = {
--                   associations = { "*.php", "*.blade.php" }, -- Associating .blade.php files as well
--                   maxSize      = 5000000,
--                 },
--               },
--             },
--           },
--         })
--       end,
--       ----- CSS:
--       ["cssls"] = function()
--         lspconfig["cssls"].setup({
--           capabilities = capabilities,
--           filetypes    = { "css", "scss", "less", "sass" },
--           settings = {
--             css = {
--               validate = true,
--               lint = { unknownAtRules = "ignore" }
--             },
--             scss = {
--               validate = true,
--               lint = { unknownAtRules = "ignore" }
--             },
--             less = {
--               validate = true,
--               lint = { unknownAtRules = "ignore" }
--             },
--           },
--         })
--       end,
--       ----- Ansible:
--       ["ansiblels"] = function()
--         lspconfig["ansiblels"].setup({
--           capabilities = capabilities,
--           filetypes    = { "yaml", "yml", "ansible" },
--         })
--       end,
--       ----- YAML:
--       ["yamlls"] = function()
--         lspconfig["yamlls"].setup({
--           capabilities = capabilities,
--           filetypes    = { "yaml", "yml" },
--         })
--       end,
--       ----- Shell Scripts:
--       ["bashls"] = function()
--         lspconfig["bashls"].setup({
--           capabilities = capabilities,
--           filetypes    = { "sh", "bash", "zsh", "fish", "dash", "ksh" },
--         })
--       end,
--     })
--     -- INFO: In addition for typescript-tools, the following is added:
--     require 'lspconfig'.eslint.setup({
--       settings  = {
--         packageManager = "yarn",
--       },
--       ---@diagnostic disable-next-line: unused-local
--       on_attach = function(client, bufnr)
--         vim.api.nvim_create_autocmd("BufWritePre", {
--           buffer = bufnr,
--           command = "EslintFixAll",
--         })
--       end,
--     })


--     --     vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end )
--     -- vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end )
--     -- vim.keymap.set("n", "gt", function() vim.lsp.buf.type_definition() end )
--   end,
-- }
