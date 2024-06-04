-- Add this to your Packer plugins file:
-------------------------------------------------------------------------------
-- NeoScroll (enable smooth scrolling to avoid hard jumps)

--[[ use({ ]]
--[[   'karb94/neoscroll.nvim', ]]
--[[   config = function() ]]
--[[     require('user.plugin_options.neoscroll') ]]
--[[   end ]]
--[[ }) ]]


-- https://github.com/karb94/neoscroll.nvim



------------------------------------------------------------------------------
-- Neoscroll Plugin
------------------------------------------------------------------------------

-- Import Neoscroll with a protected call:
local neoscroll_status_ok, neoscroll = pcall(require, 'neoscroll')
if not neoscroll_status_ok then
  return
end


------------------------------------------------------------
-- Appearance

neoscroll.setup({
    mappings = {
      -- Scroll half screen up:
      '<C-k>',
      -- Scroll half screen down:
      '<C-j>',
      -- Scroll one screen up:
      ' k',
      -- Scroll one screen down:
      ' j',
      -- Scroll up:
      --'<Leader>k',
      -- Scroll down:
      --'<Leader>j',
      -- Scroll current line to top:
      'T',
      -- Center current line on screen:
      'zz',
      -- Scroll current line to bottom:
      'zb',
    },
    -- Hide cursor while scrolling:
    hide_cursor = true,
    -- Stop at <EOF> when scrolling downwards:
    stop_eof = true,
    -- Stop scrolling when the cursor reaches the scrolloff margin of the file:
    respect_scrolloff = false,
    -- The cursor will keep on scrolling even if the window cannot scroll further:
    cursor_scrolls_alone = true,
    -- Default easing function:
    easing_function = nil,
    -- Function to run before the scrolling animation starts:
    pre_hook = nil,
    -- Function to run after the scrolling animation ends:
    post_hook = nil,
    -- Disable "Performance Mode" on all buffers:
    performance_mode = false,
})
