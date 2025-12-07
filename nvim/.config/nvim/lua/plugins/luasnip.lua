return {
  "L3MON4D3/LuaSnip",
  config = function(_, opts)
    require("luasnip").setup(opts)
    -- Load snippets from ~/.config/nvim/lua/snippets/
    -- This looks for files named after the filetype (e.g., html.lua, python.lua)
    require("luasnip.loaders.from_lua").load({ paths = { "./lua/snippets" },
    default_priority = 2000,
    })
  end,
}
