------------------------------------------------------------------------------
-- Packer Plugin Manager
------------------------------------------------------------------------------

-- Automatically install Packer:
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
    })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

-- Set ensure function as variable:
local packer_bootstrap = ensure_packer()

-- Import Packer with a protected call:
local packer_status_ok, packer = pcall(require, 'packer')
if not packer_status_ok then
  return
end

-- Reset Packer before customization below:
packer.reset()

-- Have Packer use a pop up window:
packer.init {
  compile_path = vim.fn.stdpath('data') .. '/site/plugin/packer_compiled.lua',
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'solid' })
    end,
  },
}



-------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------

-- Set up variable for Packers use() function:
local use = packer.use



-------------------------------------------------------------------------------
-- Appearance (let Packer manage itself)

use('wbthomason/packer.nvim')



-------------------------------------------------------------------------------
-- Telescope Fuzzy Finder (install ripgrep first)

use({
  'nvim-telescope/telescope.nvim',
  requires = {
    'nvim-lua/plenary.nvim',                                       -- Useful lua functions used by lots of plugins:
    'kyazdani42/nvim-web-devicons',                                -- Dev-icons set:
    'nvim-telescope/telescope-live-grep-args.nvim',                -- Passing arguments to the grep command:
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },  -- Increase sorting performance of Telescope:
    'nvim-telescope/telescope-media-files.nvim',                   -- Telescope image preview:
  },
  config = function()
    require('user.plugin_options.telescope')
  end
})



-------------------------------------------------------------------------------
-- Color Scheme (MannyDark)

use({
  'MannyFay/mannydark.nvim',
  vim.cmd [[
    try
      colorscheme mannydark
    catch /^Vim\%((\a\+)\)\=:E185/
      colorscheme default
      set background=dark
    endtry
  ]],
})



-------------------------------------------------------------------------------
-- Treesitter Language Parser

use({
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  -- run = function()
  --   require('nvim-treesitter.install').update({ with_sync = true })
  -- end,
  requires = {
    'nvim-treesitter/playground',
    'JoosepAlviste/nvim-ts-context-commentstring',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'windwp/nvim-ts-autotag',
  },
  config = function()
    require('user.plugin_options.treesitter')
  end
})



-------------------------------------------------------------------------------
-- Harpoon Bookmarked files

use "nvim-lua/plenary.nvim"
use {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { {"nvim-lua/plenary.nvim"} },
    config = function()
      require("user.plugin_options.harpoon")
    end
}



-------------------------------------------------------------------------------
-- LastPlace (jump to the last place of editing if you open a file)

use({
  'ethanholz/nvim-lastplace',
  config = function()
    require('user.plugin_options.nvim-lastplace')
  end
})



-------------------------------------------------------------------------------
-- Comment (easily comment stuff in and out)

use({
  'numToStr/Comment.nvim',
  config = function()
    require('user.plugin_options.comment')
  end
})



-------------------------------------------------------------------------------
-- Surround

use({
  'kylechui/nvim-surround',
  -- use * for stability. omit to use `main` branch for the latest features:
  tag = '*',
  requires = {
    -- advanced syntax highlighting:
    'nvim-treesitter/nvim-treesitter',
    -- provide more text objects:
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require('user.plugin_options.nvim-surround')
  end
})



-------------------------------------------------------------------------------
-- Autopairs

use({
  'windwp/nvim-autopairs',
  config = function()
    require('user.plugin_options.autopairs')
  end
})



-------------------------------------------------------------------------------
-- LuaLine Status Bar

use({
  'nvim-lualine/lualine.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user.plugin_options.lualine')
  end
})



-------------------------------------------------------------------------------
-- NvimTree

use({
    'nvim-tree/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('user.plugin_options.nvim-tree')
    end
})



-------------------------------------------------------------------------------
-- Lion (code alignment)

use({
  'tommcdo/vim-lion',
  config = function()
    require('user.plugin_options.lion')
  end,
})



-------------------------------------------------------------------------------
-- Vim Heritage (create directories if file is created in a not existing directory)

use('jessarcher/vim-heritage')



-------------------------------------------------------------------------------
-- Vim TextObj XML-Attr (extra text objects for HTML/XML)
use({
  'whatyouhide/vim-textobj-xmlattr',
  requires = {
    'kana/vim-textobj-user'
  },
})



-------------------------------------------------------------------------------
-- Vim Fugitive (Git integration)

use("tpope/vim-fugitive")



-------------------------------------------------------------------------------
-- Undo Tree (visualize undo history)

use({
  'mbbill/undotree',
  config = function()
    require('user.plugin_options.undotree')
  end
})



-------------------------------------------------------------------------------
-- Git Signs (Git integration for buffers)
use({
  'lewis6991/gitsigns.nvim',
  requires = 'nvim-lua/plenary.nvim',
  config = function()
    require('user.plugin_options.gitsigns')
  end
})


use({
  'nvimdev/lspsaga.nvim',
  after = 'nvim-lspconfig',
  config = function()
    require('user.plugin_options.lspsaga')
  end,
  requires = {
    {'nvim-tree/nvim-web-devicons'},
    --Please make sure you install markdown and markdown_inline parser
    {'nvim-treesitter/nvim-treesitter'}
  }
})



-------------------------------------------------------------------------------
-- Mason Plugin
-- https://github.com/williamboman/mason.nvim
-- Package manager for LSP servers.

