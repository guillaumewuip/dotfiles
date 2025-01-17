-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map("n", "<leader>ln", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle relative line number", expr = true, silent = true })

map("n", "<leader>lh", function()
  local lineHighlight = vim.api.nvim_exec("hi CursorLine", true)

  if string.match(lineHighlight, "cleared") then
    vim.cmd([[
       hi CursorLine guibg=#20282e
     ]])
  else
    vim.cmd([[
       hi clear CursorLine
     ]])
  end
end, { desc = "Toggle cursorline highlight", expr = true, silent = true })

map("n", "q", "<cmd>bdelete<cr>", { desc = "Close buffer" })

map(
  "n",
  "=",
  LazyVim.pick("files", { root = false, layout = {
    preset = "custom",
    reverse = false,
  }, hidden = true }),
  { desc = "Find Files (cwd)" }
)

map(
  "n",
  "+",
  LazyVim.pick("live_grep", { root = false, layout = {
    preset = "custom",
    reverse = false,
  }, hidden = true }),
  { desc = "Grep (cwd)" }
)
