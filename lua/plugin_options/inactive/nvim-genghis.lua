-- Add this to your Packer plugin file:
-- -- Provide Unix commands in Neovims command line:
-- use({
--   'chrisgrieser/nvim-genghis',
--   config = function()
--     require('user.plugin_options.nvim-genghis')
--   end
-- })

-- https://github.com/chrisgrieser/nvim-genghis



------------------------------------------------------------------------------
-- Neovim Genghis Plugin
------------------------------------------------------------------------------

-- Import Nvim Genghis with a protected call:
local nvim_genghis_status_ok, nvim_genghis = pcall(require, 'genghis')
if not nvim_genghis_status_ok then
  return
end


------------------------------------------------------------
-- Appearance

-- Disable Ex-Commands:
vim.g.genghis_disable_commands = true


------------------------------------------------------------
-- Key Mappings

local keymap = vim.keymap.set
keymap('n', '<Nop>', nvim_genghis.copyFilepath)
keymap('n', '<Nop>', nvim_genghis.copyFilename)
keymap('n', '<Nop>', nvim_genghis.chmodx)
keymap('n', '<Nop>', nvim_genghis.renameFile)
keymap('n', '<Nop>', nvim_genghis.moveAndRenameFile)
keymap('n', '<Nop>', nvim_genghis.createNewFile)
keymap('n', '<Nop>', nvim_genghis.duplicateFile)
keymap('n', '<Nop>', function () nvim_genghis.trashFile{trashLocation = '$HOME/.Trash'} end)
keymap('x', '<Nop>', nvim_genghis.moveSelectionToNewFile)

--[[ keymap('n', '<leader>yp', nvim_genghis.copyFilepath) ]]
--[[ keymap('n', '<leader>yn', nvim_genghis.copyFilename) ]]
--[[ keymap('n', '<leader>cx', nvim_genghis.chmodx) ]]
--[[ keymap('n', '<leader>rf', nvim_genghis.renameFile) ]]
--[[ keymap('n', '<leader>mf', nvim_genghis.moveAndRenameFile) ]]
--[[ keymap('n', '<leader>nf', nvim_genghis.createNewFile) ]]
--[[ keymap('n', '<leader>yf', nvim_genghis.duplicateFile) ]]
--[[ keymap('n', '<leader>df', function () nvim_genghis.trashFile{trashLocation = '$HOME/.Trash'} end) ]]
--[[ keymap('x', '<leader>x', nvim_genghis.moveSelectionToNewFile) ]]