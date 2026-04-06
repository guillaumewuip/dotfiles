-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map("n", "<leader>ln", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle relative line number", silent = true })

map("n", "<leader>lh", function()
  vim.opt.cursorline = not vim.opt.cursorline:get()
end, { desc = "Toggle cursorline highlight", silent = true })

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
