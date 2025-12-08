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
    config = function()
      local oil = require("oil")
      oil.setup({
        show_hidden = true,
        default_file_explorer = true,
    })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil",
        callback = function()
          vim.opt_local.number = true         -- show absolute number
          vim.opt_local.relativenumber = true -- enable relative numbers
        end,
      })
    end
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

