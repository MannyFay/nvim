-- https://github.com/nvim-telescope/telescope.nvim



------------------------------------------------------------------------------
-- Telescope Plugin
------------------------------------------------------------------------------

-- Import Telescope with a protected call:
local telescope_status_ok, telescope = pcall(require, 'telescope')
if not telescope_status_ok then
  return
end

local actions = require('telescope.actions')


------------------------------------------------------------
-- Key Mappings

-- Load Telescopes builtin function:
local builtin = require('telescope.builtin')

-- Find files with ignored files by Git ( ff):
vim.keymap.set('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]])

-- Find text inside files ( ft):
vim.keymap.set('n', '<leader>ft', builtin.live_grep, {})

-- Show recent files:
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})


------------------------------------------------------------
-- Appearance

-- Colors
local hl = vim.api.nvim_set_hl
hl(0, 'TelescopePromptTitle',   { fg = '#ababab', bg = 'NONE' })
hl(0, 'TelescopeResultsTitle',  { fg = '#ababab', bg = 'NONE' })
hl(0, 'TelescopePreviewTitle',  { fg = '#ababab', bg = 'NONE' })
hl(0, 'TelescopePromptNormal',  { fg = '#ababab', bg = '#252525' })
hl(0, 'TelescopeNormal',        { fg = '#ababab', bg = '#191B1C' })
hl(0, 'TelescopeBorder',        { fg = '#ababab', bg = '#252525' })
hl(0, 'TelescopePromptBorder',  { fg = '#252525', bg = '#252525' })
hl(0, 'TelescopeResultsBorder', { fg = '#252525', bg = '#252525' })
hl(0, 'TelescopePreviewBorder', { fg = '#252525', bg = '#252525' })
hl(0, 'TelescopeSelection',     { fg = '#ababab', bg = '#252525' })
hl(0, 'TelescopePromptCounter', { fg = '#A5C25C', bg = '#252525' })
--[[ hl(0, 'TelescopeMatching', { fg = '#569CD6', bg = '#252525' }) ]]


telescope.setup {
  defaults = {
    shorten_paths = false,
    prompt_prefix = '   ',
    selection_caret = '',
    path_display = { 'full' },
    border = true,
    borderchars = false,
    layout_strategy = 'horizontal',
    layout_config = {
      prompt_position = 'top',
      height = 0.99,
      width  = 0.99,
      horizontal = { preview_width = 0.5 },
      vertical = { preview_height = 0.5 },
    },
    sorting_strategy = 'ascending',
    mappings = {
      -- Normal mode:
      n = {
        -- Close Telescope:
        ['<C-q>'] = actions.close,
        ----- Results Panel: -----
        -- Open file in active buffer:
        ['<CR>'] = actions.select_default,
        -- Open file in new horizontal split:
        ['-'] = actions.select_horizontal,
        -- Open file in new vertical split:
        ['|'] = actions.select_vertical,
        -- Navigate down:
        ['j'] = actions.move_selection_next,
        -- Navigate up:
        ['k'] = actions.move_selection_previous,
        -- Jump to the middle:
        ['M'] = actions.move_to_middle,
        -- Jump to the top:
        ['gg'] = actions.move_to_top,
        -- Jump to the bottom:
        ['G'] = actions.move_to_bottom,
        -- Scroll up:
        ['<C-k>'] = actions.results_scrolling_up,
        -- Scroll down:
        ['<C-j>'] = actions.results_scrolling_down,
        ----- Preview Panel: -----
        -- Scroll up:
        ['<C-p-u>'] = actions.preview_scrolling_up,
        -- Scroll down:
        ['<C-p-d>'] = actions.preview_scrolling_down,
      },
    },
    -- Ignore files in .git directory:
    file_ignore_patterns = { '.git/'},
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    buffers = {
      previewer = false,
      layout_config = {
        width = 80,
      },
    },
    oldfiles = {
      prompt_title = 'Recent Files',
    },
    lsp_references = {
      previewer = false,
    },
  },
  extensions = {
    extensions = {
      fzf = {
        -- False will only do exact matching:
        fuzzy = true,
        -- Override the generic sorter:
        override_generic_sorter = true,
        -- Override the file sorter:
        override_file_sorter = true,
        -- Options are 'ignore_case', 'respect_case', 'smart_case':
        case_mode = 'smart_case',
      },
      media_files = {
          -- Whitelist:
          -- Defaults are { 'png', 'jpg', 'mp4', 'webm', 'pdf' }
          filetypes = { 'png', 'webp', 'jpg', 'jpeg' },
          -- Find command (defaults is 'fd'):
          find_cmd = 'rg'
        }
      },
    -- Set the previewer to display the full path:
    previewer = function(opts)
      -- Get the full path of the selected entry:
      local path = require('telescope.previewers.utils').path_shorten(opts.entry.display)
      -- Build the previewer lines with the full path:
      local lines = vim.split(opts.preview, '\n')
      table.insert(lines, 2, 'Full Path: ' .. path)
      return lines
    end,
  },
}

-- Load FZF extension:
telescope.load_extension('fzf')

-- Load Live Grep Arguments extension:
telescope.load_extension('live_grep_args')

-- Load Media Files extension:
telescope.load_extension('media_files')
