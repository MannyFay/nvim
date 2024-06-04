-- https://github.com/nvim-telescope/telescope-fzf-native.nvim



------------------------------------------------------------------------------
-- Telescope FZF Native Plugin
------------------------------------------------------------------------------

-- You don't need to set any of these options. These are the default ones.
-- Only the loading in your Telescope setup is important.


-- Put this in your 'extension' section of your Telescope setup:

--  extensions = {
--    fzf = {
        -- False will only do exact matching:
--        fuzzy = true,
        -- Override the generic sorter:
--        override_generic_sorter = true,
        -- Override the file sorter:
--        override_file_sorter = true,
        -- Options are 'ignore_case', 'respect_case', 'smart_case':
--        case_mode = 'smart_case',
--    },
--  },


-- To get FZF loaded and working with Telescope, you need to call the
-- load_extension() function, somewhere after the Telescope setup function:

--require('telescope').load_extension('fzf')