-------------------------------------------------------------------------------
-- VS Code Key Mappings
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Variables

local keymap = vim.keymap.set
local opts   = { noremap = true, silent = true }


-------------------------------------------------------------------------------
-- Key Mappings

-- remap leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader      = " "
vim.g.maplocalleader = " "



-- move text up and down
keymap("v", "J", ":m .+1<CR>==", opts)
keymap("v", "K", ":m .-2<CR>==", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)


-- removes highlighting after escaping vim search
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)


-------------------------------------------------------------------------------
-- Editor controls

keymap({'n', 'v'}, 'L', "<cmd>lua require('vscode').action('workbench.action.focusRightGroup')<CR>")   -- Go to right split (L).
keymap({'n', 'v'}, 'H', "<cmd>lua require('vscode').action('workbench.action.focusLeftGroup')<CR>")    -- Go to left split (H).
--keymap('n', 'J', '<C-w>j', opts)  -- Go to split below (J).
--keymap('n', 'K', '<C-w>k', opts)  -- Go to split above (K).
keymap({'n', 'v'}, '<leader>m', "<cmd>lua require('vscode').action('workbench.action.toggleMaximizeEditorGroup')<CR>")    -- Max-/minimize editor group.
keymap({'n', 'v'}, '<leader>=', "<cmd>lua require('vscode').action('workbench.action.evenEditorWidths')<CR>")    -- Equalize width and height for all splits.
keymap({'n', 'v'}, '<leader>rc', "<cmd>lua require('vscode').action('workbench.action.reloadWindow')<CR>")    -- Reload VS Code.
keymap({'n', 'v'}, '<leader>x', "<cmd>lua require('vscode').action('workbench.action.splitEditorRight')<CR>")    -- Split buffer vertically (y-axis).
keymap({'n', 'v'}, '<leader>-', "<cmd>lua require('vscode').action('workbench.action.splitEditorDown')<CR>")   -- Split buffer horizontally (x-axis).



-------------------------------------------------------------------------------
-- Comments

keymap({'n', 'v'}, '<leader>/',  "<cmd>lua require('vscode').action('editor.action.commentLine')<CR>")
keymap({'n', 'v'}, '<leader>bc', "<cmd>lua require('vscode').action('editor.action.blockComment')<CR>")


-------------------------------------------------------------------------------
-- Searching

