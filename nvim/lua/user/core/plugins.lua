-- ~/.dotfiles/nvim/lua/user/core/plugins.lua



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

-- Have Packer use a popup window:
packer.init {
  compile_path = vim.fn.stdpath('data') .. '/site/plugin/packer_compiled.lua',
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'solid' })
    end,
  },
}



------------------------------------------------------------------------------
-- Plugins
------------------------------------------------------------------------------

-- Set up variable for Packers use() function:
local use = packer.use


------------------------------------------------------------
-- Appearance

-- Let Packer manage itself:
use('wbthomason/packer.nvim')





-------------------------------------------------------------------------------
-- Telescope Fuzzy Finder (install ripgrep first)

use({
  'nvim-telescope/telescope.nvim',
  requires = {
    'nvim-lua/plenary.nvim',                                       -- Useful lua functions used by lots of plugins:
    'kyazdani42/nvim-web-devicons',                                -- Dev-incons set:
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
  run = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
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
  -- Use * for stability. Omit to use `main` branch for the latest features:
  tag = '*',
  requires = {
    -- Advanced syntax highlighting:
    'nvim-treesitter/nvim-treesitter',
    -- Provide more text objects:
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
-- Lion (code alignment)

use({
  'tommcdo/vim-lion',
  config = function()
    require('user.plugin_options.lion')
  end,
})



-- -- Provide Unix commands in Neovims command line:
-- use({
--   'chrisgrieser/nvim-genghis',
--   config = function()
--     require('user.plugin_options.nvim-genghis')
--   end
-- })


-- Selection of keymappings to jump between buffers and Git conflicts:
-- use({
-- [[   'tummetott/unimpaired.nvim',
--   config = function()
--     require('user.plugin_options.unimpaired')
--   end
-- })




-- Create parent directories if file is created in a not existing directory:
-- use('jessarcher/vim-heritage')


-- Mark more than one word and search for it with *:
-- use('nelstrom/vim-visual-star-search')






-- Extra text objects for HTML attributes:
use({
  'whatyouhide/vim-textobj-xmlattr',
  requires = {
    'kana/vim-textobj-user'
  },
})















-- Git integration for buffers:
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


--------------------------------------------------------------
-- Language Server Protocol (LSP):

use({
  'neovim/nvim-lspconfig',                  -- Language Server Protocol client.                                       -- https://github.com/neovim/nvim-lspconfig
  requires = {
    'williamboman/mason.nvim',               -- Install and manage LSP and DAP servers, linters and formatters.       -- https://github.com/williamboman/mason.nvim
    'williamboman/mason-lspconfig.nvim',     -- Bridge between Mason and LSP-Config to use both together.            -- https://github.com/williamboman/mason-lspconfig.nvim
    -- 'folke/lsp-colors.nvim',  <-- deprecated
  },
  config = function()
    require('user.plugin_options.lspconfig')
  end
})


--------------------------------------------------------------
-- Autocompletion (Completion Management Plugin)

use({
  'hrsh7th/nvim-cmp',                       -- Completion Engine                                                      -- https://github.com/hrsh7th/nvim-cmp
  -- Plugins for enhancement:
  requires = {
    'neovim/nvim-lspconfig',                -- Language Server Protocol client.                                       -- https://github.com/neovim/nvim-lspconfig
    'hrsh7th/cmp-nvim-lsp',                 -- CMP source for Neovims built-in LSP client.                            -- https://github.com/hrsh7th/cmp-nvim-lsp
    'hrsh7th/cmp-buffer',                   -- Get's words in buffers for completion too.                             -- https://github.com/hrsh7th/cmp-buffer
    'jessarcher/cmp-path',                  -- Use file system paths for completion too.                              -- https://github.com/jessarcher/cmp-path
    'hrsh7th/cmp-cmdline',                  -- Completion source for command line.                                    -- https://github.com/hrsh7th/cmp-cmdline

    'L3MON4D3/LuaSnip',                     -- Snippets engine to use code snippets.                                  -- https://github.com/L3MON4D3/LuaSnip
    'saadparwaiz1/cmp_luasnip',             -- Completion source for LuaSnip.                                         -- https://github.com/saadparwaiz1/cmp_luasnip

    'rafamadriz/friendly-snippets',         -- Snippets collection for diverse programming languages.                 -- https://github.com/rafamadriz/friendly-snippets
    'hrsh7th/cmp-nvim-lsp-signature-help',  -- CMP source to display function signatures with parameter explanation.  -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
    'hrsh7th/cmp-nvim-lua',                 -- CMP source for Neovim Lua API.                                         -- https://github.com/hrsh7th/cmp-nvim-lua
    'onsails/lspkind-nvim',                 -- Pictograms for LSP completion items.                                   -- https://github.com/onsails/lspkind.nvim
  },
  config = function()
    require('user.plugin_options.nvim-cmp')
  end,
})





-- Look for a plugin called vim-scripts/ReplaceWithRegister


--[[]]
--[[ use({ ]]
--[[   'jose-elias-alvarez/null-ls.nvim', ]]
--[[   requires = 'nvim-lua/plenary.nvim', ]]
--[[   config = function() ]]
--[[     require('user.plugin_options.null-ls') ]]
--[[   end, ]]
--[[ }) ]]


-- Boost up language packs for Neovim:
--vim.g.polyglot_disabled = { 'markdown.plugin' }
--vim.g.polyglot_disabled = { 'autoindent' }
use('sheerun/vim-polyglot')


-- PlantUML preview:
-- Install Java: https://www.oracle.com/java/technologies/downloads/#jdk20-mac
-- Install Graphviz: brew install graphviz
-- Install PlantUML: brew install plantuml
use({
  'weirongxu/plantuml-previewer.vim',
  requires = {
    'tyru/open-browser.vim',
  },
  config = function()
    require('user.plugin_options.plantuml-previewer')
  end,
})


--------------------------------------------------------------
-- Markdown Preview (install Deno first)

use({
  'toppair/peek.nvim',                     -- Markdown Preview Plugin.                                              -- https://github.com/toppair/peek.nvim
  run = 'deno task --quiet build:fast',
  config = function()
    require('user.plugin_options.peek')
  end,
})


--------------------------------------------------------------
-- Autosave files by go to normal mode or change buffer

use({
  'pocco81/auto-save.nvim',                                                   -- https://github.com/Pocco81/auto-save.nvim
  config = function()
    require('user.plugin_options.auto-save')
  end
})


-- Show color highlighting for colors and color variables:
use({
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('user.plugin_options.nvim-colorizer')
  end
})




-- Fast navigation:
use({
  'phaazon/hop.nvim',
  config = function()
    require('user.plugin_options.hop')
  end,
})












-------------------------------------------------------------------------------
-- Copilot (AI code generation)

use {
  'zbirenbaum/copilot.lua',                  -- GitHub Copilot for Neovim.                                            -- https://github.com/zbirenbaum/copilot.lua
  cmd    = 'Copilot',
  event  = 'InsertEnter',
  config = function()
    require('user.plugin_options.copilot')
  end,
}






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