return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'brenoprata10/nvim-highlight-colors', -- Added to ensure the require below works
  },
  version = '1.*',

  disabled = true, -- disabled for study purpose

  opts = {
    -- 1. Completion Menu / Appearance
    completion = {
      menu = {
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                if ctx.item.source_name == "LSP" then
                  local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr and color_item.abbr ~= "" then
                    icon = color_item.abbr
                  end
                end
                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                local highlight = "BlinkCmpKind" .. ctx.kind
                if ctx.item.source_name == "LSP" then
                  local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr_hl_group then
                    highlight = color_item.abbr_hl_group
                  end
                end
                return highlight
              end,
            },
          },
        },
      },
    },

    -- 2. Keymappings
    keymap = {
      preset = "default",

      -- THE "PRO" TAB LOGIC
      -- 1. If menu is open -> Accept (select_and_accept)
      -- 2. If snippet is active -> Jump to next placeholder (snippet_forward)
      -- 3. Otherwise -> Regular Tab indent (fallback)
      ['<Tab>'] = { 'select_and_accept', 'snippet_forward', 'fallback' },

      -- Shift+Tab to jump backward in snippets
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

      -- Disable Enter to prevent accidental accept
      ['<CR>'] = { 'fallback' },

      -- Standard navigation
      ['<C-n>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    },

    -- 3. Sources (Strict)
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      -- 'copilot' is intentionally excluded here to be handled by copilot.lua
    },

    -- 4. Appearance
    appearance = {
      nerd_font_variant = 'mono'
    },

    -- 5. Fuzzy Matching (Performance)
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },

  opts_extend = { "sources.default" },
}
