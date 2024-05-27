-- Add this to the Packer plugin file:
-------------------------------------------------------------------------------
-- Deoplete (Autocompletion Plugin)

-- use({
--   'Shougo/deoplete.nvim',
--    run = ':UpdateRemotePlugins',
--   requires = {
--     'roxma/nvim-yarp',
--     'roxma/vim-hug-neovim-rpc',
--     run = 'pip install -r requirements.txt'
--   },
--   config = function()
--     require('user.plugin_options.deoplete')
--   end,
-- })
--
-- use({
--   'beeender/Comrade'
-- })





vim.g['deoplete#enable_at_startup'] = 1
vim.fn['python3_host_prog'] = '/usr/bin/python3'
