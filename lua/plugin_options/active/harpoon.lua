-------------------------------------------------------------------------------
-- Harpoon Plugin
-- https://github.com/ThePrimeagen/harpoon/tree/harpoon2
-------------------------------------------------------------------------------

-- Import Harpoon plugin safely:
local harpoon_status_ok, harpoon = pcall(require, 'harpoon')
if not harpoon_status_ok then
  return "Error: */lua/user/plugin_options/harpoon.lua -> Harpoon plugin could not be loaded. Sure you have installed it in your plugins file?"
end


-------------------------------------------------------------------------------
-- Harpoon Plugin

harpoon:setup({
  settings = {
    save_on_toggle         = false,          -- Bookmark file if you jump into it.
    save_on_change         = true,           -- Save bookmarked file if you change it.
    sync_on_ui_close       = false,        -- Sync all bookmarks if UI is closed.
    enter_on_sendcmd       = false,        -- Enter the terminal when running a command.
    tmux_autoclose_windows = false,  -- Don't close the tmux window when the pane closes.
    exclude_filetypes      = { 'harpoon' }, -- Filetypes to exclude when picking files.
    mark_branch            = true,           -- Set marks specific to each git branch.
    tabline                = false,         -- Enable tabline integration.
    tabline_prefix         = " ",
    tabline_suffix         = " ",
    key = function()
        return vim.loop.cwd()
    end,
  },
})



-------------------------------------------------------------------------------
-- Harpoon Telescope Setup

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = require("telescope.finders").new_table({
      results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end

vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,  { desc = "Open harpoon window" })



-------------------------------------------------------------------------------
-- Key Mappings

-- Jump to a file in the Harpoon list:
vim.keymap.set("n", "<Leader>hs1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<Leader>hs2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<Leader>hs3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<Leader>hs4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<Leader>hs5", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<Leader>hs6", function() harpoon:list():select(6) end)
vim.keymap.set("n", "<Leader>hs7", function() harpoon:list():select(7) end)
vim.keymap.set("n", "<Leader>hs8", function() harpoon:list():select(8) end)
vim.keymap.set("n", "<Leader>hs9", function() harpoon:list():select(9) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<Leader>hp", function() harpoon:list():prev() end)
vim.keymap.set("n", "<Leader>hn", function() harpoon:list():next() end)

-- Mark a file:
vim.keymap.set("n", "<leader>hm", function() harpoon:list():append() end)

-- Show Harpoon marks:
vim.keymap.set("n", "<Leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

-- Show Harpoon marks in Telescope interface:
vim.keymap.set('n', '<Leader>fm', ':Telescope harpoon marks<CR>')

-- To delete mark 1 from the list:
-- vim.keymap.set("n", "<leader>d1", function() harpoon:list():remove(1) end)