-------------------------------------------------------------------------------
-- NeoGit Plugin
-- https://github.com/NeogitOrg/neogit
-- Git interface for Neovim.
-------------------------------------------------------------------------------

return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local neogit = require("neogit")

    neogit.setup {
      disable_hint                 = false,     -- Show hints at the top of the status buffer.
      disable_context_highlighting = false,     -- Disables changing the buffer highlights based on where the cursor is.
      disable_signs                = false,     -- Disables signs for sections/items/hunks
      disable_insert_on_commit     = "auto",    -- Mode, where commit UI starts in. "true" = "n", "false" = "i", "auto" = "n" if empty.
      filewatcher                  = {          -- Options for watching the `.git/` directory for changes.
        interval = 1000,                        -- Time in milliseconds to check for changes.
        enabled  = true,                        -- Enable the file-watcher.
      },
      graph_style                  = "unicode", -- Possible: "ascii" (regular CLI), "unicode (https://github.com/rbong/vim-flog)" .
      git_services                 = {          -- To generate URL's for branch popup action "pull request".
        ["azure.com"]     = {
          pull_request = "https://dev.azure.com/${owner}/_git/${repository}/pullrequestcreate?sourceRef=${branch_name}&targetRef=${target}",
        },
        ["bitbucket.org"] = {
          pull_request = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
        },
        ["github.com"]    = {
          pull_request = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
        },
        ["gitlab.com"]    = {
          pull_request = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
        },
      },
      telescope_sorter             = function()                        -- Telescope sorter.
        return require("telescope").extensions.fzf.native_fzf_sorter() -- FZF as sorter.
      end,
      remember_settings            = true,                             -- Persist the values of switches/options within and across sessions
      use_per_project_settings     = true,                             -- Scope persisted settings on a per-project basis
      ignored_settings             = {                                 -- Settings to never persist (format: "Filetype--cli-value").
        "NeogitPushPopup--force-with-lease",
        "NeogitPushPopup--force",
        "NeogitPullPopup--rebase",
        "NeogitCommitPopup--allow-empty",
        "NeogitRevertPopup--no-edit",
      },
      highlight                    = { -- Highlight group features.
        italic    = true,
        bold      = true,
        underline = true
      },
      use_default_keymaps          = true,             -- false: Create own _ALL_ key-mappings.
      auto_refresh                 = true,             -- Refreshes Neogit state (can be slow in big repos).
      sort_branches                = "-committerdate", -- Sorting of branches (descending).
      kind                         = "floating",       -- How to open status ("tab", "split", "vsplit", "floating").
      disable_line_numbers         = false,            -- Enable line numbers and relative line numbers.
      console_timeout              = 2000,             -- Time (milliseconds) when output console is shown for slow running commands.
      auto_show_console            = true,             -- Show console if commands takes more than console_timeout.
      auto_close_console           = true,             -- Close the console if the process exits with a 0 (success) status.
      status                       = {
        show_head_commit_hash = true,
        recent_commit_count   = 10,
        HEAD_padding          = 10,
        HEAD_folded           = false,
        mode_padding          = 3,
        mode_text             = {
          M     = "   Modified:",
          N     = " 󰵺  New file:",
          A     = " 󰾛  Staged:",
          D     = "   Deleted:",
          C     = "Copied:",
          U     = "Updated:",
          R     = "   Renamed:",
          DD    = "   Unmerged:",
          AU    = "   Unmerged:",
          UD    = "   Unmerged:",
          UA    = "   Unmerged:",
          DU    = "   Unmerged:",
          AA    = "   Unmerged:",
          UU    = "   Unmerged:",
          ["?"] = "",
        },
      },
      commit_editor                = {
        kind = "vsplit", -- Possible: "tab", "split", "vsplit", "floating".
        show_staged_diff = true,
        -- Accepted values:
        -- "split" to show the staged diff below the commit editor
        -- "vsplit" to show it to the right
        -- "split_above" Like :top split
        -- "vsplit_left" like :vsplit, but open to the left
        -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
        staged_diff_split_kind = "split",
        spell_check = true,
      },
      commit_select_view           = {
        kind = "split", -- "tab" works too.
      },
      commit_view                  = {
        -- kind = "split",  -- "tab" works too.
        kind = "vsplit",
        verify_commit = vim.fn.executable("gpg") == 1, -- Can be set to true or false, otherwise we try to find the binary
      },
      log_view                     = {
        kind = "split", -- "tab" works too.
      },
      rebase_editor                = {
        kind = "auto",
      },
      reflog_view                  = {
        kind = "split", -- "tab" works too.
      },
      merge_editor                 = {
        kind = "auto",
      },
      tag_editor                   = {
        kind = "auto",
      },
      preview_buffer               = {
        kind = "floating",
      },
      popup                        = {
        kind = "split",
      },
      signs                        = { -- { CLOSED, OPENED }
        hunk    = { "", "" },
        item    = { "", "" },
        section = { "", "" },
      },
      -- Each Integration is auto-detected through plugin presence, however, it can be disabled by setting to `false`
      integrations                 = {
        -- If enabled, use telescope for menu selection rather than vim.ui.select.
        -- Allows multi-select and some things that vim.ui.select doesn't.
        telescope = nil,
        -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `diffview`.
        -- The diffview integration enables the diff popup.
        --
        -- Requires you to have `sindrets/diffview.nvim` installed.
        diffview = nil,

        -- If enabled, uses fzf-lua for menu selection. If the telescope integration
        -- is also selected then telescope is used instead
        -- Requires you to have `ibhagwan/fzf-lua` installed.
        fzf_lua = nil,

        -- If enabled, uses mini.pick for menu selection. If the telescope integration
        -- is also selected then telescope is used instead
        -- Requires you to have `echasnovski/mini.pick` installed.
        mini_pick = nil,
      },
      sections                     = {
        -- Reverting/Cherry Picking
        sequencer = {
          folded = false,
          hidden = false,
        },
        untracked = {
          folded = false,
          hidden = false,
        },
        unstaged = {
          folded = false,
          hidden = false,
        },
        staged = {
          folded = false,
          hidden = false,
        },
        stashes = {
          folded = true,
          hidden = false,
        },
        unpulled_upstream = {
          folded = true,
          hidden = false,
        },
        unmerged_upstream = {
          folded = false,
          hidden = false,
        },
        unpulled_pushRemote = {
          folded = true,
          hidden = false,
        },
        unmerged_pushRemote = {
          folded = false,
          hidden = false,
        },
        recent = {
          folded = true,
          hidden = false,
        },
        rebase = {
          folded = true,
          hidden = false,
        },
      },
      mappings                     = {
        commit_editor = {
          ["q"] = "Close",
          ["<c-c><c-c>"] = "Submit",
          ["<c-c><c-k>"] = "Abort",
        },
        commit_editor_I = {
          ["<c-c><c-c>"] = "Submit",
          ["<c-c><c-k>"] = "Abort",
        },
        rebase_editor = {
          ["p"] = "Pick",
          ["r"] = "Reword",
          ["e"] = "Edit",
          ["s"] = "Squash",
          ["f"] = "Fixup",
          ["x"] = "Execute",
          ["d"] = "Drop",
          ["b"] = "Break",
          ["q"] = "Close",
          ["<cr>"] = "OpenCommit",
          ["gk"] = "MoveUp",
          ["gj"] = "MoveDown",
          ["<c-c><c-c>"] = "Submit",
          ["<c-c><c-k>"] = "Abort",
          ["[c"] = "OpenOrScrollUp",
          ["]c"] = "OpenOrScrollDown",
        },
        rebase_editor_I = {
          ["<c-c><c-c>"] = "Submit",
          ["<c-c><c-k>"] = "Abort",
        },
        finder = {
          ["<cr>"] = "Select",
          ["<c-c>"] = "Close",
          ["<esc>"] = "Close",
          -- ["<c-n>"] = "Next",
          -- ["<c-n>"] = false,
          -- ["<c-p>"] = false,
          -- ["<c-p>"] = "Previous",
          ["<down>"] = "Next",
          ["<up>"] = "Previous",
          ["<tab>"] = "MultiselectToggleNext",
          ["<s-tab>"] = "MultiselectTogglePrevious",
          ["<c-j>"] = "NOP",
        },
        -- Setting any of these to `false` will disable the mapping.
        popup = {
          ["?"] = "HelpPopup",
          ["A"] = "CherryPickPopup",
          ["D"] = "DiffPopup",
          ["M"] = "RemotePopup",
          ["P"] = "PushPopup",
          ["X"] = "ResetPopup",
          ["Z"] = "StashPopup",
          ["b"] = "BranchPopup",
          ["B"] = "BisectPopup",
          ["c"] = "CommitPopup",
          ["f"] = "FetchPopup",
          ["l"] = "LogPopup",
          ["m"] = "MergePopup",
          ["p"] = "PullPopup",
          ["r"] = "RebasePopup",
          ["v"] = "RevertPopup",
          ["w"] = "WorktreePopup",
        },
        status = {
          ["k"] = "MoveUp",
          ["j"] = "MoveDown",
          ["q"] = "Close",
          ["o"] = "OpenTree",
          ["I"] = "InitRepo",
          ["1"] = "Depth1",
          ["2"] = "Depth2",
          ["3"] = "Depth3",
          ["4"] = "Depth4",
          ["<tab>"] = "Toggle",
          ["x"] = "Discard",
          ["s"] = "Stage",
          ["S"] = "StageUnstaged",
          ["<c-s>"] = "StageAll",
          ["K"] = "Untrack",
          ["u"] = "Unstage",
          ["U"] = "UnstageStaged",
          ["$"] = "CommandHistory",
          ["Y"] = "YankSelected",
          ["<c-r>"] = "RefreshBuffer",
          ["<cr>"] = "GoToFile",
          ["<s-cr>"] = "PeekFile",
          ["<c-v>"] = "VSplitOpen",
          ["<c-x>"] = "SplitOpen",
          ["<c-t>"] = "TabOpen",
          ["{"] = "GoToPreviousHunkHeader",
          ["}"] = "GoToNextHunkHeader",
          ["[c"] = "OpenOrScrollUp",
          ["]c"] = "OpenOrScrollDown",
          ["<c-k>"] = "PeekUp",
          ["<c-j>"] = "PeekDown",
        },
      },
    }


    ---------------------------------------------------------------------------
    --- Key Mappings

    vim.keymap.set("n", "<leader>gs", ":Neogit<CR>", { noremap = true, silent = true, nowait = true })                 -- Open Git status buffer.
    vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { noremap = true, silent = true, nowait = true })          -- Open Git commit buffer.
    vim.keymap.set("n", "<leader>gP", ":Neogit pull<CR>", { noremap = true, silent = true, nowait = true })            -- Open Git pull buffer.
    vim.keymap.set("n", "<leader>gp", ":Neogit push<CR>", { noremap = true, silent = true, nowait = true })            -- Open Git push buffer.
    vim.keymap.set("n", "<leader>gB", ":Telescope git_branches<CR>", { noremap = true, silent = true, nowait = true }) -- Open branches view in Telescope.
  end,
}
