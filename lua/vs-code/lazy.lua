-------------------------------------------------------------------------------
-- Lazy Plugin Manager
-- https://github.com/folke/lazy.nvim
-- Fast plugin loading for Neovim.
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Automatically install Lazy

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.fn.isdirectory(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- Load latest stable release.
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)



-------------------------------------------------------------------------------
-- Load plugins
-- (always load them separately in this list because debugging is way easier)

require("lazy").setup({
  { import = "plugins.active.surround" },
  { import = "plugins.active.alternate_toggler" },
})

