return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
    "JoosepAlviste/nvim-ts-context-commentstring",
      opts = {
        custom_calculation = function(_, language_tree)
          if vim.bo.filetype == "blade" and language_tree._lang ~= "javascript" and language_tree._lang ~= "php" then
            return "{{-- %s --}}"
          end
        end,
      },
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      modules = {},
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    --           config = function(_, opts)
    -- ---@class ParserInfo[]
    -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    -- parser_config.blade = {
    --   install_info = {
    --     url = "https://github.com/EmranMR/tree-sitter-blade",
    --     files = {
    --       "src/parser.c",
    --     },
    --     branch = "main",
    --     generate_requires_npm = true,
    --     requires_generate_from_grammar = true,
    --   },
    --   filetype = "blade",
    -- }

    -- require("nvim-treesitter.configs").setup(opts)








    })
  end,
}
