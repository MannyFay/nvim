-------------------------------------------------------------------------------
-- Key Mappings
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Modes

--   normal_mode       = 'n'
--   insert_mode       = 'i',
--   visual_mode       = 'v',
--   visual_block_mode = 'x',
--   term_mode         = 't',
--   command_mode      = 'c',


-------------------------------------------------------------------------------
-- Variables

local opts   = { noremap = true, silent = true } -- Don't show command message in command line.
local keymap = vim.api.nvim_set_keymap



-------------------------------------------------------------------------------
-- Default Key Mappings
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Leader

vim.g.mapleader      = ' ' -- Set <Leader> to space globally (standard is \).
vim.g.maplocalleader =
' '                        -- Set <Leader> to space per buffer (standard is \).


-------------------------------------------------------------------------------
-- Searching

vim.keymap.set('n', '<leader>qh', ':nohlsearch<CR>', opts) -- Quit highlighting of search.
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>', opts)      -- Quit highlighting of search.
vim.keymap.set('n', 'n', 'nzzzv', opts)                    -- Center the screen after jumping to the next match.
vim.keymap.set('n', 'N', 'Nzzzv', opts)                    -- Center the screen after jumping to the previous match.


-------------------------------------------------------------------------------
-- Editing

local map = vim.keymap.set

map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true }) -- When text is wrapped, move by terminal rows, not lines up, unless a count is provided.
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true }) -- When text is wrapped, move by terminal rows, not lines down, unless a count is provided.

map('n', 'U', '<C-r>', opts)                                -- Redo last action.
map({ 'n', }, '<', '<<', opts)                        -- Use only < for indent width <<.
map({ 'n', }, '>', '>>', opts)                        -- Use only > for indent width >>.
map({ 'v', 'x' }, '<', '<gv', opts)                        -- Stay in visual mode after indent width <<.
map({ 'v', 'x' }, '>', '>gv', opts)                        -- Stay in visual mode after indent width >>.
map('n', '<Leader><Leader>==', 'ggvvG=', opts)              -- Auto indent the whole file.
map('n', '~', 'g~l', opts)                                  -- Don't change the cursor position after case change.
map('n', '+', '<C-a>', opts)                                          -- Increment number under cursor.
map('n', '-', '<C-x>', opts)                                          -- Decrement number under cursor.



map('n', 'dw', 'vb"_d', opts)                                         -- Delete word backwards it.
map('n', '<C-a>', 'gg<S-v>G', opts)                                   -- Select all text.



vim.keymap.set('n', 'q:', ':q<CR>') -- Disable typical command line typo.


vim.keymap.set('v', 'y', 'myy`y') -- Maintain the cursor position when yanking a visual selection.
vim.keymap.set('v', 'Y', 'myY`y') -- Maintain the cursor position when yanking a visual line selection.

vim.keymap.set('v', 'p', '"_dP')  -- Paste/replace without losing text.
vim.keymap.set('n', 'Y', 'y$')    -- Yank to end of line.

vim.keymap.set('n', 'x', '"_x')   -- If delete one char, don't copy it to the clipboard.

-- Commented out because ; is used for repeat command:
-- vim.keymap.set('n', ';;', '<Esc>A;<Esc>')                               -- Insert a ; at the end of a line.
vim.keymap.set('n', ',,', '<Esc>A,<Esc>') -- Insert a , at the end of a line.
-- vim.keymap.set('n', '::', '<Esc>A:<Esc>')                               -- Insert a : at the end of a line.  -- This slows down the regular : command.

vim.keymap.set('x', '<Tab>', ":move '>+1<CR>gv-gv")   -- Move text down in visual block mode.
vim.keymap.set('x', '<S-Tab>', ":move '<-2<CR>gv-gv") -- Move text up in visual block mode.
vim.keymap.set('v', '<Tab>', ":move '>+1<CR>gv=gv")   -- Move text down in visual mode.
vim.keymap.set('v', '<S-Tab>', ":move '<-2<CR>gv=gv") -- Move text up in visual mode.

vim.keymap.set('n', 'vv', 'V', opts)                  -- Enter visual line mode like all other line commands.
vim.keymap.set('n', 'vb', '<C-v>', opts)              -- Enter visual block mode (vb).

vim.keymap.set('n', '<Leader>jl', 'J', opts)          -- Join line below with white space:

--vim.keymap.set('n', '<Leader>/', 'gcc')

-- to run a script directly from vim:
-- nnoremap <leader>x :!chmod +x %<CR>


-- Toggle inlay hints ( tih):
-- if vim.lsp.inlay_hint then
--   vim.keymap.set(
--     'n',
--     '<Leader>tih',
--     function() vim.lsp.inlay_hint(0, nil) end,
--     { desc = "Toggle inlay hints." }
--   )
-- end

