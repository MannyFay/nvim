-- ~/.dotfiles/nvim/lua/user/plugin_options/lspconfig.lua

-- https://github.com/neovim/nvim-lspconfig



-------------------------------------------------------------------------------
-- LSP Config Plugin
-------------------------------------------------------------------------------

-- Import Mason plugin safely:
local mason_status_ok, mason = pcall(require, 'mason')
if not mason_status_ok then
  return
end

-- Import Mason-LSP-Config plugin safely:
local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_status_ok then
  return
end

-- Import LSP Config plugin safely:
local lspconfig_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status_ok then
  return
end

-- Additional default capabilities for Nvim-CMP:
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Write commands without displaying it in command line:
local opts = { noremap = true, silent = true, buffer = bufnr }















-- Import cmp-nvim-lsp plugin safely:
-- local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
-- if not cmp_nvim_lsp_status then
--   return
-- end

-- Import typescript plugin safely:
-- local typescript_setup, typescript = pcall(require, "typescript")
-- if not typescript_setup then
--   return
-- end






-- Used to enable autocompletion (assign to every lsp server config):
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()




------------------------------------------------------------
-- Keymaps

-- local keymap = vim.keymap

-- Enable keybinds only for when lsp server available:
-- local on_attach = function(client, bufnr)
-- end

local on_attach = function(_, bufnr)
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
  -- Go to definition (gd):
  --[[ vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts) ]]
  -- Show information in floating window (si):
  --[[ vim.keymap.set('n', 'si', '<cmd>lua vim.lsp.buf.hover()<CR>', opts) ]]
end





------------------------------------------------------------
-- Appearance

-- Change the Diagnostic symbols in the sign column (gutter):
local signs = {
  Error = ' ',
  Warn  = ' ',
  Hint  = ' ',
  Info  = ' ',
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

mason.setup({
  ui = {
    icons = {
      package_installed   = '✓',
      package_pending     = '➜',
      package_uninstalled = '✗',
    },
  },
})

mason_lspconfig.setup({
  automatic_installation = true,
  ensure_installed = {
    'bashls',
    'lua_ls',
    'dockerls',
    'emmet_ls',
    'html',
    'volar',
    'marksman',
    'intelephense',
    'sqlls',
    'tailwindcss',
  },
})

-------------------------------------------------------------------------------
-- Keymaps
-------------------------------------------------------------------------------

  -- set keybinds
 --[[  keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
  keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
  keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
  keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
  keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
  keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

  -- typescript specific keymaps (e.g. rename file and update imports)
  if client.name == "tsserver" then
    keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
    keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
    keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
  end ]]
--end


-------------------------------------------------------------------------------
-- Language Servers
-------------------------------------------------------------------------------

-- Bash server:
  lspconfig.bashls.setup({
  -- Add the HTML-Keybinds to autocompletion:
  on_attach = on_attach,
  -- Enable autocompletion for the server:
  capabilities = capabilities,
})

-- Lua Server:
lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

-- Docker server:
lspconfig.dockerls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Emmet server:
lspconfig.emmet_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- HTML server:
lspconfig.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- JavaScript server:
lspconfig.volar.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
})

-- Markdown server:
lspconfig.marksman.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- PHP server:
lspconfig.intelephense.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  capabilities = capabilities,
})

-- SQL server:
lspconfig.sqlls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
 })

-- TailwindCSS server:
lspconfig.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

