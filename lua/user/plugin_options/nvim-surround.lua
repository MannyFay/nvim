-- ~/.dotfilesnvim/lua/user/plugin_options/nvim-surround.lua

-- https://github.com/kylechui/nvim-surround



------------------------------------------------------------------------------
-- Neovim Surround Plugin
------------------------------------------------------------------------------

-- Import Nvim-Surround with a protected call:
local nvim_surround_status_ok, nvim_surround = pcall(require, 'nvim-surround')
if not nvim_surround_status_ok then
  return
end


------------------------------------------------------------
-- Appearance

--local input      = require('nvim-surround.input')
--local functional = require('nvim-surround.functional')

nvim_surround.setup({
  -- Put configuration in here or let it empty for the default.

  -- Default commands:
  -- ysiw)     = surround word with ()
  -- ys$"      = surround till end of line with ""
  -- ds]       = erase [] around line
  -- dst       = remove HTML tags of the element
  -- cs'"      = change quotes from ' to "
  -- csth1<CR> = change HTML tag to <h1>
  -- dsf       = erase () around actual content
})


------------------------------------------------------------
-- Key Mappings

-- Surround word with ():
vim.keymap.set("n", "((", "ysiw)", { remap = true })
-- Surround word with {}:
vim.keymap.set("n", "{{", "ysiw}", { remap = true })
-- Surround word with []:
vim.keymap.set("n", "[[", "ysiw]", { remap = true })
-- Surround word with "":
vim.keymap.set("n", '""', 'ysiw"', { remap = true })
-- Surround word with '':
vim.keymap.set("n", "''", "ysiw'", { remap = true })
-- Surround word with ``:
vim.keymap.set("n", "``", "ysiw`", { remap = true })
-- Surround word with <>:
vim.keymap.set("n", "<>", "ysiw>", { remap = true })

-- Surround marked with ():
vim.keymap.set("v", "((", "S)", { remap = true })
-- Surround marked with {}:
vim.keymap.set("v", "{{", "S}", { remap = true })
-- Surround marked with []:
vim.keymap.set("v", "[[", "S]", { remap = true })
-- Surround marked with "":
vim.keymap.set("v", '""', 'S"', { remap = true })
-- Surround marked with '':
vim.keymap.set("v", "''", "S'", { remap = true })
-- Surround marked with ``:
vim.keymap.set("v", "``", "S`", { remap = true })
-- Surround marked with <>:
vim.keymap.set("v", "<>", "S>", { remap = true })


-- Surround with tag:
vim.keymap.set("n", "swt", "ySSt", { remap = true })
-- Surround marked with tag:
vim.keymap.set("v", "swt", "St", { remap = true })

