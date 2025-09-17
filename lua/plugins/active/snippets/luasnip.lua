-------------------------------------------------------------------------------
-- LuaSnip Plugin Configuration
-- https://github.com/L3MON4D3/LuaSnip
-- Snippet engine for Neovim
-------------------------------------------------------------------------------

return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets", -- Collection of snippets
  },
  config = function()
    local luasnip = require("luasnip")
    local types = require("luasnip.util.types")
    
    -- Configure LuaSnip
    luasnip.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "<-", "Error" } },
          },
        },
      },
    })
    
    -- Add custom snippets path from CS_code-snippets
    local snippets_path = vim.fn.expand("~/work/fitcrew/gitlab/Utilities/CS_code-snippets")
    
    -- Load VSCode-style snippets from custom path if it exists
    if vim.fn.isdirectory(snippets_path) == 1 then
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { snippets_path } })
    end
    
    -- Also load friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    
    -- Load any Lua snippets from the custom path
    local lua_snippets_path = snippets_path .. "/lua"
    if vim.fn.isdirectory(lua_snippets_path) == 1 then
      require("luasnip.loaders.from_lua").lazy_load({ paths = { lua_snippets_path } })
    end
    
    -- Keymaps for snippet navigation
    vim.keymap.set({ "i", "s" }, "<C-n>", function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { silent = true, desc = "LuaSnip: Expand or jump forward" })
    
    vim.keymap.set({ "i", "s" }, "<C-p>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { silent = true, desc = "LuaSnip: Jump backward" })
    
    vim.keymap.set({ "i", "s" }, "<C-l>", function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end, { silent = true, desc = "LuaSnip: Cycle through choice nodes" })
  end,
}