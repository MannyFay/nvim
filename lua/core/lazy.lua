-------------------------------------------------------------------------------
-- Lazy Plugin Manager
-- https://github.com/folke/lazy.nvim
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Automatically install Lazy:

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
-- Load plugins directory:

require("lazy").setup({
    { import = "plugins.active" },
    { import = "plugins.active.copilot" },
    { import = "plugins.active.git" },
    { import = "plugins.active.laravel "},
    { import = "plugins.active.lsp" },
  }, {
  change_detection = {
    notify = false, -- Don't notify in command line about changed plugin files.
  },
  install = {
    colorscheme = {
      "mannydark",
    },
  },
})