-- if vim.lsp.inlay_hint then
--     vim.keymap.set('n', '<Leader>tih', function() vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0)) end, { desc = "toggle inlay [h]ints" })
-- end

-- vim.keymap.set('n', '<Leader>tih', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)



-- Maybe here works something:
-- vim.keymap.set('n', '<Leader>tih', function() lsp.inlay_hint.enable(0, not lsp.inlay_hint.is_enabled()) end)


-- Start tmux sessionizer:
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww ~/personal/github/dotfiles/cli-tools/tmux/scripts/tmux_sessionizer.sh<CR>')

------------------------------------------------------------
-- Scrolling

-- vim.keymap.set('n', 'T',       'zt',    opts)  -- Scroll actual line to top.
-- vim.keymap.set('n', 'B',       'zb',      opts)  -- Scroll actual line to bottom.
-- vim.keymap.set('n', 'C',       'zz',      opts)  -- Scroll actual line to center.

vim.keymap.set('n', '<C-k>', '<C-u>', opts)   -- Scroll up.
vim.keymap.set('n', '<C-j>', '<C-e>', opts)   -- Scroll down.
vim.keymap.set('n', '<C-p-u>', '<C-b>', opts) -- Scroll page up.
vim.keymap.set('n', '<C-p-d>', '<C-f>', opts) -- Scroll page down.
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts) -- Scroll half page up and center.
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts) -- Scroll half page down and center.


--------------------------------------------------------------
-- Splitting

keymap('n', '<Leader>\\|', ':vsplit<CR>', opts) -- Split buffer vertically (y-axis).
keymap('n', '<Leader>-', ':split<CR>', opts)    -- Split buffer horizontally (x-axis).


--------------------------------------------------------------
-- Navigation

keymap('n', 'L', '<C-w>l', opts) -- Go to right split (L).
keymap('n', 'H', '<C-w>h', opts) -- Go to left split (H).
keymap('n', 'J', '<C-w>j', opts) -- Go to split below (J).
keymap('n', 'K', '<C-w>k', opts) -- Go to split above (K).


--------------------------------------------------------------
-- Resizing

keymap('n', '<Leader>=', '<C-w>=', opts)                    -- Equalize width and height for all splits ( es).
keymap('n', '<Leader>m', '<C-w>|', opts)                    -- Maximize buffer horizontally ( m).
keymap('n', '<Leader>gv', ':vertical resize +20<CR>', opts) -- Grow split vertical ( gv).
keymap('n', '<Leader>sv', ':vertical resize -20<CR>', opts) -- Shrink split vertical ( sv).
keymap('n', '<Leader>gh', ':resize +20<CR>', opts)          -- Grow split horizontally ( gh).
keymap('n', '<Leader>sh', ':resize -20<CR>', opts)          -- Shrink split horizontally ( sh).


--------------------------------------------------------------
-- Terminal

keymap('n', '<Leader>th', ':split term://zsh<CR>i', opts)  -- Open terminal in horizontal buffer below ( tb).
keymap('n', '<Leader>tv', ':vsplit term://zsh<CR>i', opts) -- Open terminal in vertical buffer to the next ( tn).
keymap('n', '<Leader>nt', ':tabnew<CR>', opts)             -- Open new tab ( ot).
keymap('n', '<Leader>qt', ':tabclose<CR>', opts)           -- Exit current tab: ( et).
keymap('n', '<Leader>tr', ':tabn<CR>', opts)               -- Go to next tab ( nt).
keymap('n', '<Leader>tl', ':tabp<CR>', opts)               -- Go to previous tab ( pt).



-------------------------------------------------------------------------------
-- Plugin Key Mappings
-------------------------------------------------------------------------------

-- This is only a reference.
-- The key mappings are defined in the plugin file itself.



------------------------------------------------------------
-- Auto Save Plugin

-- No key mappings defined.



------------------------------------------------------------
-- Auto Pairs Plugin

-- No key mappings defined.



------------------------------------------------------------
-- Comment Plugin

-- Mappings (normal mode):
-- Line-comment:                   <Leader>/
-- Block-comment:                  <Nop>

-- Operator-pending mappings (normal and visual mode):
-- Line-comment:                   <Leader>/
-- Block-comment:                  <Nop>

-- Extra mappings:
-- Add comment on the line above:  <Nop>
-- Add comment on the line below:  <Nop>
-- Add comment at the end of line: <Nop>



------------------------------------------------------------
-- Git Signs Plugin

-- No key mappings defined.



------------------------------------------------------------
-- Guess Indent Plugin

-- No key mappings defined.



------------------------------------------------------------
-- Colorscheme Development

-- Reload mannydark colorscheme (clear cache and re-apply):
vim.keymap.set('n', '<Leader>cr', function()
  for name, _ in pairs(package.loaded) do
    if name:match('^mannydark') then
      package.loaded[name] = nil
    end
  end
  vim.cmd.colorscheme('mannydark')
  vim.notify('Colorscheme reloaded!', vim.log.levels.INFO)
end, { desc = 'Reload mannydark colorscheme' })


