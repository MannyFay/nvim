-------------------------------------------------------------------------------
-- No Neck Pain Plugin
-- https://github.com/shortcuts/no-neck-pain.nvim
-- Center the focused buffer by creating padding buffers on each side.
-------------------------------------------------------------------------------

return {
  "shortcuts/no-neck-pain.nvim",
  version = "*",
  cmd = "NoNeckPain",
  event = "VimEnter",
  opts = {
    autocmds = {
      enableOnVimEnter = "safe",
    },
    integrations = {
      NvimTree = {
        position = "left",
        reopen = true,
      },
    },
  },


  -----------------------------------------------------------------------------
  --- Key Mappings

  keys = {
    { "<leader>np", "<cmd>NoNeckPain<CR>", desc = "Toggle No Neck Pain" },
  },
}
