-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local set = vim.keymap.set

-- Normal Mode (Move single line)
-- Uses '.' to reference current line
set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move Line Down" })
set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move Line Up" })

-- Visual Mode (Move selected block)
-- Uses '> (end of selection) and '< (start of selection)
-- 'gv' reselects the block after moving so you can keep moving it
set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move Block Down" })
set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move Block Up" })

-- Basic movement keybinds, these make navigating splits easy for me
set("n", "<c-j>", "<c-w><c-j>")
set("n", "<c-k>", "<c-w><c-k>")
set("n", "<c-l>", "<c-w><c-l>")
set("n", "<c-h>", "<c-w><c-h>")

set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

-- Toggle hlsearch if it's on, otherwise just do "enter"
set("n", "<CR>", function()
  ---@diagnostic disable-next-line: undefined-field
  if vim.opt.hlsearch:get() then
    vim.cmd.nohl()
    return ""
  else
    return "<CR>"
  end
end, { expr = true })

-- These mappings control the size of splits (height/width)
set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-t>", "<C-W>+")
set("n", "<M-s>", "<C-W>-")

set("n", "<M-j>", function()
  if vim.opt.diff:get() then
    vim.cmd [[normal! ]c]]
  else
    vim.cmd [[m .+1<CR>==]]
  end
end)

set("n", "<M-k>", function()
  if vim.opt.diff:get() then
    vim.cmd [[normal! [c]]
  else
    vim.cmd [[m .-2<CR>==]]
  end
end)

-- ToggleTerm
set("n", "<leader>ft", "<cmd>ToggleTerm<CR><cmd>startinsert<CR>", {
      noremap = true,
      silent = true,
      desc = "Open ToggleTerm in Terminal Mode"
   })

set("t", "<Esc><Esc>", "<C-\\><C-n>:bdelete!<CR>",
  { desc = "Exit terminal mode and close window" })

