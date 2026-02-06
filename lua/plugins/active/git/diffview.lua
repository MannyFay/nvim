-------------------------------------------------------------------------------
-- Diffview Plugin
-- https://github.com/sindrets/diffview.nvim
-- Advanced Git diff viewer for file diffs, merge conflicts, history, and more.
-------------------------------------------------------------------------------

return {
  "sindrets/diffview.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
  config = function()
    local actions = require("diffview.actions")

    require("diffview").setup({
      diff_binaries = false,
      enhanced_diff_hl = false,
      use_icons = true,
      watch_index = true,

      view = {
        default = {
          layout = "diff2_horizontal",
        },
        merge_tool = {
          layout = "diff3_horizontal",
        },
      },

      file_panel = {
        listing_style = "tree",
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded",
        },
        win_config = {
          position = "left",
          width = 35,
        },
      },

      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              diff_merges = "combined",
            },
            multi_file = {
              diff_merges = "first-parent",
            },
          },
        },
        win_config = {
          position = "bottom",
          height = 16,
        },
      },

      keymaps = {
        disable_defaults = false,
        view = {
          { "n", "<tab>",      actions.select_next_entry, { desc = "Next file" } },
          { "n", "<s-tab>",    actions.select_prev_entry, { desc = "Previous file" } },
          { "n", "gf",         actions.goto_file,         { desc = "Open file" } },
          { "n", "<C-w><C-f>", actions.goto_file_split,   { desc = "Open file in split" } },
          { "n", "<C-w>gf",    actions.goto_file_tab,     { desc = "Open file in tab" } },
          { "n", "<leader>e",  actions.focus_files,        { desc = "Focus file panel" } },
          { "n", "<leader>b",  actions.toggle_files,       { desc = "Toggle file panel" } },
        },
        file_panel = {
          { "n", "j",             actions.next_entry,          { desc = "Next entry" } },
          { "n", "k",             actions.prev_entry,          { desc = "Previous entry" } },
          { "n", "<cr>",          actions.select_entry,        { desc = "Open diff" } },
          { "n", "o",             actions.select_entry,        { desc = "Open diff" } },
          { "n", "-",             actions.toggle_stage_entry,  { desc = "Stage/unstage" } },
          { "n", "s",             actions.toggle_stage_entry,  { desc = "Stage/unstage" } },
          { "n", "S",             actions.stage_all,           { desc = "Stage all" } },
          { "n", "U",             actions.unstage_all,         { desc = "Unstage all" } },
          { "n", "X",             actions.restore_entry,       { desc = "Restore entry" } },
          { "n", "R",             actions.refresh_files,       { desc = "Refresh" } },
          { "n", "<tab>",         actions.select_next_entry,   { desc = "Next file" } },
          { "n", "<s-tab>",       actions.select_prev_entry,   { desc = "Previous file" } },
          { "n", "gf",            actions.goto_file,           { desc = "Go to file" } },
          { "n", "i",             actions.listing_style,       { desc = "Toggle list/tree" } },
          { "n", "f",             actions.toggle_flatten_dirs, { desc = "Flatten dirs" } },
          { "n", "<leader>e",     actions.focus_files,         { desc = "Focus file panel" } },
          { "n", "<leader>b",     actions.toggle_files,        { desc = "Toggle file panel" } },
        },
        file_history_panel = {
          { "n", "g!",     actions.options,            { desc = "Options" } },
          { "n", "<cr>",   actions.select_entry,       { desc = "Open diff" } },
          { "n", "o",      actions.select_entry,       { desc = "Open diff" } },
          { "n", "<tab>",  actions.select_next_entry,  { desc = "Next commit" } },
          { "n", "<s-tab>", actions.select_prev_entry, { desc = "Previous commit" } },
          { "n", "gf",     actions.goto_file,          { desc = "Go to file" } },
          { "n", "y",      actions.copy_hash,          { desc = "Copy commit hash" } },
        },
      },
    })

    ---------------------------------------------------------------------------
    -- Key Mappings

    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>",           vim.tbl_extend("force", opts, { desc = "Open diff view" }))
    vim.keymap.set("n", "<leader>gD", ":DiffviewClose<CR>",          vim.tbl_extend("force", opts, { desc = "Close diff view" }))
    vim.keymap.set("n", "<leader>gh", ":DiffviewFileHistory %<CR>",  vim.tbl_extend("force", opts, { desc = "File history (current)" }))
    vim.keymap.set("n", "<leader>gH", ":DiffviewFileHistory<CR>",    vim.tbl_extend("force", opts, { desc = "File history (all)" }))
    vim.keymap.set("v", "<leader>gh", ":'<,'>DiffviewFileHistory<CR>", vim.tbl_extend("force", opts, { desc = "Line history (visual)" }))
  end,
}
