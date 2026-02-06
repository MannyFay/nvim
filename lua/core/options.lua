-------------------------------------------------------------------------------
----- Default Neovim Settings
-------------------------------------------------------------------------------

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.number         = true -- Show line numbers.
vim.opt.relativenumber = true -- Show relative line numbers.
vim.opt.tabstop        = 4 -- Spaces for indentation.
--vim.opt.softtabstop         = 4
vim.opt.shiftwidth     = 4 -- Max spaces for for level of indentation.
vim.opt.expandtab      = true -- Convert tabs to spaces.
vim.opt.autoindent     = true -- Activate auto indentation.
vim.opt.wrap           = false -- Enable soft wrapping.
vim.opt.ignorecase     = true -- Ignore case in search patterns.
vim.opt.smartcase      = true -- Is mixed case included in search, assume case-sensitivity.
vim.opt.cursorline     = true -- Highlight the current line.
vim.opt.termguicolors  = true -- Expand the number of usable colors.
vim.opt.background     = 'dark' -- Apply the color set to dark screens.
vim.opt.signcolumn     = 'yes' -- Always show the sign column, otherwise it would shift the text each time.
vim.opt.backspace      = 'indent,eol,start' -- Allow backspace on indent, end of line or insert mode start position.
vim.opt.clipboard      = 'unnamedplus' -- Use clipboard of OS.

-- WSL2 clipboard integration via win32yank:
if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0,
  }
end
vim.opt.splitbelow     = true -- Open new horizontal split always below the current.
vim.opt.splitright     = true -- Open new vertical split always below the current.
vim.opt.iskeyword:append('-') -- Consider string-string as whole word.
vim.opt.showmode      = false -- Don't show Vim modes.
vim.opt.smartindent   = true -- Keep indentation in new line.
-- vim.opt.textwidth     = 0 -- Disable hard wrapping.
vim.opt.title         = true -- Show invisible characters like spaces/tabs.
vim.opt.list          = true -- Show invisible characters like spaces/tabs.
vim.opt.listchars     = { tab = '▸ ', trail = '·' } -- Character to show for tabs and trailing spaces.
vim.opt.scrolloff     = 3 -- Start vertical scrolling by number of visible lines.
vim.opt.sidescrolloff = 3 -- Start horizontal scrolling by number of visible lines.
vim.opt.confirm       = true -- Ask for confirmation instead of error out if file gets closed.
vim.o.compatible      = false -- Disable overwriting from Vi to Vim (needed by vim-polyglot plugin).
vim.opt.backupdir:remove('.') -- Keep backups out of the current directory and save in ~.
vim.opt.fileencoding = 'utf-8' -- Encoding written to a file.
-- vim.opt.colorcolumn  = '80' -- Show visual guide line.
vim.opt.errorbells   = false -- Turn off all error bells.
vim.opt.numberwidth  = 5 -- Set width of number column.
--vim.opt.completeopt = { 'menu,menuone','noselect' },       -- Don't select any item in auto complete automatically (set in nvim-cmp.lua too).
vim.opt.completeopt  = { 'menu,menuone' } -- Select first item in auto completion list.
-- Don't insert current comment leader in new line.
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.spell       = true -- Enable spell checking.
vim.opt.equalalways = true -- Enable/Disable automatic resizing of panes (does not work).
vim.cmd('set pumblend=0') -- Transparency of floating windows.
vim.loader.enable() -- Improve Neovim startup time.
vim.opt.mouse = 'a' -- Enable mouse support.
vim.o.undofile = true
-- nvim_list_uis()[0]
vim.opt.swapfile = false  -- Don't create swap files.
vim.opt.autoread = true   -- Automatically reload files changed outside of Neovim.

-- Auto-reload files when focus returns or buffer is entered:
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  command = "silent! checktime",
})
vim.g.editorconfig = true -- Enable Neovims editorconfig functionality.
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders

