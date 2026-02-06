-------------------------------------------------------------------------------
-- Local Highlight Plugin
-- https://github.com/tzachar/local-highlight.nvim
-- Highlight all occurrences of a word in a buffer.
-------------------------------------------------------------------------------

return {
  'tzachar/local-highlight.nvim',
  config = function()
    local local_highlight = require('local-highlight')

    local_highlight.setup({
      -- file_types = {'python', 'cpp'}, -- If this is given only attach to this
      -- OR attach to every filetype except:
      -- disable_file_types = {'tex'},
      -- Highlight group to use for highlighting
      hlgroup = 'Search',
      cw_hlgroup = nil,
      -- Whether to display highlights in INSERT mode or not
      insert_mode = true,
      -- Minimum length of the match to highlight
      min_match_len = 1,
      -- Maximum length of the match to highlight
      max_match_len = math.huge,
      -- Whether to highlight only the first match or all matches
      highlight_single_match = true,
    })
  end
}
