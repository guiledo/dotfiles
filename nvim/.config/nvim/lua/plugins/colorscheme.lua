return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
  },
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    opts = {
      --transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  }
}
