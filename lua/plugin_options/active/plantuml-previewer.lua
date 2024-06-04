-- ~/.dotfiles/nvim/lua/user/plugin_options/plantuml-previewer.lua

-- https://github.com/weirongxu/plantuml-previewer.vim



------------------------------------------------------------------------------
-- PlantUML Previewer Plugin
------------------------------------------------------------------------------

------------------------------------------------------------
-- Appearance

vim.cmd([[
  autocmd FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(
    \  matchlist(system('cat `which plantuml` | grep plantuml.jar'), '\v.*\s[''"]?(\S+plantuml\.jar).*'),
    \  1,
    \  0
    \)
]])

-- Disable netrw's gx mapping for Open Browser plugin:
vim.g.netrw_nogx = 1


--------------------------------------------------------------
-- Key Mappings

-- Don't show command message in command line:
local options = { noremap = true, silent = true }

vim.keymap.set('n', '<Leader>umlo', ':PlantumlOpen<CR>', options)
vim.keymap.set('n', '<Leader>umls', ':PlantumlSave %.png<CR>', options)

