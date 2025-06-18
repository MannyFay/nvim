-- lua/plugins/git/init.lua
-- Professional Git plugin orchestration with proper separation of concerns

local M = {}

-- Plugin specifications with proper dependencies and loading strategies
local plugins = {
  -- Core git functionality (load first)
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      return require("plugins.git.config.gitsigns")
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
      require("plugins.git.integrations.gitsigns").setup()
    end,
  },

  -- Advanced diff viewing (load early for neogit integration)
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" },
    cmd = {
      "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles",
      "DiffviewFocusFiles", "DiffviewRefresh", "DiffviewFileHistory"
    },
    opts = function()
      return require("plugins.git.config.diffview")
    end,
    config = function(_, opts)
      require("diffview").setup(opts)
      require("plugins.git.integrations.diffview").setup()
    end,
  },

  -- Main git interface (load after dependencies)
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit Status" },
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit Commit" },
      { "<leader>gp", "<cmd>Neogit push<cr>", desc = "Neogit Push" },
      { "<leader>gP", "<cmd>Neogit pull<cr>", desc = "Neogit Pull" },
    },
    opts = function()
      return require("plugins.git.config.neogit")
    end,
    config = function(_, opts)
      require("neogit").setup(opts)
      require("plugins.git.integrations.neogit").setup()
    end,
  },

  -- Advanced git operations (load on demand)
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" }, -- GitHub integration
    cmd = {
      "Git", "GBrowse", "Gwrite", "Gread", "Gdiffsplit",
      "Gvdiffsplit", "Gedit", "Gsplit", "Gvsplit", "Gtabedit"
    },
    keys = {
      { "<leader>gB", "<cmd>GBlameDetailed<cr>", desc = "Git Blame Detailed" },
      { "<leader>gC", "<cmd>GCompare<cr>", desc = "Git Compare" },
      { "<leader>gO", "<cmd>GBrowse<cr>", desc = "Git Browse", mode = { "n", "v" } },
    },
    config = function()
      require("plugins.git.integrations.fugitive").setup()
    end,
  },

  -- Worktree management (optional, load on demand)
  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gw", function() require("telescope").extensions.git_worktree.git_worktrees() end, desc = "Git Worktrees" },
      { "<leader>gW", function() require("telescope").extensions.git_worktree.create_git_worktree() end, desc = "Create Worktree" },
    },
    opts = function()
      return require("plugins.git.config.worktree")
    end,
    config = function(_, opts)
      require("git-worktree").setup(opts)
      require("telescope").load_extension("git_worktree")
      require("plugins.git.integrations.worktree").setup()
    end,
  },
}

-- Core orchestration plugin (handles keymaps and cross-plugin integration)
local orchestration = {
  "folke/which-key.nvim",
  optional = true,
  config = function()
    require("plugins.git.core.orchestrator").setup()
  end,
}

-- Health check and debugging utilities
local utilities = {
  "nvim-lua/plenary.nvim",
  config = function()
    require("plugins.git.core.health").setup()
    require("plugins.git.core.commands").setup()
  end,
}

-- Combine all plugin specifications
table.insert(plugins, orchestration)
table.insert(plugins, utilities)

return plugins