keymap({'n', 'v'}, '<leader>ff',  "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
keymap('n', 'n',  'nzzzv',        opts)  -- Center the screen after jumping to the next match.
keymap('n', 'N',  'Nzzzv',        opts)  -- Center the screen after jumping to the previous match.


-------------------------------------------------------------------------------
-- Editing boost

keymap('n',        'U',          '<C-r>',        opts)  -- Redo last action.
keymap('n',        ',,',         '<Esc>A,<Esc>', opts)  -- Insert a , at the end of a line.
keymap('n',        '::',         '<Esc>A:<Esc>', opts)  -- Insert a : at the end of a line.
keymap('n',        'x',          '"_x',          opts)  -- If delete one char, don't copy it to the clipboard.
keymap('n',        'q:',         ':q<CR>',       opts)  -- Disable typical command line typo.
keymap({'n', 'v'}, '<Leader>jl', 'J',            opts)  -- Join line below with white space.
keymap('v',        '<<',         '<gv',          opts)  -- Stay in visual mode after indent width <<.
keymap('v',        '>>',         '>gv',          opts)  -- Stay in visual mode after indent width >>.
keymap('n', 'Y',  '+y$',    opts)        -- Yank to end of line.

keymap({"n", "v"}, "y", '"+y',   opts)  -- Yank line to system clipboard.
keymap({"n", "v"}, "yy", '"+yy', opts)  -- Yank to system clipboard.

keymap({"n", "v"}, "D", '"+D', opts)  -- Delete to end of line and copy to system clipboard.


-- paste from system clipboard
-- keymap({"n", "v"}, "<leader>p", '"+p', opts)
keymap({"n", "v"}, "p", '"+p', opts)


-------------------------------------------------------------------------------
-- Visual mode

keymap('n', 'vv', 'V',     opts)        -- Enter visual line mode like all other line commands.
keymap('n', 'vb', '<C-v>', opts)        -- Enter visual block mode (vb).
keymap('v', 'y',  'myy`y', opts)        -- Maintain the cursor position when yanking a visual selection.
keymap('v', 'Y',  'myY`y', opts)        -- Maintain the cursor position when yanking a visual line selection.
keymap('v', '<<', '<gv',   opts)        -- Stay in visual mode after indent width <<.
keymap('v', '>>', '>gv',   opts)        -- Stay in visual mode after indent width >>.
keymap('v', 'p',  '"_dP',  opts)        -- Paste preserves primal yanked piece.


-------------------------------------------------------------------------------
-- Scrolling
keymap('n', '<C-k>',   '<C-u>',   opts)  -- Scroll up.
keymap('n', '<C-j>',   '<C-e>',   opts)  -- Scroll down.
keymap('n', '<C-p-u>', '<C-b>',   opts)  -- Scroll page up.
keymap('n', '<C-p-d>', '<C-f>',   opts)  -- Scroll page down.
keymap('n', '<C-u>',   '<C-u>zz', opts)  -- Scroll half page up and center.
keymap('n', '<C-d>',   '<C-d>zz', opts)  -- Scroll half page down and center.




-- vim.keymap.set('n', '<Leader><Leader>==', 'ggvvG=', opts)                -- Auto indent the whole file.



-------------------------------------------------------------------------------
-- Explorer (File tree)

keymap({'n', 'v'}, '<leader>tt', "<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')<CR>")         -- Toggle tree.
keymap({'n', 'v'}, '<leader>et', "<cmd>lua require('vscode').action('workbench.view.explorer')<CR>")                          -- Explore tree.
keymap({'n', 'v'}, '<leader>et', "<cmd>lua require('vscode').action('workbench.files.action.showActiveFileInExplorer')<CR>")  -- Show actual file in tree.
-- keymap('n',        'r',          "<cmd>lua require('vscode').action('renameFile')<CR>")                                       -- Rename.
-- copy path
-- copy relative path
keymap('n',        '<leader>x',          "<cmd>lua require('vscode').action('explorer.openToSide')<CR>")                              -- Open file in vertical split.
-- keymap('n',        'c',          "<cmd>lua require('vscode').action('filesExplorer.copy')<CR>")                               -- Copy.
--keymap('n',        'x',          "<cmd>lua require('vscode').action('filesExplorer.cut')<CR>")                                -- Cut.
--keymap('n',        'p',          "<cmd>lua require('vscode').action('filesExplorer.paste')<CR>")                              -- Paste.

-- This does only work in the editor, not in the explorer:
-- keymap('n',        'ni',         "<cmd>lua require('vscode').action('explorer.newFile')<CR>")                                 -- Create new file. (maybe directory too?)


--keymap('n',        'd',          "<cmd>lua require('vscode').action('deleteFile')<CR>")                                       -- Delete file. (maybe directory too?)


-------------------------------------------------------------------------------
-- Terminal

keymap({'n', 'v'}, '<leader>th', "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")  -- Open terminal horizontally.
-- workbench.action.closePanel


-------------------------------------------------------------------------------
-- Harpoon Extension
-- https://marketplace.visualstudio.com/items?itemName=tobias-z.vscode-harpoon

-- Jump to a file in the Harpoon list:
keymap({'n', 'v'}, '<leader>h1', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor1')<CR>")
keymap({'n', 'v'}, '<leader>h2', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor2')<CR>")
keymap({'n', 'v'}, '<leader>h3', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor3')<CR>")
keymap({'n', 'v'}, '<leader>h4', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor4')<CR>")
keymap({'n', 'v'}, '<leader>h5', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor5')<CR>")
keymap({'n', 'v'}, '<leader>h6', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor6')<CR>")
keymap({'n', 'v'}, '<leader>h7', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor7')<CR>")
keymap({'n', 'v'}, '<leader>h8', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor8')<CR>")
keymap({'n', 'v'}, '<leader>h9', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor9')<CR>")

-- Mark a file:
keymap({'n', 'v'}, '<leader>hm', "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>")


keymap({"n", "v"}, "<leader>ho", "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>")
keymap({"n", "v"}, "<leader>he", "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>")



-------------------------------------------------------------------------------
-- Project Manager Extension
-- https://marketplace.visualstudio.com/items?itemName=alefragnani.project-manager

keymap({'n', 'v'}, '<leader>pa', "<cmd>lua require('vscode').action('projectManager.saveProject')<CR>")
keymap({'n', 'v'}, '<leader>pl', "<cmd>lua require('vscode').action('projectManager.listProjectsNewWindow')<CR>")
keymap({'n', 'v'}, '<leader>pe', "<cmd>lua require('vscode').action('projectManager.editProjects')<CR>")














----------------------- stuff out of the www:
-- general keymaps
--keymap({"n", "v"}, "<leader>b", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
--keymap({"n", "v"}, "<leader>d", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
--keymap({"n", "v"}, "<leader>a", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
--keymap({"n", "v"}, "<leader>sp", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
--keymap({"n", "v"}, "<leader>cn", "<cmd>lua require('vscode').action('notifications.clearAll')<CR>")
--keymap({"n", "v"}, "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
--keymap({"n", "v"}, "<leader>cp", "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>")
--keymap({"n", "v"}, "<leader>pr", "<cmd>lua require('vscode').action('code-runner.run')<CR>")
--keymap({"n", "v"}, "<leader>fd", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")
--
--
