-- ~/.dotfiles/nvim/lua/user/plugin_options/nvim-cmp.lua



------------------------------------------------------------------------------
-- Nvim CMP Plugin
------------------------------------------------------------------------------

-- Import CMP plugin with a protected call:
local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
  return
end

-- Import Luasnip plugin with a protected call:
local snip_status_ok, luasnip = pcall(require, 'luasnip')
if not snip_status_ok then
  return
end

-- Import LSP Kind plugin with a protected call:
local lspkind_status_ok, lspkind = pcall(require, 'lspkind')
if not lspkind_status_ok then
  return
end

-- Load snippet engine from VSCode with Friendly Snippets plugin:
require('luasnip/loaders/from_vscode').lazy_load()


------------------------------------------------------------
-- Appearance

-- Enable completion popup, complete if there is only one, don't jump in menu:
vim.opt.completeopt = 'menu,menuone,noselect'

--[[ local check_backspace = function() ]]
--[[   local col = vim.fn.col "." - 1 ]]
--[[   return col == 0 or vim.fn.getline("."):sub(col, col):match "%s" ]]
--[[ end ]]

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')


--[[ local kind_icons = { ]]
--[[   Text          = '󰊄 ', ]]
--[[   Method        = 'm ', ]]
--[[   Function      = 'ƒ ', ]]
--[[   Constructor   = ' ', ]]
--[[   Field         = ' ', ]]
--[[   Variable      = '󰄷 ', ]]
--[[   Class         = ' ', ]]
--[[   Interface     = ' ', ]]
--[[   Module        = ' ', ]]
--[[   Property      = ' ', ]]
--[[   Unit          = ' ', ]]
--[[   Value         = ' ', ]]
--[[   Enum          = ' ', ]]
--[[   Keyword       = ' ', ]]
--[[   Snippet       = ' ', ]]
--[[   Color         = ' ', ]]
--[[   File          = ' ', ]]
--[[   Reference     = ' ', ]]
--[[   Folder        = ' ', ]]
--[[   EnumMember    = ' ', ]]
--[[   Constant      = ' ', ]]
--[[   Struct        = ' ', ]]
--[[   Event         = ' ', ]]
--[[   Operator      = ' ', ]]
--[[   TypeParameter = ' ', ]]
--[[ } ]]


cmp.setup {
  snippet = {
    expand = function(args)
      -- Activate LuaSnip:
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    -- Confirm auto complete selection:
    ['<C><Leader>'] = cmp.mapping.confirm({ select = true }),
    -- Previous list item:
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    -- Next list item:
    ['<Tab>'] = cmp.mapping.select_next_item(),
    -- Quit suggestion popup:
    ['<C-q>'] = cmp.mapping.abort(),
    -- Scroll down in docs:
    ['<C-j>'] = cmp.mapping.scroll_docs(4),
    -- Scroll up in docs:
    ['<C-k>'] = cmp.mapping.scroll_docs(-4),
    -- Show completion suggestions:
    ['<C-c>'] = cmp.mapping.complete(),
  },
  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 1000,
      ellipsis_char = '...',
    }),
  },
--[[ formatting = { ]]
--[[     fields = { ]]
--[[       'kind', ]]
--[[       'abbr', ]]
--[[       'menu' ]]
--[[     }, ]]
--[[     maxwidth = 0.99, ]]
--[[     format = function(entry, vim_item) ]]
--[[      -- LSP-Kind icons: ]]
--[[       --[[ vim_item.kind = string.format("%s", kind_icons[vim_item.kind])  ]]
--[[      -- LSP-Kind incons with name: ]]
--[[      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) ]]
--[[      vim_item.menu = ({  ]]
--[[        nvim_lsp = '[LSP]',  ]]
--[[        luasnip  = '[Snippet]', ]]
--[[        buffer   = '[Buffer]', ]]
--[[        path     = '[Path]', ]]
--[[      })[entry.source.name] ]]
--[[      return vim_item ]]
--[[    end, ]]
--[[  }, ]]
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip'  },
    { name = 'buffer'   },
    { name = 'path'     },
    { name = 'cmp_breadcrumb' },
  }),
  --[[ confirm_opts = { ]]
  --[[   behavior = cmp.ConfirmBehavior.Replace, ]]
  --[[   select = false, ]]
  --[[ }, ]]
  --[[ window = { ]]
  --[[   documentation = { ]]
  --[[    --[[ border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, ]]
  --[[    border = false, ]]
  --[[   }, ]]
  --[[ }, ]]
  --[[ experimental = { ]]
  --[[   ghost_text  = false, ]]
  --[[   native_menu = false, ]]
  --[[ }, ]]
  --[[ select_first_item = true, ]]
}

-- Genghis direction autocompletion requires this for CMP after CMP setup:
cmp.setup.filetype('DressingInput', {
  sources = cmp.config.sources { {name = 'omni'} },
})

--[[ window.documentation = cmp.config.window.bordered() ]]

