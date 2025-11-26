return {
  "brenoprata10/nvim-highlight-colors",
  lazy = false, -- Load immediately so it works on startup
  opts = {
    --- @usage 'background'|'foreground'|'virtual'
    render = "background",
    enable_named_colors = true, -- Adds support for "red", "blue", etc.
    enable_tailwind = true,     -- Adds support for "bg-blue-500"
    enable_ansi = true,
    enable_rgb = true,
    enable_rex = true,
    enable_short_hex = true,
  },
}
