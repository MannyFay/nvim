-------------------------------------------------------------------------------
-- TODO Comments Plugin
-- https://github.com/folke/todo-comments.nvim
-- Colorize todos and jump to them.
-------------------------------------------------------------------------------


return {
  "folke/todo-comments.nvim",
  event        = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts         = {
    signs          = true, -- Show icons in the signs column.
    sign_priority  = 8, -- Sign priority.
    keywords       = { -- Keywords recognized as todo comments.
      BUG = {
        icon  = " ", -- Icon used for the sign, and in search results.
        color = "error", -- Can be a hex color, or a named color (see below).
        alt   = { "FIXME", "FIX", "FIXIT", "ISSUE", "PROBLEM", "PROB" }, -- A set of other keywords that all map to this BUG keywords.
        --signs = false,                                                   -- Configure signs for some keywords individually.
      },
      TODO = {
        icon  = " ",
        color = "error",
        -- alt   = { "@TODO", "TODO:", "@TODO:", "todo", "@todo", "todo:", "@todo:", "TASK", "MAKE", "DO", "TASK:", "MAKE:", "DO:" },
        alt   = { "TODO:", "todo", "todo:", "TASK", "MAKE", "DO", "TASK:", "MAKE:", "DO:" },
      },
      HACK = {
        icon  = "󰿗 ",
        color = "warning",
        -- alt   = { "@HACK", "HACK:", "@HACK:", "hack", "@hack", "hack:", "@hack:", "WORKAROUND" }
        alt   = { "HACK:", "hack", "hack:", "WORKAROUND" }
      },
      WARN = {
        icon  = " ",
        color = "warning",
        -- alt   = { "@WARN", "WARN:", "@WARN:", "warn", "@warn", "warn:", "@warn:", "WARNING", "@WARNING", "WARNING:", "@WARNING:", "warning", "@warning", "warning:", "@warning:", "XXX", }
        alt   = { "WARN:", "warn", "warn:", "WARNING", "WARNING:", "warning", "warning:", "XXX" }
      },
      PERFORMANCE = {
        icon  = " ",
        color = "warning",
        alt   = { "OPTIM", "PERF", "OPTIMIZE" }
      },
      NOTE = {
        icon  = " ",
        color = "hint",
        -- alt   = { "@NOTE", "NOTE:", "@NOTE:", "note", "@note", "note:", "@note:", "INFO", "MARK" }
        alt   = { "NOTE:", "note", "note:", "INFO", "MARK" }
      },
      TEST = {
        icon  = "⏲ ",
        color = "test",
        alt   = { "TESTING", "PASSED", "FAILED" }
      },
      LAYOUT = {
        icon  = " ",
        color = "layout",
        alt   = { "DESIGN", "UI" }
      },
      QUESTION = {
        icon  = " ",
        color = "hint",
        alt   = { "HELP", "QUESTIONS", "HELPWANTED" }
      },
    },
    gui_style      = {
      fg = "NONE",                               -- The GUI style to use for the "fg" highlight group.
      bg = "BOLD",                               -- The GUI style to use for the "bg" highlight group.
    },
    merge_keywords = true,                       -- Merge custom keywords with the defaults.
    highlight      = {                           -- Highlighting of the line containing the todo comment.
      multiline         = true,                  -- Enable multi-line todo comments.
      multiline_pattern = "^.",                  -- Lua pattern to match the next multi-line from the start of the matched keyword.
      multiline_context = 10,                    -- Extra lines that will be re-evaluated when changing a line.
      before            = "",                    -- Highlights before the keyword (typically comment characters) - "fg" or "bg" or empty.
      keyword           = "bg",                  -- Highlights on the keyword "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg).
      after             = "fg",                  -- Highlights after the keyword (todo text) "fg" or "bg" or empty.
      pattern           = [[.*<(KEYWORDS)\s*:]], -- Pattern or table of patterns, used for highlighting (vim regex).
      comments_only     = true,                  -- Uses Treesitter to match keywords in comments only.
      max_line_len      = 400,                   -- Ignore lines longer than this.
      exclude           = {},                    -- List of file types to exclude highlighting.
    },
    colors         = {
      error = { "#FF0000" },   -- Red.
      warning = { "#E8BF6A" }, -- Orange.
      info = { "#606366" },    -- Gray.
      hint = { "#4FA544" },    -- Green.
      default = { "#ABABAB" }, -- White.
      test = { "#45C8B0" },    -- Blue.
      layout = { "#C064C7" },  -- Purple.
    },
    search         = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      pattern = [[\b(KEYWORDS):]], -- RipGrep Regex to match keywords.
      --pattern = [[\b(KEYWORDS)\b]],                                       -- Match without the extra colon (you'll likely get false positives).
    },
  },
  config       = function(_, opts)
    local todo_comments = require("todo-comments")


    ---------------------------------------------------------------------------
    --- Settings

    todo_comments.setup(opts)


    ---------------------------------------------------------------------------
    --- Key Mappings

    local keymap = vim.keymap

    keymap.set("n", "tcn", function() todo_comments.jump_next() end, { desc = "Next todo comment" })     -- TODO: Re-think if this is a good map.
    keymap.set("n", "tcp", function() todo_comments.jump_prev() end, { desc = "Previous todo comment" }) -- TODO: Re-think if this is a good map.
  end,
}
