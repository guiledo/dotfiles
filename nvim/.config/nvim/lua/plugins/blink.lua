return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',
  opts = {
    completion = {
            menu = {
              draw = {
                components = {
                  kind_icon = {
                    text = function(ctx)
                      local icon = ctx.kind_icon
                      if ctx.item.source_name == "LSP" then
                        local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                        if color_item and color_item.abbr ~= "" then
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

    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap

    keymap = {
      preset = 'default',
      -- CRITICAL OVERRIDE:
      -- Force <CR> (Enter) to fallback to default behavior (insert newline)
      -- instead of accepting the completion.
      ["<CR>"] = { "fallback" },

      -- Explicitly ensure C-y accepts (redundant with preset, but safe)
      ["<C-y>"] = { "select_and_accept" },

      -- Optional: Map Tab to strictly navigate snippets or fallback
      -- This prevents Tab from "accidentally" accepting completions
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" },
}
