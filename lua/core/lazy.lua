-------------------------------------------------------------------------------
-- Lazy Plugin Manager
-- https://github.com/folke/lazy.nvim
-- Fast plugin loading for Neovim.
-------------------------------------------------------------------------------



-------------------------------------------------------------------------------
-- Automatically install Lazy

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.fn.isdirectory(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- Load latest stable release.
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)



-------------------------------------------------------------------------------
-- Load plugins
-- (always load them separately in this list because debugging is way easier)

local lazy_plugin_manager = require("lazy")  -- Load Lazy plugin manager.

lazy_plugin_manager.setup({

  -----------------------------------------------------------------------------
  -- AI

  { import = "plugins.active.ai.claude_code" },
  { import = "plugins.active.ai.copilot" },
  { import = "plugins.active.ai.copilot_chat" },
  { import = "plugins.active.ai.mcphub" },



  -----------------------------------------------------------------------------
  -- Collaboration

  { import = "plugins.active.collaboration.teamtype" },



  -----------------------------------------------------------------------------
  -- Formatting

  { import = "plugins.active.formatting.conform" },



  -----------------------------------------------------------------------------
  -- JavaScript Environment

  { import = "plugins.active.js-env.ts_worksheet" },
  { import = "plugins.active.js-env.typescript-tools" },

  { import = "plugins.active.js-env.type-checker" },



  -----------------------------------------------------------------------------
  -- Git

  { import = "plugins.active.git.fugitive" },
  { import = "plugins.active.git.gitsigns" },
  { import = "plugins.active.git.neogit" },



  -----------------------------------------------------------------------------
  -- Laravel

  { import = "plugins.active.laravel.laravel" },
  { import = "plugins.active.laravel.vim-blade" },



  -----------------------------------------------------------------------------
  -- LSP

  { import = "plugins.active.lsp.lspconfig" },
  { import = "plugins.active.lsp.mason" },
  { import = "plugins.active.lsp.otter" },
  -- { import = "plugins.active.lsp.lspsaga" },
  { import = "plugins.active.lsp.trouble" },
  { import = "plugins.active.lsp.workspace-diagnostics" },
  -- { import = "plugins.active.lsp.none-ls" },



  -----------------------------------------------------------------------------
  -- Markdown

  { import = "plugins.active.markdown.obsidian" },
  { import = "plugins.active.markdown.peek" },
  { import = "plugins.active.markdown.render_markdown" },
  -- { import = "plugins.active.markdown.wrapwidth" },



  -----------------------------------------------------------------------------
  -- Snippets

  { import = "plugins.active.snippets.luasnip" },



  -----------------------------------------------------------------------------
  -- Telescope

  { import = "plugins.active.telescope.telescope-undo" },
  { import = "plugins.active.telescope.telescope" },



  -----------------------------------------------------------------------------
  -- Treesitter

  { import = "plugins.active.treesitter.treesitter-auto-tag" },
  { import = "plugins.active.treesitter.treesitter-text-objects" },
  { import = "plugins.active.treesitter.treesitter" },



  -----------------------------------------------------------------------------
  -- General

  { import = "plugins.active.alternate_toggler" },
  { import = "plugins.active.align" },
  { import = "plugins.active.auto-save" },
  { import = "plugins.active.autopairs" },
  { import = "plugins.active.colorizer" },
  { import = "plugins.active.colorscheme" },
  { import = "plugins.active.comment" },
  { import = "plugins.active.harpoon" },
  { import = "plugins.active.indent-blankline" },
  { import = "plugins.active.lastplace" },
  { import = "plugins.active.live-share" },
  -- { import = "plugins.active.local-highlight" },
  { import = "plugins.active.lualine" },
  { import = "plugins.active.maximizer" },
  { import = "plugins.active.nvim-cmp" },
  { import = "plugins.active.nvim-tree" },
  { import = "plugins.active.surround" },
  { import = "plugins.active.todo_comments" },
  { import = "plugins.active.vim-illuminate" },
  { import = "plugins.active.plantuml_preview" },
}, {
  change_detection = {
    notify = false, -- Don't notify in command line about changed plugin files.
  },
  ---------------------------------------
  -- Uncomment this to enable local colorscheme development:
  dev = {
    path = "~/personal/github", -- Local plugin development path.
    patterns = { "MannyFay" },  -- Load all MannyFay/* plugins from local path.
    fallback = true,            -- Fallback to git if local plugin doesn't exist.
  },
  ---------------------------------------
  install = {
    colorscheme = {
      "mannydark",
    },
  },
})

