-------------------------------------------------------------------------------
-- Obsidian Neovim Plugin
-- https://github.com/epwalsh/obsidian.nvim
-------------------------------------------------------------------------------


-- Import Obsidian plugin with a protected call:
local obsidian_status_ok, obsidian = pcall(require, 'obsidian')
if not obsidian_status_ok then
  return "Error: */lua/user/plugin_options/obsidian.lua -> Obsidian plugin could not be loaded. Sure you have installed it in your plugins file?"
end


-------------------------------------------------------------------------------
-- Appearance

obsidian.setup({
  workspaces = {
    {
      name = "notebook",
      path = "/Volumes/Users/manny/Library/Mobile Documents/iCloud~md~obsidian/Documents/notebook",
    },
  },
  ui = {
    enable = false,
  },
  -- daily_notes = {
    -- Optional, if you keep daily notes in a separate directory.
    -- folder = "notes/dailies",
    -- Optional, if you want to change the date format for the ID of daily notes.
    -- date_format = "%Y-%m-%d",
    -- Optional, if you want to change the date format of the default alias of daily notes.
    -- alias_format = "%B %-d, %Y",
    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
    -- template = nil
  -- },

  completion = {
    nvim_cmp = true, -- Set to false to disable completion.
    min_chars = 1,      -- Trigger completion at <number> chars.
  },
  new_notes_location = "/Volumes/Users/manny/Library/Mobile Documents/iCloud~md~obsidian/Documents/notebook/0-inbox",
  open_app_foreground = false, -- true for executing Obsidian app in the foreground.
  picker = {
    name = "telescope.nvim", -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
    -- Optional, configure key mappings for the picker. These are the defaults.
    -- Not all pickers support all mappings.
    -- mappings = {
      -- Create a new note from your query.
      -- new = "<C-x>",
      -- Insert a link to the selected note.
      -- insert_link = "<C-l>",
    },
})

