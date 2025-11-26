return {
  {"stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  {
    "refractalize/oil-git-status.nvim",

    dependencies = {
      "stevearc/oil.nvim",
    },

    config = function ()
      require("oil").setup({
        win_options = {
        signcolumn = "yes:2",
        },
      })
    end,
  },
  {
    "JezerM/oil-lsp-diagnostics.nvim",
    dependencies = { "stevearc/oil.nvim" },
    opts = {},
  }
}

