return {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    -- Tamanho padrão para split horizontal (altura) ou split vertical (largura)
    size = 10,
    -- Direção padrão para uma nova instância de terminal aberta com :ToggleTerm
    direction = 'horizontal',
    config = function()
      require("toggleterm").setup({
        start_in_insert = true,
      })
    end

  },
}
