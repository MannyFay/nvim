-- lua/plugins/git/core.lua
-- Git orchestration and unified keymaps (not a plugin, just configuration)

return {
  "folke/which-key.nvim", -- Use which-key as base for git keymap organization
  optional = true,
  config = function()
    -- Set up unified git keymaps
    local opts = { noremap = true, silent = true }

    -- === Core Git Interface ===
    vim.keymap.set("n", "<leader>gg", ":Neogit<CR>",
      vim.tbl_extend("force", opts, { desc = "Git status (Neogit)" }))

    -- === Staging & Hunks (Gitsigns focused) ===
    vim.keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk<CR>",
      vim.tbl_extend("force", opts, { desc = "Stage hunk" }))
    vim.keymap.set("v", "<leader>gs", ":Gitsigns stage_hunk<CR>",
      vim.tbl_extend("force", opts, { desc = "Stage selection" }))
    vim.keymap.set("n", "<leader>gu", ":Gitsigns undo_stage_hunk<CR>",
      vim.tbl_extend("force", opts, { desc = "Unstage hunk" }))
    vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>",
      vim.tbl_extend("force", opts, { desc = "Reset hunk" }))
    vim.keymap.set("v", "<leader>gr", ":Gitsigns reset_hunk<CR>",
      vim.tbl_extend("force", opts, { desc = "Reset selection" }))

    -- === Diff & Preview ===
    vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>",
      vim.tbl_extend("force", opts, { desc = "Open diffview" }))
    vim.keymap.set("n", "<leader>gD", ":DiffviewClose<CR>",
      vim.tbl_extend("force", opts, { desc = "Close diffview" }))
    vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>",
      vim.tbl_extend("force", opts, { desc = "Preview hunk" }))
    vim.keymap.set("n", "<leader>gH", ":DiffviewFileHistory %<CR>",
      vim.tbl_extend("force", opts, { desc = "File history" }))

    -- === Blame ===
    vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>",
      vim.tbl_extend("force", opts, { desc = "Toggle line blame" }))
    vim.keymap.set("n", "<leader>gB", ":GBlameDetailed<CR>",
      vim.tbl_extend("force", opts, { desc = "Detailed blame" }))

    -- === Commit & Push ===
    vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>",
      vim.tbl_extend("force", opts, { desc = "Commit" }))
    vim.keymap.set("n", "<leader>gp", ":Neogit push<CR>",
      vim.tbl_extend("force", opts, { desc = "Push" }))
    vim.keymap.set("n", "<leader>gP", ":Neogit pull<CR>",
      vim.tbl_extend("force", opts, { desc = "Pull" }))

    -- === Branches ===
    vim.keymap.set("n", "<leader>gco", ":Telescope git_branches<CR>",
      vim.tbl_extend("force", opts, { desc = "Checkout branch" }))
    vim.keymap.set("n", "<leader>gl", ":Neogit log<CR>",
      vim.tbl_extend("force", opts, { desc = "Git log" }))

    -- === Worktree ===
    vim.keymap.set("n", "<leader>gw", function()
      if pcall(require, "telescope") then
        require("telescope").extensions.git_worktree.git_worktrees()
      else
        print("Telescope not available")
      end
    end, vim.tbl_extend("force", opts, { desc = "List worktrees" }))

    vim.keymap.set("n", "<leader>gW", function()
      if pcall(require, "telescope") then
        require("telescope").extensions.git_worktree.create_git_worktree()
      else
        print("Telescope not available")
      end
    end, vim.tbl_extend("force", opts, { desc = "Create worktree" }))

    -- === Advanced Operations (Fugitive) ===
    vim.keymap.set("n", "<leader>gC", ":GCompare<CR>",
      vim.tbl_extend("force", opts, { desc = "Compare with HEAD" }))
    vim.keymap.set("n", "<leader>gE", ":Gedit<CR>",
      vim.tbl_extend("force", opts, { desc = "Edit git object" }))
    vim.keymap.set("n", "<leader>gO", ":GBrowse<CR>",
      vim.tbl_extend("force", opts, { desc = "Browse on GitHub" }))
    vim.keymap.set("v", "<leader>gO", ":GBrowse<CR>",
      vim.tbl_extend("force", opts, { desc = "Browse selection" }))

    -- === Navigation ===
    vim.keymap.set("n", "]h", ":Gitsigns next_hunk<CR>",
      vim.tbl_extend("force", opts, { desc = "Next hunk" }))
    vim.keymap.set("n", "[h", ":Gitsigns prev_hunk<CR>",
      vim.tbl_extend("force", opts, { desc = "Previous hunk" }))

    -- === Text Objects ===
    vim.keymap.set({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', opts)

    -- Setup which-key groups if available
    if pcall(require, "which-key") then
      require("which-key").register({
        ["<leader>g"] = { name = " Git" },
        ["<leader>gw"] = { name = " Worktree" },
      })
    end

    -- Utility commands
    vim.api.nvim_create_user_command("GitKeymaps", function()
      print("Git Unified Keymaps:")
      print("  <leader>gg  - Git status (Neogit)")
      print("  <leader>gs  - Stage hunk")
      print("  <leader>gu  - Unstage hunk")
      print("  <leader>gr  - Reset hunk")
      print("  <leader>gd  - Open diffview")
      print("  <leader>gh  - Preview hunk")
      print("  <leader>gb  - Toggle blame")
      print("  <leader>gc  - Commit")
      print("  <leader>gp  - Push")
      print("  <leader>gP  - Pull")
      print("  <leader>gw  - Worktree list")
      print("  ]h/[h       - Next/prev hunk")
    end, { desc = "Show git keymaps" })
  end,
}
