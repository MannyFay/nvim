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
      IDEA = {
        icon  = " ",
        color = "hint",
        alt   = { "idea" }
      },
    },
    gui_style      = {
      fg = "NONE",                               -- The GUI style to use for the "fg" highlight group.
      bg = "NONE",                               -- The GUI style to use for the "bg" highlight group.
    },
    merge_keywords = true,                       -- Merge custom keywords with the defaults.
    highlight      = {                           -- Highlighting of the line containing the todo comment.
      multiline         = true,                  -- Enable multi-line todo comments.
      multiline_pattern = "^.",                  -- Lua pattern to match the next multi-line from the start of the matched keyword.
      multiline_context = 50,                    -- Extra lines that will be re-evaluated when changing a line.
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


    ---------------------------------------------------------------------------
    --- Custom: Highlight first char after comment symbol in todo comments
    --- (Workaround for plugin limitation with multiline comments)

    local ns = vim.api.nvim_create_namespace("todo_first_char")

    -- Color mapping (matches opts.colors above)
    local colors = {
      error   = "#FF0000",
      warning = "#E8BF6A",
      hint    = "#4FA544",
      test    = "#45C8B0",
      layout  = "#C064C7",
    }

    -- Keyword to color mapping
    local keyword_colors = {
      -- error
      BUG = "error", FIXME = "error", FIX = "error", FIXIT = "error",
      ISSUE = "error", PROBLEM = "error", PROB = "error",
      TODO = "error", TASK = "error", MAKE = "error", DO = "error",
      -- warning
      HACK = "warning", WORKAROUND = "warning",
      WARN = "warning", WARNING = "warning", XXX = "warning",
      PERFORMANCE = "warning", OPTIM = "warning", PERF = "warning", OPTIMIZE = "warning",
      -- hint
      NOTE = "hint", INFO = "hint", MARK = "hint",
      QUESTION = "hint", HELP = "hint", QUESTIONS = "hint", HELPWANTED = "hint",
      IDEA = "hint",
      -- test
      TEST = "test", TESTING = "test", PASSED = "test", FAILED = "test",
      -- layout
      LAYOUT = "layout", DESIGN = "layout", UI = "layout",
    }

    -- Create highlight groups
    for name, hex in pairs(colors) do
      vim.api.nvim_set_hl(0, "TodoFirstChar" .. name, { fg = hex })
    end

    -- Common comment patterns
    local comment_patterns = {
      "^(%s*)(//)%s?",           -- // C-style
      "^(%s*)(#)%s?",            -- # Python/Shell/etc
      "^(%s*)(%-%-?)%s?",        -- -- or - Lua/SQL
      "^(%s*)(%*?)%s?",          -- * for multiline block comments
      "^(%s*)(;+)%s?",           -- ; Lisp/Assembly
      "^(%s*)(<!%-%-)%s?",       -- <!-- HTML
      "^(%s*)(/%*)%s?",          -- /* C block start
    }

    -- Find todo keyword in a line
    local function find_keyword(line)
      for kw, _ in pairs(keyword_colors) do
        -- Match keyword with word boundaries
        if line:upper():match("[^%w]" .. kw .. "[^%w]") or
           line:upper():match("^" .. kw .. "[^%w]") or
           line:upper():match("[^%w]" .. kw .. "$") then
          return kw
        end
      end
      return nil
    end

    -- Apply highlighting to buffer
    local function highlight_todo_first_chars(buf)
      buf = buf or vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      local current_keyword = nil

      for lnum, line in ipairs(lines) do
        local indent, comment_sym, comment_end_pos

        -- Try each comment pattern
        for _, pattern in ipairs(comment_patterns) do
          indent, comment_sym = line:match(pattern)
          if comment_sym and comment_sym ~= "" then
            comment_end_pos = #indent + #comment_sym
            -- Skip space after comment symbol
            local after = line:sub(comment_end_pos + 1)
            local space = after:match("^(%s?)")
            comment_end_pos = comment_end_pos + #space
            break
          end
        end

        if comment_sym and comment_sym ~= "" then
          local kw = find_keyword(line)

          if kw then
            -- Keyword line: start tracking
            current_keyword = kw

            -- Find first non-space char position after comment
            local rest = line:sub(comment_end_pos + 1)
            local leading = rest:match("^(%s*)") or ""
            local first_char_pos = comment_end_pos + #leading

            if first_char_pos < #line then
              local color = keyword_colors[kw] or "hint"
              vim.api.nvim_buf_add_highlight(buf, ns, "TodoFirstChar" .. color, lnum - 1, first_char_pos, first_char_pos + 1)
            end

          elseif current_keyword then
            -- Possible continuation line
            local rest = line:sub(comment_end_pos + 1)
            local leading = rest:match("^(%s*)") or ""
            local first_char_pos = comment_end_pos + #leading

            -- Check if there's actual content
            if rest:match("%S") and first_char_pos < #line then
              local color = keyword_colors[current_keyword] or "hint"
              vim.api.nvim_buf_add_highlight(buf, ns, "TodoFirstChar" .. color, lnum - 1, first_char_pos, first_char_pos + 1)
            else
              current_keyword = nil
            end
          end
        else
          -- Not a comment line, reset
          current_keyword = nil
        end
      end
    end

    -- Set up autocmds
    local augroup = vim.api.nvim_create_augroup("TodoFirstCharHighlight", { clear = true })
    local timer = nil

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "TextChangedI" }, {
      group = augroup,
      callback = function(args)
        -- Debounce to avoid performance issues
        if timer then
          vim.fn.timer_stop(timer)
        end
        timer = vim.fn.timer_start(50, function()
          if vim.api.nvim_buf_is_valid(args.buf) then
            vim.schedule(function()
              highlight_todo_first_chars(args.buf)
            end)
          end
        end)
      end,
    })

    -- Initial highlight
    highlight_todo_first_chars()
  end,
}
