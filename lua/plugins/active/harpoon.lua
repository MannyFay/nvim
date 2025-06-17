-------------------------------------------------------------------------------
-- Harpoon Plugin
-- https://github.com/ThePrimeagen/harpoon/tree/harpoon2
-- Mark files and jump to them quickly.
-------------------------------------------------------------------------------

return {
  "ThePrimeagen/harpoon",
  branch       = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config       = function()
    local harpoon = require("harpoon")


    ---------------------------------------------------------------------------
    ----- Harpoon Telescope Setup

    local conf = require("telescope.config").values

    local function toggle_telescope(harpoon_files)
      local file_paths = {}

      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder       = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter    = conf.generic_sorter({}),
      }):find()
    end



    ---------------------------------------------------------------------------
    ----- Key Mappings

    vim.keymap.set("n", "<leader>fm", function() toggle_telescope(harpoon:list()) end,  { desc = "Open harpoon window" })  -- Open Harpoon marks in Telescope.
    vim.keymap.set("n", "<leader>hm", function() harpoon:list():add() end)                                                 -- Mark a file and add it to the Harpoon list.
    vim.keymap.set("n", "<Leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)                         -- Show Harpoon marks in floating window.
    vim.keymap.set("n", "<Leader>hp", function() harpoon:list():prev() end)                                                -- Jump to previous mark. TODO: Not a good map by now. Create a better one.
    vim.keymap.set("n", "<Leader>hn", function() harpoon:list():next() end)                                                -- Jump to next mark.   TODO: Not a good map by now. Create a better one.
    vim.keymap.set("n", "<Leader>h1", function() harpoon:list():select(1) end)                                             -- Jump to mark 1.
    vim.keymap.set("n", "<Leader>h2", function() harpoon:list():select(2) end)                                             -- Jump to mark 2.
    vim.keymap.set("n", "<Leader>h3", function() harpoon:list():select(3) end)                                             -- Jump to mark 3.
    vim.keymap.set("n", "<Leader>h4", function() harpoon:list():select(4) end)                                             -- Jump to mark 4.
    vim.keymap.set("n", "<Leader>h5", function() harpoon:list():select(5) end)                                             -- Jump to mark 5.
    vim.keymap.set("n", "<Leader>h6", function() harpoon:list():select(6) end)                                             -- Jump to mark 6.
    vim.keymap.set("n", "<Leader>h7", function() harpoon:list():select(7) end)                                             -- Jump to mark 7.
    vim.keymap.set("n", "<Leader>h8", function() harpoon:list():select(8) end)                                             -- Jump to mark 8.
    vim.keymap.set("n", "<Leader>h9", function() harpoon:list():select(9) end)                                             -- Jump to mark 9.



    ---------------------------------------------------------------------------
    ----- Settings

    harpoon:setup({
      settings = {
        save_on_toggle         = false,          -- Bookmark file if you jump into it.
        save_on_change         = true,           -- Save bookmarked file if you change it.
        sync_on_ui_close       = false,          -- Sync all bookmarks if UI is closed.
        enter_on_sendcmd       = false,          -- Enter the terminal when running a command.
        tmux_autoclose_windows = false,          -- Don't close the tmux window when the pane closes.
        exclude_filetypes      = { 'harpoon' },  -- File types to exclude when picking files.
        mark_branch            = true,           -- Set marks specific to each git branch.
        tabline                = false,          -- Enable tab line integration.
        tabline_prefix         = " ",
        tabline_suffix         = " ",
        key = function()
          local cwd = vim.loop.cwd()

          return cwd or ""
        end,
      },
    })

    harpoon:extend({
      UI_CREATE = function(cx)
        vim.keymap.set("n", "<\\|>", function() harpoon.ui:select_menu_item({ vsplit  = true }) end, { buffer = cx.bufnr })  -- Open marked file in vertical split. TODO: Not working by now, fix it. Try <\\|> <-- Not working too.
        -- vim.keymap.set("n", "<C-x>", function() harpoon.ui:select_menu_item({ split   = true }) end, { buffer = cx.bufnr })
        -- vim.keymap.set("n", "<C-t>", function() harpoon.ui:select_menu_item({ tabedit = true }) end, { buffer = cx.bufnr })
      end,
    })

  end,
}

