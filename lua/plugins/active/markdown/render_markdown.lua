return {
  'MeanderingProgrammer/render-markdown.nvim',
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },         -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  config = function(_, opts)
    require('render-markdown').setup(opts)
    -- Re-apply mannydark highlights after plugin loads (fixes colorscheme race condition)
    pcall(function()
      require('mannydark.highlighting.plugins.render_markdown').setupHighlighting()
    end)

    -- Force remove bold from headings (override any defaults)
    local colors = require('mannydark.palette')
    vim.api.nvim_set_hl(0, 'RenderMarkdownH1', { fg = colors.purple, bold = false })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH2', { fg = colors.blue, bold = false })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH3', { fg = colors.blue, bold = false })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH4', { fg = colors.blue, bold = false })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH5', { fg = colors.blue, bold = false })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH6', { fg = colors.blue, bold = false })

    -- Also override the standard markdown heading highlights (treesitter/syntax)
    vim.api.nvim_set_hl(0, '@markup.heading.1.markdown', { fg = colors.purple, bold = false })
    vim.api.nvim_set_hl(0, '@markup.heading.2.markdown', { fg = colors.blue, bold = false })
    vim.api.nvim_set_hl(0, '@markup.heading.3.markdown', { fg = colors.blue, bold = false })
    vim.api.nvim_set_hl(0, '@markup.heading.4.markdown', { fg = colors.blue, bold = false })
    vim.api.nvim_set_hl(0, '@markup.heading.5.markdown', { fg = colors.blue, bold = false })
    vim.api.nvim_set_hl(0, '@markup.heading.6.markdown', { fg = colors.blue, bold = false })

    -- Remove bold from list markers (bullets and ordered numbers)
    vim.api.nvim_set_hl(0, 'RenderMarkdownBullet', { fg = colors.blue, bold = false })
    vim.api.nvim_set_hl(0, '@markup.list.markdown', { fg = colors.blue, bold = false })
    vim.api.nvim_set_hl(0, '@markup.list.numbered.markdown', { fg = colors.blue, bold = false })
    vim.api.nvim_set_hl(0, '@markup.list.unnumbered.markdown', { fg = colors.blue, bold = false })

    -- Bold text (**content**) - blue and bold
    vim.api.nvim_set_hl(0, '@markup.strong', { fg = colors.blue, bold = true })
    vim.api.nvim_set_hl(0, '@markup.strong.markdown_inline', { fg = colors.blue, bold = true })

    -- Inline code (`content`) - green text, keep background
    local code_hl = vim.api.nvim_get_hl(0, { name = 'RenderMarkdownCodeInline' })
    vim.api.nvim_set_hl(0, 'RenderMarkdownCodeInline', { fg = colors.green, bg = code_hl.bg })
    vim.api.nvim_set_hl(0, '@markup.raw.markdown_inline', { fg = colors.green, bg = code_hl.bg })
  end,
  opts = {
    -----------------------------------------------------------------------
    -- Core Settings

    -- Whether markdown rendering is active by default
    enabled = true,
    -- Vim modes that render markdown (insert mode excluded by default)
    -- 'n' = normal, 'c' = command, 't' = terminal, 'i' = insert, 'v' = visual
    render_modes = { 'n', 'c', 't', 'i', 'v' },
    -- Milliseconds to wait before updating marks after text change
    debounce = 100,
    -- Pre-configured settings: 'obsidian' | 'lazy' | 'none'
    -- obsidian: adds callouts and modified checkboxes
    -- lazy: adds additional icon presets
    preset = 'none',
    -- Log level for :RenderMarkdown log command: 'debug' | 'info' | 'error'
    log_level = 'error',
    -- Print runtime of main update method
    log_runtime = false,
    -- Filetypes where plugin operates
    file_types = { 'markdown' },
    -- Maximum file size in MB to render (0 = no limit)
    max_file_size = 10.0,
    -- Custom function to determine if buffer should be ignored
    -- ignore = function(buf) return false end,
    -- Render markdown inside markdown (e.g., in code blocks)
    nested = true,
    -- Additional change events to trigger re-render: 'InsertLeave', 'TextChanged', etc.
    change_events = {},
  -- Restart treesitter highlighter on attach (fixes some rendering issues)
    restart_highlighter = false,

    -----------------------------------------------------------------------
    -- Anti-Conceal

    anti_conceal = {
      -- Enable anti-conceal functionality
      enabled = true,
      -- Modes to disable anti-conceal (false = never disable, or table of modes)
      disabled_modes = false,
      -- Lines above cursor to reveal
      above = 0,
      -- Lines below cursor to reveal
      below = 0,
      -- Elements to ignore during anti-conceal
      ignore = {
        code_background = true,
        indent = true,
        sign = true,
        virtual_lines = true,
      },
    },

    -----------------------------------------------------------------------
    -- Padding

    padding = {
      -- Highlight group for padding
      highlight = 'Normal',
    },

    -----------------------------------------------------------------------
    -- Latex

    latex = {
      -- Enable LaTeX rendering
      enabled = true,
      -- Render modes for LaTeX (false = inherit from top-level)
      render_modes = false,
      -- Command(s) to convert LaTeX to text (first found is used)
      converter = { 'utftex', 'latex2text' },
      -- Highlight group for LaTeX
      highlight = 'RenderMarkdownMath',
      -- Position of rendered LaTeX: 'above' | 'below' | 'center'
      position = 'center',
      -- Empty lines above LaTeX blocks
      top_pad = 0,
      -- Empty lines below LaTeX blocks
      bottom_pad = 0,
    },

    -----------------------------------------------------------------------
    -- Callbacks

    on = {
      -- Called when plugin first attaches to buffer
      attach = function() end,
      -- Called on initial render
      initial = function() end,
      -- Called on each render
      render = function() end,
      -- Called when marks are cleared
      clear = function() end,
    },

    -----------------------------------------------------------------------
    -- Completions

    completions = {
      -- blink.cmp integration
      blink = { enabled = false },
      -- coq_nvim integration
      coq = { enabled = false },
      -- nvim-cmp integration
      lsp = { enabled = false },
      -- Filter functions for completions
      filter = {
        callout = function() return true end,
        checkbox = function() return true end,
      },
    },

    -----------------------------------------------------------------------
    -- Headings

    heading = {
      -- Enable heading rendering
      enabled = true,
      -- Render modes (false = inherit from top-level)
      render_modes = false,
      -- Render ATX headings (# style)
      atx = true,
      -- Render setext headings (underline style)
      setext = true,
      -- Show signs in sign column
      sign = true,
      -- Icons for each heading level (1-6)
      icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
      -- Position of icon: 'overlay' | 'inline' | 'right'
      position = 'inline',
      -- Signs for each heading level (or single sign for all)
      signs = { '󰫎 ' },
      -- Width of heading background: 'full' | 'block'
      width = 'full',
      -- Left margin (columns)
      left_margin = 0,
      -- Left padding inside heading
      left_pad = 0,
      -- Right padding inside heading
      right_pad = 0,
      -- Minimum width of heading
      min_width = 0,
      -- Show border above/below headings
      border = false,
      -- Use virtual lines for borders
      border_virtual = false,
      -- Show border prefix on heading line
      border_prefix = false,
      -- Character for border above
      above = '▄',
      -- Character for border below
      below = '▀',
      -- Background highlight groups for each level
      backgrounds = {
        'RenderMarkdownH1Bg',
        'RenderMarkdownH2Bg',
        'RenderMarkdownH3Bg',
        'RenderMarkdownH4Bg',
        'RenderMarkdownH5Bg',
        'RenderMarkdownH6Bg',
      },
      -- Foreground highlight groups for each level
      foregrounds = {
        'RenderMarkdownH1',
        'RenderMarkdownH2',
        'RenderMarkdownH3',
        'RenderMarkdownH4',
        'RenderMarkdownH5',
        'RenderMarkdownH6',
      },
      -- Custom heading configurations by level
      custom = {},
    },

    -----------------------------------------------------------------------
    -- Paragraphs

    paragraph = {
      -- Enable paragraph rendering
      enabled = true,
      -- Render modes (false = inherit from top-level)
      render_modes = false,
      -- Left margin (columns)
      left_margin = 0,
      -- Paragraph indent
      indent = 0,
      -- Minimum width of paragraph
      min_width = 0,
    },

    -----------------------------------------------------------------------
    -- Code Blocks

    code = {
      -- Enable code block rendering
      enabled = true,
      -- Render modes (false = inherit from top-level)
      render_modes = false,
      -- Show signs in sign column
      sign = true,
      -- Conceal opening/closing delimiters (```)
      conceal_delimiters = true,
      -- Show language info (icon and/or name)
      language = true,
      -- Position of language info: 'left' | 'right'
      position = 'left',
      -- Show language icon
      language_icon = true,
      -- Show language name
      language_name = true,
      -- Show language info string (e.g., filename)
      language_info = true,
      -- Padding around language info
      language_pad = 0,
      -- Languages to disable background for
      disable_background = { 'diff' },
      -- Width of code block: 'full' | 'block'
      width = 'block',
      -- Left margin (columns)
      left_margin = 0,
      -- Left padding inside code block
      left_pad = 2,
      -- Right padding inside code block
      right_pad = 2,
      -- Minimum width of code block
      min_width = 100,
      -- Border style: 'hide' | 'thin' | 'thick' | 'none'
      border = 'hide',
      -- Character for language border
      language_border = '█',
      -- Character(s) for left of language info
      language_left = '',
      -- Character(s) for right of language info
      language_right = '',
      -- Character for border above
      above = '▄',
      -- Character for border below
      below = '▀',
      -- Enable inline code rendering
      inline = true,
      -- Character(s) for left of inline code
      inline_left = '',
      -- Character(s) for right of inline code
      inline_right = '',
      -- Padding for inline code
      inline_pad = 0,
      -- Render priority (higher = rendered later)
      priority = 140,
      -- Highlight group for code block background
      highlight = 'RenderMarkdownCode',
      -- Highlight group for language info
      highlight_info = 'RenderMarkdownCodeInfo',
      -- Highlight group for language name (nil = use highlight_info)
      highlight_language = nil,
      -- Highlight group for code block border
      highlight_border = 'RenderMarkdownCodeBorder',
      -- Highlight group for fallback (unknown language)
      highlight_fallback = 'RenderMarkdownCodeFallback',
      -- Highlight group for inline code
      highlight_inline = 'RenderMarkdownCodeInline',
      -- Style: 'full' | 'normal' | 'language' | 'none'
      style = 'full',
    },

    -----------------------------------------------------------------------
    -- Dash

    dash = {
      -- Enable dash rendering
      enabled = true,
      -- Render modes (false = inherit from top-level)
      render_modes = false,
      -- Character to repeat for dash line
      icon = '─',
      -- Width: 'full' | number (columns)
      width = 100,
      -- Left margin (columns)
      left_margin = 0,
      -- Render priority (nil = auto)
      priority = nil,
      -- Highlight group
      highlight = 'RenderMarkdownDash',
    },

    -----------------------------------------------------------------------
    -- Document

    document = {
      -- Enable document-level rendering
      enabled = true,
      -- Render modes (false = inherit from top-level)
      render_modes = false,
      -- Concealment settings
      conceal = {
        -- Patterns to conceal individual characters
        char_patterns = {},
        -- Patterns to conceal entire lines
        line_patterns = {},
      },
    },

    -----------------------------------------------------------------------
    -- Bullet Points

    bullet = {
      -- Enable bullet point rendering
      enabled = true,
      -- -- Render modes (false = inherit from top-level)
      -- render_modes = false,
      -- -- Icons for unordered list levels
      -- icons = { '●', '○', '◆', '◇' },
      -- -- Function or table for ordered list icons
      -- -- ordered_icons = function(ctx) return ctx.index .. '.' end,
      -- ordered_icons = 'empty', -- 'empty' to disable
      -- -- Left padding
      -- left_pad = 0,
      -- -- Right padding
      -- right_pad = 0,
      -- -- Highlight group
      -- highlight = 'RenderMarkdownBullet',
      -- -- Scope highlight groups per level
      -- scope_highlight = {},
      -- -- Scope render priority (nil = auto)
      -- scope_priority = nil,
    },

    -----------------------------------------------------------------------
    -- Checkboxes

    checkbox = {
      -- Enable checkbox rendering
      enabled = true,
      -- Render modes (false = inherit from top-level)
      render_modes = false,
      -- Replace bullet with checkbox (true = no bullet shown)
      bullet = false,
      -- Left padding
      left_pad = 0,
      -- Right padding
      right_pad = 0,
      -- Unchecked checkbox [ ]
      unchecked = {
        icon = '󰄱 ',
        highlight = 'RenderMarkdownUnchecked',
        scope_highlight = nil,
      },
      -- Checked checkbox [x]
      checked = {
        icon = '󰱒 ',
        highlight = 'RenderMarkdownChecked',
        scope_highlight = nil,
      },
      -- Custom checkboxes (matched by raw text)
      custom = {
        todo = {
          raw = '[-]',
          rendered = '󰥔 ',
          highlight = 'RenderMarkdownTodo',
          scope_highlight = nil,
        },
        -- Example: in-progress checkbox
        -- progress = {
        --   raw = '[/]',
        --   rendered = '󰡖 ',
        --   highlight = 'RenderMarkdownTodo',
        -- },
        -- Example: cancelled checkbox
        -- cancelled = {
        --   raw = '[~]',
        --   rendered = '󰰱 ',
        --   highlight = 'RenderMarkdownError',
        -- },
      },
      -- Scope render priority (nil = auto)
      scope_priority = nil,
    },

    -----------------------------------------------------------------------
    -- Block Quotes

    quote = {
      -- Enable quote rendering
      enabled = true,
      -- Render modes (false = inherit from top-level)
      render_modes = false,
      -- Icon for quote marker
      icon = '▋',
      -- Repeat icon on line breaks within quote
      repeat_linebreak = false,
      -- Highlight groups for nested quote levels
      highlight = {
        'RenderMarkdownQuote1',
        'RenderMarkdownQuote2',
        'RenderMarkdownQuote3',
        'RenderMarkdownQuote4',
        'RenderMarkdownQuote5',
        'RenderMarkdownQuote6',
      },
    },

    -----------------------------------------------------------------------
    -- Tables

    pipe_table = {
      -- Enable table rendering
      enabled = true,
      -- Render modes (false = inherit from top-level)
      render_modes = false,
      -- Preset: 'none' | 'round' | 'double' | 'heavy'
      preset = 'none',
      -- Cell style: 'padded' | 'raw' | 'trimmed' | 'overlay'
      cell = 'padded',
      -- Function to calculate cell offset
      -- cell_offset = function() return 0 end,
      -- Padding inside cells
      padding = 1,
      -- Minimum cell width
      min_width = 0,
      -- Border characters: top-left, top-mid, top-right, mid-left, mid-mid, mid-right, bot-left, bot-mid, bot-right, vertical, horizontal
      border = { '┌', '┬', '┐', '├', '┼', '┤', '└', '┴', '┘', '│', '─' },
      -- Show table border
      border_enabled = true,
      -- Use virtual lines for border
      border_virtual = false,
      -- Character for alignment indicator in delimiter row
      alignment_indicator = '━',
      -- Highlight group for header row
      head = 'RenderMarkdownTableHead',
      -- Highlight group for body rows
      row = 'RenderMarkdownTableRow',
      -- Highlight group for filler cells
      filler = 'RenderMarkdownTableFill',
      -- Style: 'full' | 'normal' | 'none'
      style = 'full',
    },

    -----------------------------------------------------------------------
    -- Callouts

    callout = {
      -- GitHub-style callouts
      note = { raw = '[!NOTE]', rendered = '󰋽 Note', highlight = 'RenderMarkdownInfo', category = 'github' },
      tip = { raw = '[!TIP]', rendered = '󰌶 Tip', highlight = 'RenderMarkdownSuccess', category = 'github' },
      important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'RenderMarkdownHint', category = 'github' },
      warning = { raw = '[!WARNING]', rendered = '󰀪 Warning', highlight = 'RenderMarkdownWarn', category = 'github' },
      caution = { raw = '[!CAUTION]', rendered = '󰳦 Caution', highlight = 'RenderMarkdownError', category = 'github' },
      -- Obsidian-style callouts
      abstract = { raw = '[!ABSTRACT]', rendered = '󰨸 Abstract', highlight = 'RenderMarkdownInfo', category = 'obsidian' },
      summary = { raw = '[!SUMMARY]', rendered = '󰨸 Summary', highlight = 'RenderMarkdownInfo', category = 'obsidian' },
      tldr = { raw = '[!TLDR]', rendered = '󰨸 TL;DR', highlight = 'RenderMarkdownInfo', category = 'obsidian' },
      info = { raw = '[!INFO]', rendered = '󰋽 Info', highlight = 'RenderMarkdownInfo', category = 'obsidian' },
      todo = { raw = '[!TODO]', rendered = '󰗡 Todo', highlight = 'RenderMarkdownInfo', category = 'obsidian' },
      hint = { raw = '[!HINT]', rendered = '󰌶 Hint', highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
      success = { raw = '[!SUCCESS]', rendered = '󰄬 Success', highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
      check = { raw = '[!CHECK]', rendered = '󰄬 Check', highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
      done = { raw = '[!DONE]', rendered = '󰄬 Done', highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
      question = { raw = '[!QUESTION]', rendered = '󰘥 Question', highlight = 'RenderMarkdownWarn', category = 'obsidian' },
      help = { raw = '[!HELP]', rendered = '󰘥 Help', highlight = 'RenderMarkdownWarn', category = 'obsidian' },
      faq = { raw = '[!FAQ]', rendered = '󰘥 FAQ', highlight = 'RenderMarkdownWarn', category = 'obsidian' },
      attention = { raw = '[!ATTENTION]', rendered = '󰀪 Attention', highlight = 'RenderMarkdownWarn', category = 'obsidian' },
      failure = { raw = '[!FAILURE]', rendered = '󰅖 Failure', highlight = 'RenderMarkdownError', category = 'obsidian' },
      fail = { raw = '[!FAIL]', rendered = '󰅖 Fail', highlight = 'RenderMarkdownError', category = 'obsidian' },
      missing = { raw = '[!MISSING]', rendered = '󰅖 Missing', highlight = 'RenderMarkdownError', category = 'obsidian' },
      danger = { raw = '[!DANGER]', rendered = '󱐌 Danger', highlight = 'RenderMarkdownError', category = 'obsidian' },
      error = { raw = '[!ERROR]', rendered = '󱐌 Error', highlight = 'RenderMarkdownError', category = 'obsidian' },
      bug = { raw = '[!BUG]', rendered = '󰨰 Bug', highlight = 'RenderMarkdownError', category = 'obsidian' },
      example = { raw = '[!EXAMPLE]', rendered = '󰉹 Example', highlight = 'RenderMarkdownHint', category = 'obsidian' },
      quote = { raw = '[!QUOTE]', rendered = '󱆨 Quote', highlight = 'RenderMarkdownQuote1', category = 'obsidian' },
      cite = { raw = '[!CITE]', rendered = '󱆨 Cite', highlight = 'RenderMarkdownQuote1', category = 'obsidian' },
      -- Custom callouts example:
      -- custom_callout = {
      --   raw = '[!CUSTOM]',
      --   rendered = '󰃤 Custom',
      --   highlight = 'RenderMarkdownInfo',
      --   quote_icon = '▋', -- optional: override quote icon
      -- },
    },

    -----------------------------------------------------------------------
    -- Links

    link = {
      -- Enable link rendering
      enabled = true,
      -- Render modes (false = inherit from top-level)
      render_modes = false,
      -- Footnote configuration
      footnote = {
        enabled = true,
        icon = '󰯔 ',
        superscript = true,
        prefix = '',
        suffix = '',
      },
      -- Icon for images
      image = '󰥶 ',
      -- Icon for email links
      email = '󰀓 ',
      -- Icon for hyperlinks
      hyperlink = '󰌹 ',
      -- Highlight group for links
      highlight = 'RenderMarkdownLink',
      -- Highlight group for link titles
      highlight_title = 'RenderMarkdownLinkTitle',
      -- Wiki link configuration
      wiki = {
        icon = '󱗖 ',
        -- Function to transform wiki link body
        body = function() return nil end,
        highlight = 'RenderMarkdownWikiLink',
        scope_highlight = nil,
      },
      -- Custom link icons by URL pattern
      custom = {
        web = { pattern = '^http', icon = '󰖟 ' },
        apple = { pattern = 'apple%.com', icon = ' ' },
        discord = { pattern = 'discord%.com', icon = '󰙯 ' },
        github = { pattern = 'github%.com', icon = '󰊤 ' },
        gitlab = { pattern = 'gitlab%.com', icon = '󰮠 ' },
        google = { pattern = 'google%.com', icon = '󰊭 ' },
        hackernews = { pattern = 'ycombinator%.com', icon = ' ' },
        linkedin = { pattern = 'linkedin%.com', icon = '󰌻 ' },
        microsoft = { pattern = 'microsoft%.com', icon = ' ' },
        neovim = { pattern = 'neovim%.io', icon = ' ' },
        reddit = { pattern = 'reddit%.com', icon = '󰑍 ' },
        slack = { pattern = 'slack%.com', icon = '󰒱 ' },
        stackoverflow = { pattern = 'stackoverflow%.com', icon = '󰓌 ' },
        steam = { pattern = 'steampowered%.com', icon = ' ' },
        twitter = { pattern = 'x%.com', icon = ' ' },
        wikipedia = { pattern = 'wikipedia%.org', icon = '󰖬 ' },
        youtube = { pattern = 'youtube[^.]*%.com', icon = '󰗃 ' },
        youtube_short = { pattern = 'youtu%.be', icon = '󰗃 ' },
      },
    },

    -----------------------------------------------------------------------
    -- Sign Column

    sign = {
      -- Enable sign column icons
      enabled = true,
      -- Highlight group for signs
      highlight = 'RenderMarkdownSign',
    },

    -----------------------------------------------------------------------
    -- Inline Highlight

    inline_highlight = {
      -- Enable inline highlight rendering
      enabled = true,
      -- Render modes (false = inherit from top-level)
      render_modes = false,
      -- Highlight group
      highlight = 'RenderMarkdownInlineHighlight',
      -- Custom inline highlight patterns
      custom = {},
    },

    -----------------------------------------------------------------------
    -- Indent

    indent = {
      -- Enable indent guides
      enabled = false,
      -- Render modes (false = inherit from top-level)
      render_modes = false,
      -- Spaces per indent level
      per_level = 2,
      -- Skip first N indent levels
      skip_level = 1,
      -- Skip indent guides for headings
      skip_heading = false,
      -- Icon for indent guide
      icon = '▎',
      -- Render priority
      priority = 0,
      -- Highlight group
      highlight = 'RenderMarkdownIndent',
    },

    -----------------------------------------------------------------------
    -- Html

    html = {
      -- Enable HTML rendering
      enabled = true,
      -- Render modes (false = inherit from top-level)
      render_modes = false,
      -- HTML comment configuration
      comment = {
        -- Conceal HTML comments
        conceal = true,
        -- Text to show for concealed comments (nil = hide completely)
        text = nil,
        -- Highlight group
        highlight = 'RenderMarkdownHtmlComment',
      },
      -- Custom HTML tag rendering
      tag = {},
    },

    -----------------------------------------------------------------------
    -- Yaml Frontmatter

    yaml = {
      -- Enable YAML frontmatter rendering
      enabled = false,
      -- Render modes (false = inherit from top-level)
      render_modes = false,
    },

    -----------------------------------------------------------------------
    -- Injections

    injections = {
      gitcommit = {
        enabled = true,
        query = [[
          ((message) @injection.content
            (#set! injection.combined)
            (#set! injection.include-children)
            (#set! injection.language "markdown"))
        ]],
      },
    },

    -----------------------------------------------------------------------
    -- Patterns

    patterns = {
      markdown = {
        disable = true,
        directives = {
          { id = 17, name = 'conceal_lines' },
          { id = 18, name = 'conceal_lines' },
        },
      },
    },

    -----------------------------------------------------------------------
    -- Window Options

    win_options = {
      conceallevel = {
        -- Value when not rendering
        default = vim.o.conceallevel,
        -- Value when rendering (3 = fully conceal)
        rendered = 3,
      },
      concealcursor = {
        -- Value when not rendering
        default = vim.o.concealcursor,
        -- Value when rendering ('' = reveal on cursor line)
        rendered = '',
      },
    },

    -----------------------------------------------------------------------
    -- Overrides

    overrides = {
      -- Override for buflisted buffers
      buflisted = {},
      -- Override by buftype
      buftype = {
        nofile = {
          render_modes = true,
          padding = { highlight = 'NormalFloat' },
          sign = { enabled = false },
        },
      },
      -- Override by filetype
      filetype = {},
      -- Override for preview windows
      preview = {
        render_modes = true,
      },
    },

    -----------------------------------------------------------------------
    -- Custom Handlers

    custom_handlers = {},
  },
}
