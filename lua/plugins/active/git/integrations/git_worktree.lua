-------------------------------------------------------------------------------
-- Git-Worktree Plugin
-- https://github.com/ThePrimeagen/git-worktree.nvim
-- Git worktree management to create, switch, and delete worktrees.
-------------------------------------------------------------------------------

return {
  "ThePrimeagen/git-worktree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- Required plugin for Git-Worktree.
    "nvim-telescope/telescope.nvim", -- Optional plugin for Git-Worktree.
  },
  cmd = { "GitWorktreeList", "GitWorktreeCreate", "GitWorktreeDelete" },

  -- Plugin Setup Function:
  config = function()
    local git_worktree = require("git-worktree") -- Import Git-Worktree plugin, save it to a variable.
    local telescope    = require("telescope")     -- Import Telescope plugin, save it to a variable.

    -- Plugin Configuration:
    git_worktree.setup({
    })

    telescope.load_extension("git_worktree") -- Load Git-Worktree extension for Telescope to manage Git-Worktree UI.


    ---------------------------------------------------------------------------
    -- Key Mappings

    -- Keybindings you should know:
    -- <Enter> - Switches to the selected worktree.
    -- <C-d>   - Deletes the selected worktree.
    -- <c-f>   - toggles forcing on the next deletion.

    -- Create new worktree
    vim.keymap.set("n", "<leader>wl", function()
    require("telescope").extensions.git_worktree.git_worktrees()
    end, { desc = "list Git Worktree" })

    -- Switch/list worktrees
    vim.keymap.set("n", "<leader>wc", function()
    require("telescope").extensions.git_worktree.create_git_worktree()
    end, { desc = "Create Git Worktree Branches" })


  end,
}
