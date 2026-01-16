-------------------------------------------------------------------------------
-- Auto Commands Configuration
-- Custom auto commands for improved development experience.
-- Auto commands are automatically loaded on the VeryLazy event.
-------------------------------------------------------------------------------



-------------------------------------------------------------------------------
-- Laravel Blade LSP Workaround
-- Problem: LSP servers don't recognize .blade.php files properly
-- Solution: Temporarily set file type to 'php' for LSP, then back to 'blade'

local blade_group = vim.api.nvim_create_augroup("LaravelBladeWorkaround", { clear = true })

-- Step 1: Initially treat .blade.php files as PHP for LSP attachment:
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = blade_group,
  pattern = "*.blade.php",
  desc = "Set blade files to PHP filetype for LSP attachment",
  callback = function()
    vim.bo.filetype = "php"
  end,
})

-- Step 2: After LSP attaches, switch back to blade file type for proper syntax highlighting:
vim.api.nvim_create_autocmd("LspAttach", {
  group = blade_group,
  pattern = "*.blade.php",
  desc = "Switch back to blade filetype after LSP attachment",
  callback = function(args)
    vim.schedule(function()
      -- Check if Intelephense (PHP LSP) has attached to this buffer:
      for _, client in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
        if client.name == "intelephense" then
          -- Switch back to blade for proper syntax highlighting:
          vim.bo[args.buf].filetype = "blade"
          vim.bo[args.buf].syntax   = "blade"
          break
        end
      end
    end)
  end,
})


-------------------------------------------------------------------------------
-- Color Column for specific file types
-- Shows vertical lines at 80 and 120 characters for Lua and PHP files

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "php" },
  desc = "Set color columns at 80 and 120 characters for Lua and PHP files",
  callback = function()
    vim.opt_local.colorcolumn = "80,120"
    vim.opt_local.textwidth = 120  -- Auto line wrap at 120 characters
    vim.opt_local.formatoptions:append("t")  -- Auto-wrap text using textwidth
  end,
})

-- 100 characters:
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "blade.php", "html", "typescriptreact", "javascriptreact", "twig" },
  desc = "Set color column at 100 characters for TypeScript and React files",
  callback = function()
    vim.opt_local.colorcolumn = "100"
    vim.opt_local.textwidth = 100  -- Auto line wrap at 100 characters
    vim.opt_local.formatoptions:append("t")  -- Auto-wrap text using textwidth
  end,
})

-- 80 characters:
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "css", "sh", "bash", "zsh", "javascript", "typescript", "editorconfig" },
  desc = "Set color column at 80 characters.",
  callback = function()
    vim.opt_local.colorcolumn = "80"
    vim.opt_local.textwidth = 80  -- Auto line wrap at 80 characters
    vim.opt_local.formatoptions:append("t")  -- Auto-wrap text using textwidth
  end,
})


-------------------------------------------------------------------------------
-- Markdown: Soft-wrap only (no hard line breaks)
-- Long lines in file, but displayed nicely in both Neovim and Obsidian

local markdown_group = vim.api.nvim_create_augroup("MarkdownSettings", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
  group = markdown_group,
  pattern = "*.md",
  desc = "Markdown soft-wrap settings",
  callback = function()
    vim.schedule(function()
      local buf = vim.api.nvim_get_current_buf()
      local ft = vim.bo[buf].filetype
      if ft ~= "markdown" then return end

      -- No hard-wrap
      vim.bo[buf].textwidth = 0

      -- No visual guide for markdown
      vim.wo.colorcolumn = ""

      -- Soft-wrap: visual wrapping without inserting newlines
      vim.wo.wrap = true
      vim.wo.linebreak = true  -- Wrap at word boundaries
      vim.wo.breakindent = true  -- Preserve indentation on wrapped lines
      vim.wo.breakindentopt = "shift:2"  -- Indent for wrapped lines
      vim.bo[buf].formatlistpat = [[^\s*[-*+]\s\[[ xX]\]\s\|^\s*[-*+]\s\|^\s*\d\+[.)]\s\+]]  -- List pattern
    end)
  end,
})


-------------------------------------------------------------------------------
-- JSONC (JSON with Comments) File Type Detection
-- Many config files use JSON with comments (VS Code, Zed, TypeScript, etc.)
-- This ensures proper syntax highlighting and LSP support without errors.

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*/.vscode/*.json",
    "*/.vscode/**/*.json",
    "*/zed/*.json",
    "*/zed/**/*.json",
    "tsconfig.json",
    "tsconfig.*.json",
    "jsconfig.json",
    "jsconfig.*.json",
    ".babelrc",
    ".eslintrc",
    ".eslintrc.json",
    ".prettierrc",
    ".prettierrc.json",
    "launch.json",
    "tasks.json",
    "devcontainer.json",
    "*/devcontainer.json",
    ".swcrc",
  },
  desc = "Set filetype to jsonc for config files that support comments",
  callback = function()
    vim.bo.filetype = "jsonc"
  end,
})

