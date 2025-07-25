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

-- INFO: This is not the problem of extra right cursor move:
    -- vim.keymap.set( 'x', 'aoc',  function() require'align'.align_to_char({ length = 1, }) end, NS)                                                -- Align to 1 character.
    -- vim.keymap.set( 'x', 'aocc', function() require'align'.align_to_char({ length = 2, }) end, NS)                                               -- Align to 2 characters.
    -- vim.keymap.set( 'x', 'aos',  function() require'align'.align_to_string({ regex = false, }) end, NS)                                           -- Align to a string.
    -- vim.keymap.set( 'x', 'aop',  function() require'align'.align_to_string({ regex = true, }) end, NS)                                            -- Align to a regex.


    -- Original plugin key mappings:
    -- vim.keymap.set( 'x', 'aa', function() require'align'.align_to_char({ length = 1, }) end, NS)                                                -- Aligns to 1 character.
    -- vim.keymap.set( 'x', 'ad', function() require'align'.align_to_char({ preview = true, length = 2, }) end, NS)                                -- Aligns to 2 characters with previews.
    -- vim.keymap.set( 'x', 'aw', function() require'align'.align_to_string({ preview = true, regex = false, }) end, NS)                           -- Aligns to a string with previews.
    -- vim.keymap.set( 'x', 'ar', function() require'align'.align_to_string({ preview = true, regex = true, }) end, NS)                            -- Aligns to a Vim regex with previews.
    -- vim.keymap.set( 'n', 'gaw', function() local a = require'align' a.operator( a.align_to_string, { regex = false, preview = true, }) end, NS) -- Example gawip to align a paragraph to a string with previews.
    -- vim.keymap.set( 'n', 'gaa', function() local a = require'align' a.operator(a.align_to_char) end, NS)                                        -- Example gaaip to align a paragraph to 1 character.
  end
}
