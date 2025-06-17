-------------------------------------------------------------------------------
-- Git init.lua
-- Centralized Git plugins orchestration file.
-------------------------------------------------------------------------------

return {
  -- Core git functionality
  { import = "plugins.git.gitsigns" },
  { import = "plugins.git.neogit" },
  { import = "plugins.git.diffview" },
  { import = "plugins.git.fugitive" },
  { import = "plugins.git.worktree" },

  -- Optional: GitHub integration
  -- { import = "plugins.git.octo" },
  -- { import = "plugins.git.git-conflict" },
}

-- lua/plugins/git/core.lua
-- Shared git configuration and key mappings

local M = {}

-- Unified git key mapping namespace
M.setup_git_keymaps = function()
  local opts = { noremap = true, silent = true }

  -- Git Status & Navigation
  vim.keymap.set("n", "<leader>gg", ":Neogit<CR>", opts)                    -- Main git interface
  vim.keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", opts)      -- Stage hunk
  vim.keymap.set("v", "<leader>gs", ":Gitsigns stage_hunk<CR>", opts)      -- Stage selection
  vim.keymap.set("n", "<leader>gu", ":Gitsigns undo_stage_hunk<CR>", opts) -- Unstage hunk
  vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", opts)      -- Reset hunk
  vim.keymap.set("v", "<leader>gr", ":Gitsigns reset_hunk<CR>", opts)      -- Reset selection

  -- Git Diff & Preview
  vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", opts)             -- Diffview
  vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", opts)    -- Preview hunk
  vim.keymap.set("n", "<leader>gH", ":DiffviewFileHistory %<CR>", opts)    -- File history

  -- Git Blame & Log
  vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", opts) -- Toggle blame
  vim.keymap.set("n", "<leader>gB", ":Git blame<CR>", opts)                -- Full blame view
  vim.keymap.set("n", "<leader>gl", ":Neogit log<CR>", opts)               -- Git log

  -- Git Commit & Push
  vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", opts)            -- Commit
  vim.keymap.set("n", "<leader>gp", ":Neogit push<CR>", opts)              -- Push
  vim.keymap.set("n", "<leader>gP", ":Neogit pull<CR>", opts)              -- Pull

  -- Git Branches & Worktree
  vim.keymap.set("n", "<leader>gw", ":Telescope git_worktree<CR>", opts)   -- Worktree picker
  vim.keymap.set("n", "<leader>gW", ":Telescope git_worktree create<CR>", opts) -- Create worktree
  vim.keymap.set("n", "<leader>gco", ":Telescope git_branches<CR>", opts)  -- Checkout branch

  -- Git Navigation
  vim.keymap.set("n", "]h", ":Gitsigns next_hunk<CR>", opts)               -- Next hunk
  vim.keymap.set("n", "[h", ":Gitsigns prev_hunk<CR>", opts)               -- Previous hunk
end

-- Plugin integration helpers
M.close_fugitive_on_neogit = function()
  -- Auto-close fugitive when opening neogit to avoid conflicts
  vim.api.nvim_create_autocmd("User", {
    pattern = "NeogitStatusRefresh",
    callback = function()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].filetype == "fugitive" then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end
    end,
  })
end

return M
