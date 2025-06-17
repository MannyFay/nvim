-------------------------------------------------------------------------------
-- Surround Plugin
-- https://github.com/kylechui/nvim-surround
-- Surround text with pairs of delimiters.
-------------------------------------------------------------------------------

return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event   = "VeryLazy",
  config  = function()


    ---------------------------------------------------------------------------
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

    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
    })
  end,
}
