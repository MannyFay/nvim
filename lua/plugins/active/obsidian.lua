return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
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
    -- see below for full list of options 👇
  },
}