------------------------------------------------------------
-- Hop Plugin

-- Hop to character in (multiple) buffer:          <Leader>c
-- Hop to word in (multiple) buffer:               <Leader>w
-- Hop to pattern in (multiple) buffer:            <Leader>p
-- Hop to start of line (multiple) buffer:         <Leader>l



------------------------------------------------------------
-- Indent Blank Line Plugin

-- No key mappings defined.



------------------------------------------------------------
-- Lion plugin

-- Align on the left of the alignment character:  <Leader>al
-- Align on the right of the alignment character: <Leader>ar



------------------------------------------------------------
-- LSP Config plugin


------------------------------------------------------------
-- LSP Saga plugin

-- Scroll up:                              <C-k>
-- Scroll down:                            <C-j>
-- Open pop up window with definition:     <Leader>gd


------------------------------------------------------------
-- LuaLine Plugin


------------------------------------------------------------
-- Null LS Plugin

-- No key mappings defined.


------------------------------------------------------------
-- Nvim CMP Plugin

-- Confirm auto complete selection: <C-Leader>
-- Previous list item:              <S-Tab>
-- Next list item:                  <Tab>
-- Quit suggestion popup:           <C-q>
-- Scroll down in docs:             <C-j>
-- Scroll up in docs:               <C-k>
-- Show completion suggestions:     <C-c>


------------------------------------------------------------
-- Nvim Colorizer Plugin

-- No plugins defined.


------------------------------------------------------------
-- Nvim Genghis Plugin

-- Possible, but not configured.


------------------------------------------------------------
-- Nvim Lastplace Plugin

-- No key mappings defined.


------------------------------------------------------------
-- Nvim Surround Plugin

-- Change surrounding:              cs<old-sign><new-sign>
-- Delete surrounding:              ds<closing-sign>
-- Surround with ():                ((
-- Surround with {}:                {{
-- Surround with []:                [[
-- Surround with "":                ""
-- Surround with '':                ''
-- Surround with ``:                ``
-- Surround with <>:                <>
-- Surround with HTML tag:          swt
-- Delete surrounding HTML tag:     dst
-- Change surrounding tag:          cst


------------------------------------------------------------
-- Nvim Tree Plugin

-- Toggle tree:                   <Leader>tt
-- Explore tree:                  <Leader>et
-- Show file in tree:             <Leader>sft
-- Close node:                    qn
-- Rename:                        r
-- File information:              i
-- Open:                          enter
-- Open in vertical split:        v
-- Open in horizontal split:      h
-- Yank name of file:             y
-- Yank relative path:            Y
-- Copy:                          c
-- Cut:                           x
-- Paste:                         p
-- Jump to parent node:           P
-- New item:                      ni
-- Delete:                        d
-- Move to bin:                   B
-- Collapse all:                  C
-- Expand all:                    E
-- Top sibling:                   TS
-- Bottom sibling:                BS
-- Previous sibling:              K
-- Next sibling:                  J


------------------------------------------------------------
-- Peek Plugin

-- Open Markdown preview:           <Leader>mdo
-- Quit Markdown preview:           <Leader>mdq


------------------------------------------------------------
-- PlantUML Previewer Plugin

-- Open PlantUML in browser:    <Leader>umlo
-- Save PlantUML as .png:       <Leader>umls


------------------------------------------------------------
-- Project Plugin


------------------------------------------------------------
-- SplitJoin Plugin - ACTUALLY NOT IN USE

-- Join object under cursor:        <Leader>jo
-- Split object under cursor:       <Leader>so


------------------------------------------------------------
-- Telescope Plugin

-- Find file:                         <Leader>ff
-- Find text:                         <Leader>ft
-- Recent files:                      <Leader>fr
-- Exit Telescope:                    <C-q>
-- Open file:                         <CR>
-- Open file in horizontal split:     h
-- Open file in vertical split:       v
-- Navigate down:                     j
-- Navigate up:                       k
-- Jump to the middle:                M
-- Jump to the top:                   gg
-- Jump to the bottom:                G
-- Scroll up:                         <C-k>
-- Scroll down:                       <C-j>
-- (Preview) scroll up:               <C-p-u>
-- (Preview) scroll down:             <C-p-d>


------------------------------------------------------------
-- Treesitter Plugin

-- No key mappings configured.


------------------------------------------------------------
-- Unimpaired Plugin

-- Currently not installed.


------------------------------------------------------------
-- Unimpaired Plugin

-- Currently not installed.


------------------------------------------------------------
-- Windows Plugin

-- Max-/Minimize buffer: <Leader>m



-- New:

-- harpoon:
-- <L>hm - add mark
-- <L>fm - show marks in telescope
--