use({
  "williamboman/mason.nvim",
  requires = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require('user.plugin_options.lsp.mason')
  end,
})



-------------------------------------------------------------------------------
-- LSP Plugin
-- https://github.com/neovim/nvim-lspconfig
-- Plugin to use LSP servers.

use({
  'neovim/nvim-lspconfig',                  -- Language Server Protocol client.
  requires = {
    'williamboman/mason.nvim',               -- Install and manage LSP and DAP servers, linters and formatters.
    'williamboman/mason-lspconfig.nvim',     -- Bridge between Mason and LSP-Config to use both together.
    "hrsh7th/cmp-nvim-lsp",
    "antosha417/nvim-lsp-file-operations",
    "folke/neodev.nvim",
  },
  config = function()
    require('user.plugin_options.lsp.lspconfig')
  end
})



-------------------------------------------------------------------------------
-- Nvim-Cmp (Completion Management Plugin)

use({
  'hrsh7th/nvim-cmp',                       -- Completion Engine
  requires = {
    'neovim/nvim-lspconfig',                -- Language Server Protocol client.
    'hrsh7th/cmp-nvim-lsp',                 -- CMP source for Neovims built-in LSP client.
    'hrsh7th/cmp-buffer',                   -- Get's words in buffers for completion too.
    'jessarcher/cmp-path',                  -- Use file system paths for completion too.
    'hrsh7th/cmp-cmdline',                  -- Completion source for command line.

    'L3MON4D3/LuaSnip',                     -- Snippets engine to use code snippets.
    'saadparwaiz1/cmp_luasnip',             -- Completion source for LuaSnip.

    'rafamadriz/friendly-snippets',         -- Snippets collection for diverse programming languages.
    'hrsh7th/cmp-nvim-lsp-signature-help',  -- CMP source to display function signatures with parameter explanation.
    'hrsh7th/cmp-nvim-lua',                 -- CMP source for Neovim Lua API.
    'onsails/lspkind-nvim',                 -- Pictograms for LSP completion items.
  },
  config = function()
    require('user.plugin_options.nvim-cmp')
  end,
})



-------------------------------------------------------------------------------
-- DAP (Debug Adapter Protocol)

use({'mfussenegger/nvim-dap'})



-------------------------------------------------------------------------------
-- Mason Nvim DAP (close some gaps between Mason and DAP)

use({
    "jay-babu/mason-nvim-dap.nvim",
    requires = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
  },
})



-------------------------------------------------------------------------------
-- Vim-Polyglot (boost language packs)

use('sheerun/vim-polyglot')



-------------------------------------------------------------------------------
-- PlantUML (install Java, graphviz, plantuml)

use({
  'weirongxu/plantuml-previewer.vim',
  requires = {
    'tyru/open-browser.vim',
  },
  config = function()
    require('user.plugin_options.plantuml-previewer')
  end,
})



-------------------------------------------------------------------------------
-- Markdown Preview (install Deno first)

use({
  'toppair/peek.nvim',
  run = 'deno task --quiet build:fast',
  config = function()
    require('user.plugin_options.peek')
  end,
})



-------------------------------------------------------------------------------
-- Nvim-Colorizer (show color highlighting for colors)
use({
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('user.plugin_options.nvim-colorizer')
  end
})



-------------------------------------------------------------------------------
-- Autosave files by go to normal mode or change buffer

use({
  'pocco81/auto-save.nvim',
  config = function()
    require('user.plugin_options.auto-save')
  end
})



-------------------------------------------------------------------------------
-- Copilot (AI code generation)

use {
  'zbirenbaum/copilot.lua',
  cmd    = 'Copilot',
  event  = 'InsertEnter',
  config = function()
    require('user.plugin_options.copilot')
  end,
}


use({
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require('user.plugin_options.indent-blankline')
  end,
})



-------------------------------------------------------------------------------
-- Copilot Chat

use {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'canary',
  requires = {
    'zbirenbaum/copilot.lua',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('user.plugin_options.copilot-chat')
  end,
}



-------------------------------------------------------------------------------
-- Rust Tools

-- Install:
-- rustup component add rustfmt
-- https://github.com/rust-lang/rustfmt

use({
  'simrat39/rust-tools.nvim',
  requires = {
    'neovim/nvim-lspconfig',
    -- Debugging:
    'nvim-lua/plenary.nvim',
    'mfussenegger/nvim-dap',
  },
  config = function()
    require('user.plugin_options.rust-tools')
  end,
})



-------------------------------------------------------------------------------
-- Laravel

use({
  'adalessa/laravel.nvim',
  requires = {
    'nvim-telescope/telescope.nvim',
    'tpope/vim-dotenv',
    'MunifTanjim/nui.nvim',
    'nvimtools/none-ls.nvim',
  },
  config = function()
    require('user.plugin_options.laravel')
  end,
})



-------------------------------------------------------------------------------
-- Obsidian

use({
  'epwalsh/obsidian.nvim',
  tag = '*',  -- recommended, use latest release instead of latest commit
  requires = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('user.plugin_options.obsidian')
  end,
})



-------------------------------------------------------------------------------
-- Which Key

use({
  'folke/which-key.nvim',
  config = function()
    require('user.plugin_options.whichkey')
  end,
})

if packer_bootstrap then
  packer.sync()
end



------------------------------------------------------------------------------
-- Auto Commands
------------------------------------------------------------------------------

-- Autocommand that reloads neovim whenever you save the plugins.lua file:
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]])
