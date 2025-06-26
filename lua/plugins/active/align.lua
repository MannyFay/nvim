-------------------------------------------------------------------------------
-- Align Plugin
-- https://github.com/Vonr/align.nvim
-- Align text by a given character.
-------------------------------------------------------------------------------

return {
  'Vonr/align.nvim',
  branch = "v2",
  lazy   = true,
  init   = function()
    local NS = { noremap = true, silent = true }


    ---------------------------------------------------------------------------
    --- Key Mappings

    -- Visual mode alignments (select text first, then use keymap):
    vim.keymap.set('x', '<leader>a=', function() require'align'.align_to_char({length = 1}) end, NS)           -- Align to = (variables, assignments)
    vim.keymap.set('x', '<leader>a:', function() require'align'.align_to_char({length = 1}) end, NS)           -- Align to : (JSON, tables)
    vim.keymap.set('x', '<leader>a,', function() require'align'.align_to_char({length = 1}) end, NS)           -- Align to , (function params)
    vim.keymap.set('x', '<leader>a-', function() require'align'.align_to_string({regex = false}) end, NS)      -- Align to -- (comments)
    vim.keymap.set('x', '<leader>a|', function() require'align'.align_to_char({length = 1}) end, NS)           -- Align to | (tables, markdown)

    -- Interactive alignments with preview:
    vim.keymap.set('x', '<leader>ac', function() require'align'.align_to_char({preview = true, length = 1}) end, NS)      -- Align to any character (interactive)
    vim.keymap.set('x', '<leader>as', function() require'align'.align_to_string({preview = true, regex = false}) end, NS) -- Align to any string (interactive)
    vim.keymap.set('x', '<leader>ar', function() require'align'.align_to_string({preview = true, regex = true}) end, NS)  -- Align to regex pattern (interactive)

    -- Normal mode operators (work with text objects like gaw"ip" for paragraph):
    vim.keymap.set('n', 'ga=', function() local a = require'align' a.operator(function() a.align_to_char({length = 1}) end) end, NS) -- ga=ip to align paragraph to =
    vim.keymap.set('n', 'gac', function() local a = require'align' a.operator(a.align_to_char) end, NS)                            -- gacip to align paragraph to character
  end
}

