-- ~/.config/nvim/lua/user/core/options.lua



------------------------------------------------------------------------------
-- Default Neovim Settings
------------------------------------------------------------------------------

-- Show line numbers:
vim.opt.number = true
-- Show relative line numbers:
vim.opt.relativenumber = false
-- Spaces for indentation:
vim.opt.tabstop = 4
--vim.opt.softtabstop = 4
-- Max spaces for for level of indentation:
vim.opt.shiftwidth = 4
-- Convert tabs to spaces:
vim.opt.expandtab = true
-- Activate auto indentation:
vim.opt.autoindent = true
-- Enable soft wrapping:
vim.opt.wrap = false
-- Ignore case in search patterns:
vim.opt.ignorecase = true
-- Is mixed case included in search, assume case-sensitivity:
vim.opt.smartcase = true
-- Highlight the current line:
vim.opt.cursorline = true
-- Expand the number of usable colors:
vim.opt.termguicolors = true
-- Apply the color set to dark screens:
vim.opt.background = 'dark'
-- Always show the sign column, otherwise it would shift the text each time:
vim.opt.signcolumn = 'yes'
-- Allow backspace on indent, end of line or insert mode start position:
vim.opt.backspace = 'indent,eol,start'
-- Use clipboard of OS:
vim.opt.clipboard = 'unnamedplus'
-- Open new horizontal split always below the current:
vim.opt.splitbelow = true
-- Open new vertical split always below the current:
vim.opt.splitright = true
-- Consider string-string as whole word:
vim.opt.iskeyword:append('-')
-- Don't show Vim modes:
vim.opt.showmode = false
-- Keep indentation in new line:
vim.opt.smartindent = true
-- Disable hard wrapping:
vim.opt.textwidth = 0
-- Show title of file in window:
vim.opt.title = true
-- Show invisible characters like spaces/tabs:
vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·' }
-- Start scrolling by number of visible lines:
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3
-- Ask for confirmation instead of error out if file gets closed:
vim.opt.confirm = true
-- Disable overwriting from Vi to Vim (needed by vim-polyglot plugin):
vim.o.compatible = false
-- Keep backups out of the current directory and save in ~:
vim.opt.backupdir:remove('.')
-- Encoding written to a file:
vim.opt.fileencoding = 'utf-8'
-- Show visual guide line:
vim.opt.colorcolumn = '80'
-- Turn off all error bells:
vim.opt.errorbells = false
-- Set width of number column:
vim.opt.numberwidth = 5
-- Don't select any item in auto complete automatically:
--[[ vim.opt.completeopt = { 'menu,menuone','noselect' }, ]]
-- Select first item in auto completion list:
vim.opt.completeopt = { 'menu,menuone' }
-- Don't insert current comment leader in new line:
vim.opt.formatoptions:remove({ 'r', 'o', 'n', 'l' })


-- complete the longest common match, and allow tabbing the results to fully complete them:
--vim.opt.wildmode = 'longest:full,full'


-- Allow using the mouse:
--[[ vim.opt.mouse = 'a' ]]

-- Enable spell checking:
--[[ vim.opt.spell = true ]]




-- Enable persistent undo:
--[[ vim.opt.undofile = true ]]

-- Number of safed undo steps:
--[[ vim.opt.undolevels = 1000 ]]

-- Reload undo history if a file gets opened:
--[[ vim.opt.undoreload = 1000 ]]

-- Create backup files:
--[[ vim.opt.backup = true ]]


-- Remove the ~ from end of buffer:
--[[ vim.opt.fillchars:append({ eob = ' ' }) ]]




-- Improve start up time of Lua modules:
--[[ vim.loader.enable() ]]

-- Command line height:
--[[ vim.opt.cmdheight = 1 ]]



-- Time in milliseconds to accept commands (default: 1000):
--[[ vim.opt.timeoutlen = 500 ]]

-- Faster code completion (4000ms default):
--[[ vim.opt.updatetime = 250 ]]




--[[ local options = { ]]

    -- Make `` visible in Markdown files:
    --[[ conceallevel = 0, ]]


    -- Highlight all matches on previous search pattern:
    --[[ hlsearch = true, ]]

    -- Pop up menu height:
    --[[ pumheight = 10, ]]

    -- Disable tab bar:
    --[[ showtabline = 1, ]]

    -- Don't create swapfiles:
    --[[ swapfile = false, ]]

    -- If a file is being edited by another program, it is not allowed to be edited:
    --[[ writebackup = false, ]]

    -- Don't break line in a word ('list' setting must be disabled):
    --[[ linebreak = true, ]]

    -- Show replacements in split, before applying to file:
    --[[ inccommand = "split", ]]

    -- Don't hide unused buffers:
    --[[ hidden = false, ]]

    -- Auto write buffer if focus changes:
    --[[ autowrite = true, ]]

    -- Auto write all buffers if focus changes:
    --[[ autowriteall = true, ]]



    -- Don't show auto complete messages in command line:
    --shortmess:append "c",


    -- Don't display mode in statusbar:
--[[ } ]]

-- Iterate trough options object and shift vim.opt to every command:
--[[ for k, v in pairs(options) do ]]
--[[   vim.opt[k] = v ]]
--[[ end ]]

-- Allow wrapping on this signs too:
--[[ vim.cmd "set whichwrap+=<,>,[,],h,l" ]]

-- Consider - as part of a keyword like in HTML/CSS:
-- vim.cmd [[set iskeyword+=-]]



