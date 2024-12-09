-------------------------------------------------------------------------------
-- PlantUML Preview Plugin
-- https://github.com/weirongxu/plantuml-previewer.vim
-- Advanced markdown previewer.
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- PlantUML Preview Plugin
-- https://github.com/weirongxu/plantuml-previewer.vim
-------------------------------------------------------------------------------

return {
  'weirongxu/plantuml-previewer.vim',
  dependencies = {
    'tyru/open-browser.vim',
  },
  config = function()

    -- Automatically set the `plantuml.jar` path
    local plantuml_jar_path = vim.fn.systemlist("which plantuml")[1]
    if plantuml_jar_path and vim.fn.filereadable(plantuml_jar_path) == 1 then
      vim.g.plantuml_previewer_jar_path = plantuml_jar_path
    else
      -- Fallback: Set the path manually if detection fails
      vim.g.plantuml_previewer_jar_path = "/path/to/plantuml.jar" -- Update with your path
    end

    -- Disable netrw's `gx` mapping for compatibility with Open Browser plugin
    vim.g.netrw_nogx = 1

    --------------------------------------------------------------
    -- Key Mappings

    -- Don't show command messages in the command line
    local options = { noremap = true, silent = true }

    -- Open PlantUML Preview
    vim.keymap.set('n', '<Leader>umlo', ':PlantumlOpen<CR>', options)

    -- Save PlantUML as PNG
    vim.keymap.set('n', '<Leader>umls', ':PlantumlSave %.png<CR>', options)
  end,
}
-- return {
--   'weirongxu/plantuml-previewer.vim',
--   dependencies = {
--     'tyru/open-browser.vim',
--   },
--   config = function()

--     -- Automatically detect the `plantuml.jar` path based on the installed PlantUML
--     vim.cmd([[
--       autocmd FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(
--         \  matchlist(system('cat `which plantuml` | grep plantuml.jar'), '\v.*\s[''"]?(\S+plantuml\.jar).*'),
--         \  1,
--         \  0
--         \)
--     ]])

--     -- Disable netrw's `gx` mapping for compatibility with Open Browser plugin
--     vim.g.netrw_nogx = 1

--     --------------------------------------------------------------
--     -- Key Mappings

--     -- Don't show command messages in the command line
--     local options = { noremap = true, silent = true }

--     -- Open PlantUML Preview
--     vim.keymap.set('n', '<Leader>umlo', ':PlantumlOpen<CR>', options)

--     -- Save PlantUML as PNG
--     vim.keymap.set('n', '<Leader>umls', ':PlantumlSave %.png<CR>', options)
--   end,
-- }

