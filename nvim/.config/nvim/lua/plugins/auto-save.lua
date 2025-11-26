return {
  "okuuva/auto-save.nvim",
  cmd = "ASToggle",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    enabled = true,

    -- AJUSTE FINAL: Usando notify para vencer o Noice
    callbacks = {
      after_saving = function()
        -- O nível INFO garante que o Noice mostre a mensagem
        -- O 'title' vazio tenta minimizar o tamanho
        vim.notify("Salvo " .. vim.fn.strftime("%H:%M:%S"), vim.log.levels.INFO, { title = "" })
      end,
    },

    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost" },
      defer_save = { "InsertLeave", "TextChanged" },
      cancel_deferred_save = { "InsertEnter" },
    },

    condition = function(buf)
      local fn = vim.fn
      local api = vim.api

      local filename = api.nvim_buf_get_name(buf)
      local filetype = fn.getbufvar(buf, "&filetype")

      if fn.getbufvar(buf, "&modifiable") ~= 1 then
        return false
      end

      local ignore_filetypes = { "neo-tree", "harpoon", "TelescopePrompt", "notify", "dashboard", "lazy", "noice" }
      if vim.tbl_contains(ignore_filetypes, filetype) then
        return false
      end

      local line_count = api.nvim_buf_line_count(buf)
      if line_count == 1 and api.nvim_buf_get_lines(buf, 0, 1, false)[1] == "" then
        return false
      end

      if filename:lower():match("test") or filename:lower():match("temp") or filename:lower():match("scratch") then
        return false
      end

      return true
    end,
    write_all_buffers = false,
    debounce_delay = 1000,
  },
}
