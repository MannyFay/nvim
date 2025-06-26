-------------------------------------------------------------------------------
-- Neovim configuration file.
-- This file is loaded by Neovim when it starts.
-------------------------------------------------------------------------------



-------------------------------------------------------------------------------
-- VS Code and Neovim loaders

if vim.g.vscode then          -- VSCode Neovim Extension.
  require("vs-code.options")
  require("vs-code.keymaps")
  require("vs-code.lazy")
else                          -- Ordinary Neovim
  require("core.options")     -- Must be first entry.
  require("core.keymaps")
  require("core.lazy")
end



-------------------------------------------------------------------------------
-- Platform specific settings

local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = has "macunix"
local is_win = has "win32" or has "win64"

if is_mac then
  vim.opt.clipboard = { "unnamedplus" }
end
if is_win then
  vim.opt.clipboard = { "unnamed", "unnamedplus" }
end

vim.opt.runtimepath:append("~/.config/nvim/lua/plugins")

