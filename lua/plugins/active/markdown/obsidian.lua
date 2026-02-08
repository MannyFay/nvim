-------------------------------------------------------------------------------
-- Obsidian Plugin
-- https://github.com/obsidian-nvim/obsidian.nvim
-- Plugin for writing and navigating Obsidian vaults.
-------------------------------------------------------------------------------

-- Vault path per platform:
local vault_path
if vim.fn.has("macunix") == 1 then
  vault_path = vim.fn.expand("~/Library/Mobile Documents/iCloud~md~obsidian/Documents/notebook")
else
  vault_path = vim.fn.expand("~/Documents/notebook")
end

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  cond = vim.env.MACHINE_TYPE ~= "work-vds", -- Disable on work machine.
  event = {
    "BufReadPre " .. vault_path .. "/**.md",
    "BufNewFile " .. vault_path .. "/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    legacy_commands = false,
    log_level = vim.log.levels.INFO,

    ---------------------------------------------------------------------------
    -- Workspaces

    workspaces = {
      {
        name = "notebook",
        path = vault_path,
      },
    },

    ---------------------------------------------------------------------------
    -- Notes & Files

    notes_subdir = "0-inbox",
    new_notes_location = "notes_subdir",
    open_notes_in = "vsplit", -- "current", "vsplit", "hsplit"

    -- Custom note ID generation
    note_id_func = function(title)
      if title ~= nil then
        return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        return tostring(os.time())
      end
    end,

    -- Custom note path generation (optional)
    -- note_path_func = function(spec)
    --   local path = spec.dir / tostring(spec.id)
    --   return path:with_suffix(".md")
    -- end,

    ---------------------------------------------------------------------------
    -- Links

    preferred_link_style = "wiki", -- "wiki" or "markdown"

    -- Custom wiki link generation (optional)
    -- wiki_link_func = function(opts)
    --   return require("obsidian.util").wiki_link_id_prefix(opts)
    -- end,

    -- Custom markdown link generation (optional)
    -- markdown_link_func = function(opts)
    --   return require("obsidian.util").markdown_link(opts)
    -- end,

    ---------------------------------------------------------------------------
    -- Frontmatter (YAML header)

    frontmatter = {
      enabled = false,  -- Don't use the frontmatter note header feature.
      sort = { "id", "aliases", "tags" },
    },

    -- Custom frontmatter function (optional)
    -- note_frontmatter_func = function(note)
    --   local out = { id = note.id, aliases = note.aliases, tags = note.tags }
    --   if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
    --     for k, v in pairs(note.metadata) do
    --       out[k] = v
    --     end
    --   end
    --   return out
    -- end,

    ---------------------------------------------------------------------------
    -- Daily Notes

    daily_notes = {
      folder = "periodic-notes/daily",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      default_tags = { "daily" },
      template = "daily-nvim.md",
      workdays_only = false,
    },

    ---------------------------------------------------------------------------
    -- Templates

    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      substitutions = {
        -- {{id}} - YYYYMMDDHHMM format
        id = function()
          return os.date("%Y%m%d%H%M")
        end,
        -- {{yesterday}} - Yesterday's date
        yesterday = function()
          return os.date("%Y-%m-%d", os.time() - 86400)
        end,
        -- {{tomorrow}} - Tomorrow's date
        tomorrow = function()
          return os.date("%Y-%m-%d", os.time() + 86400)
        end,
        -- {{yesterday_link}} - [[YYYY-MM-DD]] link to yesterday
        yesterday_link = function()
          return "[[" .. os.date("%Y-%m-%d", os.time() - 86400) .. "]]"
        end,
        -- {{tomorrow_link}} - [[YYYY-MM-DD]] link to tomorrow
        tomorrow_link = function()
          return "[[" .. os.date("%Y-%m-%d", os.time() + 86400) .. "]]"
        end,
        -- {{prev_month}} - Previous month (YYYY-MM)
        prev_month = function()
          local year, month = tonumber(os.date("%Y")), tonumber(os.date("%m"))
          month = month - 1
          if month == 0 then month, year = 12, year - 1 end
          return string.format("%04d-%02d", year, month)
        end,
        -- {{next_month}} - Next month (YYYY-MM)
        next_month = function()
          local year, month = tonumber(os.date("%Y")), tonumber(os.date("%m"))
          month = month + 1
          if month == 13 then month, year = 1, year + 1 end
          return string.format("%04d-%02d", year, month)
        end,
        -- {{prev_month_link}} - [[YYYY-MM]] link to previous month
        prev_month_link = function()
          local year, month = tonumber(os.date("%Y")), tonumber(os.date("%m"))
          month = month - 1
          if month == 0 then month, year = 12, year - 1 end
          return string.format("[[%04d-%02d]]", year, month)
        end,
        -- {{next_month_link}} - [[YYYY-MM]] link to next month
        next_month_link = function()
          local year, month = tonumber(os.date("%Y")), tonumber(os.date("%m"))
          month = month + 1
          if month == 13 then month, year = 1, year + 1 end
          return string.format("[[%04d-%02d]]", year, month)
        end,
        -- {{prev_quarter}} - Previous quarter (YYYY-QN)
        prev_quarter = function()
          local year = tonumber(os.date("%Y"))
          local quarter = math.ceil(tonumber(os.date("%m")) / 3)
          quarter = quarter - 1
          if quarter == 0 then quarter, year = 4, year - 1 end
          return string.format("%04d-Q%d", year, quarter)
        end,
        -- {{next_quarter}} - Next quarter (YYYY-QN)
        next_quarter = function()
          local year = tonumber(os.date("%Y"))
          local quarter = math.ceil(tonumber(os.date("%m")) / 3)
          quarter = quarter + 1
          if quarter == 5 then quarter, year = 1, year + 1 end
          return string.format("%04d-Q%d", year, quarter)
        end,
        -- {{prev_quarter_link}} - [[YYYY-QN]] link to previous quarter
        prev_quarter_link = function()
          local year = tonumber(os.date("%Y"))
          local quarter = math.ceil(tonumber(os.date("%m")) / 3)
          quarter = quarter - 1
          if quarter == 0 then quarter, year = 4, year - 1 end
          return string.format("[[%04d-Q%d]]", year, quarter)
        end,
        -- {{next_quarter_link}} - [[YYYY-QN]] link to next quarter
        next_quarter_link = function()
          local year = tonumber(os.date("%Y"))
          local quarter = math.ceil(tonumber(os.date("%m")) / 3)
          quarter = quarter + 1
          if quarter == 5 then quarter, year = 1, year + 1 end
          return string.format("[[%04d-Q%d]]", year, quarter)
        end,
        -- {{prev_week}} - Previous week (YYYY-WNN)
        prev_week = function()
          local prev = os.time() - (7 * 86400)
          return os.date("%Y-W%V", prev)
        end,
        -- {{next_week}} - Next week (YYYY-WNN)
        next_week = function()
          local next = os.time() + (7 * 86400)
          return os.date("%Y-W%V", next)
        end,
        -- {{prev_week_link}} - [[YYYY-WNN]] link to previous week
        prev_week_link = function()
          local prev = os.time() - (7 * 86400)
          return "[[" .. os.date("%Y-W%V", prev) .. "]]"
        end,
        -- {{next_week_link}} - [[YYYY-WNN]] link to next week
        next_week_link = function()
          local next = os.time() + (7 * 86400)
          return "[[" .. os.date("%Y-W%V", next) .. "]]"
        end,
        -- {{prev_year}} - Previous year (YYYY)
        prev_year = function()
          return tostring(tonumber(os.date("%Y")) - 1)
        end,
        -- {{next_year}} - Next year (YYYY)
        next_year = function()
          return tostring(tonumber(os.date("%Y")) + 1)
        end,
        -- {{prev_year_link}} - [[YYYY]] link to previous year
        prev_year_link = function()
          return "[[" .. (tonumber(os.date("%Y")) - 1) .. "]]"
        end,
        -- {{next_year_link}} - [[YYYY]] link to next year
        next_year_link = function()
          return "[[" .. (tonumber(os.date("%Y")) + 1) .. "]]"
        end,
      },
    },

    ---------------------------------------------------------------------------
    -- Completion

    completion = {
      -- nvim_cmp and blink are auto-detected
      min_chars = 1,
      match_case = true,
      create_new = true,
    },

    ---------------------------------------------------------------------------
    -- Picker (Telescope, fzf-lua, mini.pick, snacks)

    picker = {
      name = "telescope.nvim",
      note_mappings = {
        new = "<C-x>",
        insert_link = "<C-l>",
      },
      tag_mappings = {
        tag_note = "<C-x>",
        insert_tag = "<C-l>",
      },
    },

    ---------------------------------------------------------------------------
    -- Search

    search = {
      sort_by = "modified", -- "modified", "created", "path"
      sort_reversed = true, -- Newest first
      max_lines = 1000,
    },

    ---------------------------------------------------------------------------
    -- UI (Markdown rendering in Neovim)

    ui = {
      enable = false, -- Disabled: render-markdown.nvim handles rendering (both UIs cause freezes)
    },

    ---------------------------------------------------------------------------
    -- Checkboxes

    checkbox = {
      order = { " ", "x", ">", "~", "!" },
      markers = {
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
        [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        ["!"] = { char = "", hl_group = "ObsidianImportant" },
      },
      -- hl_groups defined in mannydark.nvim/lua/mannydark/highlighting/plugins/obsidian.lua
    },

    ---------------------------------------------------------------------------
    -- Attachments

    attachments = {
      folder = "attachments",
      confirm_img_paste = true,
      -- Custom image name function (optional)
      -- img_name_func = function()
      --   return string.format("%s-", os.time())
      -- end,
    },

    ---------------------------------------------------------------------------
    -- Obsidian App Integration

    open = {
      func = function(uri)
        vim.ui.open(uri)
      end,
    },
  },

  config = function(_, opts)
    require("obsidian").setup(opts)

    ---------------------------------------------------------------------------
    -- Custom Periodic Notes Commands
    -- Weekly, Monthly, Quarterly, Yearly (Daily is built-in via :ObsidianToday)

    local vault_path = opts.workspaces[1].path

    -- Helper: Check if file is new (doesn't exist or is empty)
    local function is_new_file(path)
      local stat = vim.loop.fs_stat(path)
      return stat == nil or stat.size == 0
    end

    -- Helper: Open or create a periodic note with template
    local function open_periodic_note(folder, filename, template)
      local path = vault_path .. "/periodic-notes/" .. folder .. "/" .. filename .. ".md"
      local is_new = is_new_file(path)
      vim.cmd("edit " .. path)
      if is_new and template then
        vim.cmd("ObsidianTemplate " .. template)
      end
    end

    -- Helper: Get quarter number (1-4)
    local function get_quarter(month)
      return math.ceil(month / 3)
    end

    -- :ObsidianWeekly - Open/create weekly note (2026-W03.md)
    vim.api.nvim_create_user_command("ObsidianWeekly", function()
      local filename = os.date("%Y-W%V")
      open_periodic_note("weekly", filename, "weekly-nvim.md")
    end, { desc = "Open weekly note" })

    -- :ObsidianMonthly - Open/create monthly note (2026-01.md)
    vim.api.nvim_create_user_command("ObsidianMonthly", function()
      local filename = os.date("%Y-%m")
      open_periodic_note("monthly", filename, "monthly-nvim.md")
    end, { desc = "Open monthly note" })

    -- :ObsidianQuarterly - Open/create quarterly note (2026-Q1.md)
    vim.api.nvim_create_user_command("ObsidianQuarterly", function()
      local year = os.date("%Y")
      local quarter = get_quarter(tonumber(os.date("%m")))
      local filename = year .. "-Q" .. quarter
      open_periodic_note("quarterly", filename, "quarterly-nvim.md")
    end, { desc = "Open quarterly note" })

    -- :ObsidianYearly - Open/create yearly note (2026.md)
    vim.api.nvim_create_user_command("ObsidianYearly", function()
      local filename = os.date("%Y")
      open_periodic_note("yearly", filename, "yearly-nvim.md")
    end, { desc = "Open yearly note" })

    -- :ObsidianNewNote - Create new note with template
    vim.api.nvim_create_user_command("ObsidianNewNote", function()
      vim.ui.input({ prompt = "Note title: " }, function(title)
        if not title or title == "" then return end
        local filename = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        local path = vault_path .. "/" .. opts.notes_subdir .. "/" .. filename .. ".md"
        local is_new = is_new_file(path)
        vim.cmd("edit " .. path)
        if is_new then
          vim.cmd("ObsidianTemplate note-nvim.md")
        end
      end)
    end, { desc = "Create new note with template" })

    ---------------------------------------------------------------------------
    -- Keymaps

    local keymap = vim.keymap.set
    keymap("n", "<leader>od", "<cmd>ObsidianToday<cr>", { desc = "Obsidian Daily" })
    keymap("n", "<leader>ow", "<cmd>ObsidianWeekly<cr>", { desc = "Obsidian Weekly" })
    keymap("n", "<leader>om", "<cmd>ObsidianMonthly<cr>", { desc = "Obsidian Monthly" })
    keymap("n", "<leader>oq", "<cmd>ObsidianQuarterly<cr>", { desc = "Obsidian Quarterly" })
    keymap("n", "<leader>oy", "<cmd>ObsidianYearly<cr>", { desc = "Obsidian Yearly" })
    keymap("n", "<leader>on", "<cmd>ObsidianNewNote<cr>", { desc = "Obsidian New Note" })
    keymap("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "Obsidian Open in App" })
    keymap("n", "<leader>os", "<cmd>ObsidianSearch<cr>", { desc = "Obsidian Search" })
    keymap("n", "<leader>of", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Obsidian Find Note" })
    keymap("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>", { desc = "Obsidian Backlinks" })
    keymap("n", "<leader>ot", "<cmd>ObsidianTags<cr>", { desc = "Obsidian Tags" })
  end,
}

