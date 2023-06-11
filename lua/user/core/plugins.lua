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


-- Automatically set the working directory to the project root:
-- Maybe it automatically set's the root to vendor if opened! Watch it!
use({
  'ahmedkhalf/project.nvim',
  requires = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('user.plugin_options.project')
  end
})


-- Jump to the last place of editing if you open a file:
use({
  'ethanholz/nvim-lastplace',
  config = function()
    require('user.plugin_options.nvim-lastplace')
  end
})


-- Easily comment stuff in and out:
use({
  'numToStr/Comment.nvim',
  config = function()
    require('user.plugin_options.comment')
  end
})


-- Dot repeating for plugins can maybe solved about that article:
-- https://gist.github.com/kylechui/a5c1258cd2d86755f97b10fc921315c3


-- Surround a selection of chars:
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


-- Provide Unix commands in Neovims command line:
use({
  'chrisgrieser/nvim-genghis',
  requires = {
    -- Autocompletion for directories:
    'stevearc/dressing.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-omni',
  },
  config = function()
    require('user.plugin_options.nvim-genghis')
  end
})


-- Selection of keymappings to jump between buffers and Git conflicts:
-- use({
-- [[   'tummetott/unimpaired.nvim',
--   config = function()
--     require('user.plugin_options.unimpaired')
--   end
-- })


-- Guess and set indentation because of the rest of a file:
use({
  'nmac427/guess-indent.nvim',
  config = function()
    require('user.plugin_options.guess-indent')
  end
})


-- Create parent directories if file is created in a not existing directory:
use('jessarcher/vim-heritage')


-- Mark more than one word and search for it with *:
use('nelstrom/vim-visual-star-search')


-- Set color scheme:
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


-- Code reformatting:
use({
  'tommcdo/vim-lion',
  config = function()
    require('user.plugin_options.lion')
  end,
})


-- Extra text objects for HTML attributes:
use({
  'whatyouhide/vim-textobj-xmlattr',
  requires = {
    'kana/vim-textobj-user'
  },
})


-- Automatically fix indentation when pasting code:
--use({
 -- 'sickill/vim-pasta',
  --config = function()
    --require('user.plugin_options.vim-pasta')
    --require('user.plugin_options.vim-pasta')
  --end,
--})


-- Show vertical indent lines for blocks:
use({
  'lukas-reineke/indent-blankline.nvim',
  require = function()
    require('user.plugin_options.indent-blankline')
  end,
})


-- Split or join list-like syntax constructs (like arrays):
use({
  'bennypowers/splitjoin.nvim',
  config = function()
    require('user.plugin_options.splitjoin')
  end
})


-- Autopairs, integrates with both cmp and treesitter:
use({
  'windwp/nvim-autopairs',
  config = function()
    require('user.plugin_options.autopairs')
  end
})


-- Status bar:
use({
  'nvim-lualine/lualine.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user.plugin_options.lualine')
  end
})


-- Project tree:
use({
    'nvim-tree/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('user.plugin_options.nvim-tree')
    end
})


-- Enable smooth scrolling to avoid hard jumps:
--[[ use({ ]]
--[[   'karb94/neoscroll.nvim', ]]
--[[   config = function() ]]
--[[     require('user.plugin_options.neoscroll') ]]
--[[   end ]]
--[[ }) ]]


-- Fuzzy Finder:
-- Run: 'brew install ripgrep' to get Telescope work.
use({
  'nvim-telescope/telescope.nvim',
  requires = {
    -- Useful lua functions used by lots of plugins:
    'nvim-lua/plenary.nvim',
    -- Dev-incons set:
    'kyazdani42/nvim-web-devicons',
    -- Passing arguments to the grep command:
    'nvim-telescope/telescope-live-grep-args.nvim',
    -- Increase sorting performance of Telescope:
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    -- Telescope image preview:
    'nvim-telescope/telescope-media-files.nvim',
  },
  config = function()
    require('user.plugin_options.telescope')
  end
})


-- Treesitter syntax highlighting:
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


-- Git integration for buffers:
use({
  'lewis6991/gitsigns.nvim',
  requires = 'nvim-lua/plenary.nvim',
  config = function()
    require('user.plugin_options.gitsigns')
  end
})

use({
  'glepnir/lspsaga.nvim',
  branch = 'main',
  event = 'LspAttach',
  config = function()
    require('user.plugin_options.lspsaga')
  end,
  requires = {
    {'nvim-tree/nvim-web-devicons'},
    --Please make sure you install markdown and markdown_inline parser
    {'nvim-treesitter/nvim-treesitter'}
  }
})

-- Enable Language Server Protocol (LSP):
use({
  'neovim/nvim-lspconfig',
  requires = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'folke/lsp-colors.nvim',
  },
  config = function()
    require('user.plugin_options.lspconfig')
  end
})


-- Autocompletion:
-- One of these plugin gives a very cool breadcrumb on top of the buffer.
use({
  'hrsh7th/nvim-cmp',
  requires = {
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-nvim-lua',
    'jessarcher/cmp-path',
    'onsails/lspkind-nvim',
    'saadparwaiz1/cmp_luasnip',
  --[[   { ]]
  --[[     'glepnir/lspsaga.nvim', ]]
  --[[     branch = 'main', ]]
  --[[     event = 'lspattach', ]]
  --[[     config = function() ]]
  --[[       require('user.plugin_options.lspsaga') ]]
  --[[     end, ]]
  --[[   }, ]]
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

-- Markdown preview:
-- Install Deno: brew install deno
use({
  'toppair/peek.nvim',
  run = 'deno task --quiet build:fast',
  config = function()
    require('user.plugin_options.peek')
  end,
})









-- Autosave files:
  -- https://github.com/Pocco81/auto-save.nvim
use({
  'pocco81/auto-save.nvim',
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



 -- Min-/Maximize buffer:
use({
  'anuvyklack/windows.nvim',
  requires = {
    'anuvyklack/middleclass',
  },
  config = function()
    require('user.plugin_options.windows')
  end
})



-- Fast navigation:
use({
  'phaazon/hop.nvim',
  config = function()
    require('user.plugin_options.hop')
  end,
})

--[[ use({ ]]
--[[   'Shougo/deoplete.nvim', ]]
--[[    run = ':UpdateRemotePlugins', ]]
--[[   requires = { ]]
--[[     'roxma/nvim-yarp', ]]
--[[     'roxma/vim-hug-neovim-rpc', ]]
--[[     run = 'pip install -r requirements.txt' ]]
--[[   }, ]]
--[[   config = function() ]]
--[[     require('user.plugin_options.deoplete') ]]
--[[   end, ]]
--[[ }) ]]
--[[]]
--[[ use({ ]]
--[[   'beeender/Comrade' ]]
--[[ }) ]]


if packer_bootstrap then
  packer.sync()
end



------------------------------------------------------------------------------
-- Auto Commands
------------------------------------------------------------------------------

-- Autocommand that reloads neovim whenever you save the plugins.lua file:
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

