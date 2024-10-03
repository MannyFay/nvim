if vim.g.vscode then          -- VSCode Neovim Extension.
  require("vs-code.options")
  require("vs-code.keymaps")
else                          -- Ordinary Neovim
  require("core.options")     -- Must be first entry.
  require("core.keymaps")
  require("core.lazy")
end
