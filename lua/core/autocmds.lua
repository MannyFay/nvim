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

