-------------------------------------------------------------------------------
-- Which-Key Plugin
-- https://github.com/folke/which-key.nvim
-- Displays available keybindings in a popup as you type.
-------------------------------------------------------------------------------

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.setup({
      preset = "helix",
      delay = 300,
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+ ",
      },
      win = {
        border = "rounded",
        padding = { 1, 2 },
      },
    })

    ---------------------------------------------------------------------------
    -- Group Labels

    wk.add({
      { "<leader>a",  group = "Aider" },
      { "<leader>f",  group = "Find (Telescope)" },
      { "<leader>g",  group = "Git" },
      { "<leader>h",  group = "Harpoon" },
      { "<leader>m",  group = "Maximize" },
      { "<leader>o",  group = "Obsidian" },
      { "<leader>q",  group = "Quit/Close" },
      { "<leader>s",  group = "Split" },
      { "<leader>t",  group = "Terminal/Tabs" },
      { "<leader>w",  group = "Worktree" },
    })
  end,
}
