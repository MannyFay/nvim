-------------------------------------------------------------------------------
-- Telescope Plugin
-- https://github.com/nvim-telescope/telescope.nvim
-- Fuzzy finder for files, buffers, git, grep, etc.
-------------------------------------------------------------------------------

return {
  "nvim-telescope/telescope.nvim",
  branch       = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "debugloop/telescope-undo.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
  },
  config       = function()
    local telescope     = require("telescope")
    local actions       = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    --local trouble = require("trouble")
    --local trouble_telescope = require("trouble.providers.telescope")

    -- or create your custom action
    -- local custom_actions = transform_mod({
    --   open_trouble_qflist = function(prompt_bufnr)
    --     trouble.toggle("quickfix")
    --   end,
    -- })

    -- Pass path of current file for operations relative to it.
    function telescope_buffer_dir()
     return vim.fn.expand("%:p:h")
    end

    local fb_actions = require("telescope").extensions.file_browser.actions

    telescope.setup({
      defaults = {
        -- hidden               = true, -- Show hidden files.
        -- no_ignore            = true, -- Show ignored files.
        file_ignore_patterns = {},
        shorten_paths        = false,
        prompt_prefix        = '   ',
        selection_caret      = '',
        path_display         = { "full" },
        border               = true,
        borderchars          = false,
        layout_strategy      = 'horizontal',
        layout_config        = {
          prompt_position = 'top',
          height          = 0.99,
          width           = 0.99,
          horizontal      = { preview_width = 0.5 },
          vertical        = { preview_height = 0.5 },
        },
        sorting_strategy     = 'ascending',
        mappings             = {
          -- Insert mode:
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
            -- ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            -- ["<C-t>"] = trouble_telescope.smart_open_with_trouble,
          },
          -- Normal mode:
          n = {
            -- Close Telescope:
            ['q'] = actions.close,
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
        pickers              = {
          find_files = {
            find_command = {
              --       "rg",
              --       "--files",
              --       "--hidden",
              --       "--no-ignore-vcs",
              --       "-g",
              --       "!**/.git/*",
              --       "-g",
              -- "!**/node_modules/*",
              "**/node_modules/**/*",
              --       "-g", "!**/.repro/*", -- just to hide .repro rtp
            },
            -- hidden = true,
            -- no_ignore = true,
            -- file_ignore_patterns = { },
          },
        },
        extensions           = {
          file_browser = {
            theme = "dropdown",
            hijack_netrw = true,
            mappings = {
              ['i'] = {},
              ['n'] = {
                ['ni'] = fb_actions.create,
                ['P'] = fb_actions.goto_parent_dir,
              },
            },
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -------------------------------------------------------------------------------
    -- Key Mappings
    -------------------------------------------------------------------------------

    local map = vim.keymap.set

    -- keymap.set('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]])
    -- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    -- keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

    map("n", "<leader>ff", "<cmd>Telescope find_files no_ignore=false hidden=true<cr>", { desc = "Fuzzy find files in cwd" })
    map("n", "<leader>fr", "<cmd>Telescope oldfiles hidden=true<cr>", { desc = "Fuzzy find recent files" })
    map("n", "<leader>ft", "<cmd>Telescope live_grep hidden=true<cr>", { desc = "Find string in cwd" })
    map("n", "<leader>fs", "<cmd>Telescope grep_string hidden=true<cr>", { desc = "Find string under cursor" })
    map("n", "<leader>fb", '<cmd>lua reaquire("telescope.builtin").buffers()<cr>', { desc = "Show buffers" })
    map("n", "<leader>fh", '<cmd>lua reaquire("telescope.builtin").help_tags()<cr>', { desc = "Show help tags" })
    map("n", "<leader>fc", '<cmd>lua reaquire("telescope.builtin").resume()<cr>', { desc = "Show resume" })
    map("n", "<leader>fd", '<cmd>lua reaquire("telescope.builtin").diagnostics()<cr>', { desc = "Show diagnostic results" })
    map("n", "<leader>fe", '<cmd>lua reaquire("telescope").extensions.file_browser({ path = "%:p:h", cwd = telescope_buffer_dir(), respect_git_ignore = false, hidden = true, grouped = true, previewer = false, initial_mode = "normal" })<cr>', { desc = "Show diagnostic results" })
  end,
}
