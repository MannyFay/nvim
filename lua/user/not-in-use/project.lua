-- Add this to your Packer plugins file:
-------------------------------------------------------------------------------
-- Project plugin

-- Automatically set the working directory to the project root:
-- Maybe it automatically set's the root to vendor if opened! Watch it!
-- use({
--   'ahmedkhalf/project.nvim',
--   requires = {
--     'nvim-telescope/telescope.nvim',
--   },
--   config = function()
--     require('user.plugin_options.project')
--   end
-- })






-- https://github.com/ahmedkhalf/project.nvim



------------------------------------------------------------------------------
-- Project plugin
------------------------------------------------------------------------------

-- Import Project with a protected call:
local project_status_ok, project = pcall(require, 'project_nvim')
if not project_status_ok then
  return
end


------------------------------------------------------------
-- Appearance

project.setup({
  -- Activate Project plugin:
  active = true,
  -- Disable manual mode to set working directory automatically:
  manual_mode = false,
  -- Use Vim-Rooter pattern to detect working directory ('lsp' can be a mess):
  detection_methods = { 'pattern' },
  -- Patterns to detect project root directory:
  patterns = {
    '.editorconfig',
    '.env',
    '_darcs',
    '.hg',
    '.bzr',
    '.svn',
    'Makefile',
    'package.json'
  },
  -- Show hidden files in Telescope:
  show_hidden = true,
  -- Don't display a message if Project sets the working directory:
  silent_chdir = true,
  -- Table of LSP clients to ignore ('efm' for example):
  ignore_lsp = {},
  -- Scope to change directory of:
  scope_chdir = 'global',
  -- Path where Project will store the project history for Telescope:
  datapath = vim.fn.stdpath('data'),
  -- Disable Project plugin mappings after the configuration is done:
  on_config_done = function()
    -- Import the Telescope keymap module:
    local keymap = require('telescope.keymap')
    -- Disable the mappings:
    keymap.n { "n", "f", 'find_project_files' }
    keymap.n { "n", "b", browse_project_files }
    keymap.n { "n", "d", delete_project }
    keymap.n { 's', false }
    keymap.n { 'r', false }
    keymap.n { 'w', false }
    keymap.i { '<c-f>', false }
    keymap.i { '<c-b>', false }
    keymap.i { '<c-d>', false }
    keymap.i { '<c-s>', false }
    keymap.i { '<c-r>', false }
    keymap.i { '<c-w>', false }
  end
})

-- Import Telescope with a protected call, so it don't error out on first use:
local telescope_status_ok, telescope = pcall(require, 'telescope')
if not telescope_status_ok then
  return
end

-- Enable Telescope integration:
telescope.load_extension('projects')

-- Enable Telescope projects picker:
-- telescope.extensions.projects.projects{}
