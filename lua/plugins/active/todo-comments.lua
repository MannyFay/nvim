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
    signs         = true,   -- Show icons in the signs column.
    sign_priority = 8,      -- Sign priority.
    keywords      = {       -- Keywords recognized as todo comments.
      BUG = {
        icon = " ",                                           -- Icon used for the sign, and in search results.
        color = "error",                                       -- Can be a hex color, or a named color (see below).
        alt = { "FIXME", "FIX", "FIXIT", "ISSUE", "PROBLEM" }, -- A set of other keywords that all map to this BUG keywords.
        -- signs = false,                                        -- Configure signs for some keywords individually.
      },
      -- TODO = { icon = " ", color = "info" },
      TODO = { icon = " ", color = "error" },
      -- HACK = { icon = " ", color = "warning" },
      HACK = { icon = "󰿗 ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", color = "warning", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      -- NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO", "MARK" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      LAYOUT = { icon = " ", color = "layout", alt = { "DESIGN", "UI" } },
    },
  gui_style = {
    fg = "NONE", -- The gui style to use for the fg highlight group.
    bg = "BOLD", -- The gui style to use for the bg highlight group.
  },
  merge_keywords = true, -- when true, custom keywords will be merged with the defaults
  -- highlighting of the line containing the todo comment
  -- * before: highlights before the keyword (typically comment characters)
  -- * keyword: highlights of the keyword
  -- * after: highlights after the keyword (todo text)
  highlight = {
    multiline = true, -- enable multine todo comments
    multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
    multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
    before = "", -- "fg" or "bg" or empty
    keyword = "bg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
    after = "fg", -- "fg" or "bg" or empty
    pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
    comments_only = true, -- uses treesitter to match keywords in comments only
    max_line_len = 400, -- ignore lines longer than this
    exclude = {}, -- list of file types to exclude highlighting
  },
  -- list of named colors where we try to extract the guifg from the
  -- list of highlight groups or use the hex color if hl not found as a fallback
  colors = {
    error = { "#FF0000" },
    warning = {"#E8BF6A" },
    info = { "#606366" },
    hint = { "#4FA544" },
    default = { "#ABABAB" },
    test = { "#45C8B0" },
    layout = {"#C064C7"},
  },
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
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

    keymap.set("n", "tcn", function() todo_comments.jump_next() end, { desc = "Next todo comment" })
    keymap.set("n", "tcp", function() todo_comments.jump_prev() end, { desc = "Previous todo comment" })

  end,
}
