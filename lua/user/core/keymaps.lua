-- ~/.dotfiles/nvim/lua/user/core/keymaps.lua



-------------------------------------------------------------------------------
-- Legend
-------------------------------------------------------------------------------

--------------------------------------------------------------
-- Modes

--   normal_mode       = 'n'
--   insert_mode       = 'i',
--   visual_mode       = 'v',
--   visual_block_mode = 'x',
--   term_mode         = 't',
--   command_mode      = 'c',



-------------------------------------------------------------------------------
-- Variables
-------------------------------------------------------------------------------

-- Don't show command message in command line:
local opts      = { noremap = true, silent = true }
-- local term_opts = { silent = true }
local keymap    = vim.api.nvim_set_keymap

-------------------------- Scrolling:
-- Scroll actual line to top:
vim.keymap.set('n', 'T', 'zt', opts)
-- Scroll actual line to bottom:
vim.keymap.set('n', 'B', 'zb', opts)
-- Scroll actual line to center:
vim.keymap.set('n', 'C', 'zz', opts)
-- Scroll up:
vim.keymap.set('n', '<C-k>', '<C-u>', opts)
-- Scroll down:
vim.keymap.set('n', '<C-j>', '<C-e>', opts)
-- Scroll page up:
vim.keymap.set('n', '<C-p-u>', '<C-b>', opts)
-- Scroll page down:
vim.keymap.set('n', '<C-p-d>', '<C-f>', opts)


-------------------------------------------------------------------------------
-- Default Key Mappings
-------------------------------------------------------------------------------

-- Set <Leader> to space (standard is \):
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Quit highlighting of search:
vim.keymap.set('n', '<leader>qh', ':nohlsearch<CR>', opts)

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Redo last action:
vim.keymap.set('n', 'U', '<C-r>', opts)

-- Disable typically command line typo:
vim.keymap.set('n', 'q:', ':q<CR>')

-- Stay in visual mode after indent width <:
vim.keymap.set('v', '<', '<gv', opts)

-- Stay in visual mode after indent width >:
vim.keymap.set('v', '>', '>gv', opts)

-- Maintain the cursor position when yanking a visual selection:
vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

-- Paste/replace visual selection without copying it:
vim.keymap.set('v', 'p', '"_dP')

-- If delete one char, don't copy it to the clipboard:
vim.keymap.set('n', 'x', '"_x')

-- Insert a ; at the end of a line:
vim.keymap.set('n', ';;', '<Esc>A;<Esc>')
-- Insert a , at the end of a line:
vim.keymap.set('n', ',,', '<Esc>A,<Esc>')
-- Insert a : at the end of a line:
vim.keymap.set('n', '::', '<Esc>A:<Esc>')

-- Open the current file in the default program (on Mac this should just be just `open`)
--vim.keymap.set('n', '<leader>x', ':!xdg-open %<cr><cr>')

-- Move text up and down
vim.keymap.set('x', '<Tab>', ":move '>+1<CR>gv-gv")
vim.keymap.set('x', '<S-Tab>', ":move '<-2<CR>gv-gv")
vim.keymap.set('v', '<Tab>', ":move '>+1<CR>gv=gv")
vim.keymap.set('v', '<S-Tab>', ":move '<-2<CR>gv=gv")

-- Enter visual block mode (vb):
vim.keymap.set('n', 'vb', '<C-v>', opts)

-- Join line below with white space:
vim.keymap.set('n', '<Leader>jl', 'J', opts)

--------------------------------------------------------------
-- Splitting

-- Split buffer vertically (y-axis) ( y):
keymap("n", "<Leader>v", ":vsplit<CR>", opts)

-- Split buffer horizontally (x-axis) ( x):
keymap("n", "<Leader>h", ":split<CR>", opts)

--------------------------------------------------------------
-- Navigation

-- Go to right split (L):
keymap("n", "L", "<C-w>l", opts)

-- Go to left split (H):
keymap("n", "H", "<C-w>h", opts)

-- Go to split below (J):
keymap("n", "J", "<C-w>j", opts)

-- Go to split above (K):
keymap("n", "K", "<C-w>k", opts)

--------------------------------------------------------------
-- Resizing

-- Equalize width and height for all splits ( es):
keymap("n", "<Leader>es", "<C-w>=", opts)

-- Grow split vertical ( gv):
keymap("n", "<Leader>gv", ":vertical resize +5<CR>", opts)

-- Shrink split vertical ( sv):
keymap("n", "<Leader>sv", ":vertical resize -5<CR>", opts)

-- Grow split horizontally ( gh):
keymap("n", "<Leader>gh", ":resize +5<CR>", opts)

-- Shrink split horizontally ( sh):
keymap("n", "<Leader>sh", ":resize -5<CR>", opts)


-- Open terminal in horizontal buffer below ( tb):
keymap("n", "<Leader>th", ":split term://zsh<CR>i", opts)

-- Open terminal in vertical buffer to the next ( tn):
keymap("n", "<Leader>tv", ":vsplit term://zsh<CR>i", opts)


-- Open new tab ( ot):
keymap("n", "<Leader>nt", ":tabnew<CR>", opts)

-- Exit current tab: ( et):
keymap("n", "<Leader>qt", ":tabclose<CR>", opts)

-- Go to next tab ( nt):
keymap("n", "<Leader>tr", ":tabn<CR>", opts)

-- Go to previous tab ( pt):
keymap("n", "<Leader>tl", ":tabp<CR>", opts)



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
-- New:                           n
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
-- SplitJoin Plugin

-- Join object under cursor:        <Leader>jo
-- Split object under cursor:       <Leader>so


------------------------------------------------------------
-- Telescope Plugin

-- Find file:                         <Leader>ff
-- Find text:                         <Leader>ft
-- Recent files:                      <Leader>rf
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

