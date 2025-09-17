-------------------------------------------------------------------------------
-- Neovim main configuration file.
-- This file is loaded by Neovim when it starts.
-------------------------------------------------------------------------------



-------------------------------------------------------------------------------
-- Helpers

vim.opt.runtimepath:append("~/.config/nvim/lua/plugins")  -- Set runtime path early (before any plugin loading).

local function require_safely(module)
  local success, result = pcall(require, module)

  if not success then
    vim.notify("Problem loading " .. module .. ": " .. result, vim.log.levels.ERROR)
    return false
  end

  return true
end



-------------------------------------------------------------------------------
-- VS Code and Neovim loaders

if vim.g.vscode then          -- VSCode Neovim Extension.
  require_safely("vs-code.options")  -- Load options for Neovim VSCode extension.
  require_safely("vs-code.keymaps")  -- Load key mappings for Neovim VSCode extension.

  if not require_safely("vs-code.lazy") then  -- Load lazy.nvim plugins for VSCode.
    vim.notify("VSCode plugins in /lua/vs-code/lazy.lua failed to load", vim.log.levels.ERROR)
  end

else                          -- Ordinary Neovim
  if not require_safely("core.options") then  -- Load core options. Stops if it fails.
    vim.notify("Core options in /lua/core/options.lua failed to load", vim.log.levels.ERROR)
    return
  end

  require_safely("core.keymaps")
  require_safely("core.autocmds")

    if not require_safely("core.lazy") then
    vim.notify("Plugins in /lua/core/lazy.lua failed to load", vim.log.levels.ERROR)
  end
end



-------------------------------------------------------------------------------
-- Platform specific settings

local function setup_platform_settings()
  local has = function(x)
    return vim.fn.has(x) == 1
  end

  local is_mac = has ("macunix")
  local is_win = has ("win32") or has ("win64")

  if is_mac then
    vim.opt.clipboard = { "unnamedplus" }
  elseif is_win then
    vim.opt.clipboard = { "unnamed", "unnamedplus" }
  end
end

-- Apply platform settings with error handling
local platform_success = pcall(setup_platform_settings)
if not platform_success then
  vim.notify("Platform specific settings failed to load", vim.log.levels.WARN)
end

