local map = vim.keymap.set
local del = vim.keymap.del

del("i", "<C-b>")
del("i", "<C-e>")

del("n", "<leader>n")
del("n", "<leader>rn")
del("n", "<leader>b")
del("n", "<tab>")
--del("n", "<S-tab>")
--del("n", "<leader-x>")
--del("n", "<leader>-D")
--del("n", "<leader>ls")
--del("n", "<leader>ra")
--del("n", "<leader>ca")
del("n", "[d")
del("n", "]d")
--del("n", "<leader>wa")
--del("n", "<leader>wr")
--del("n", "<leader>wl")
del("n", "<C-n>")
del("n", "<leader>e")

--del("v", "<C-k>")
--del("v", "<C-j>")

map("n", ";", ":", { desc = "enter command mode", nowait = true })

map("n", "<C-k>", ":MoveLine(-1)<CR>", { desc = "Move line up", nowait = true, noremap = true, silent = true })
map("n", "<C-j>", ":MoveLine(1)<CR>", { desc = "Move line down", nowait = true, noremap = true, silent = true })

map("n", "-", ":RnvimrToggle<cr>", { desc = "Open Ranger", nowait = true })
map("n", "<C-z>", "<C-x>", { desc = "Decrement number" })

map("n", "<leader>b", function()
  require("gitlinker").get_buf_range_url("n", { action_callback = require("gitlinker.actions").open_in_browser })
end, { desc = "Open repository url", silent = true })

map("n", "L", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle relative line number" })

map("n", "H", function()
  local lineHighlight = vim.api.nvim_exec("hi CursorLine", true)

  if string.match(lineHighlight, "cleared") then
    vim.cmd [[
       hi CursorLine guibg=#20282e
     ]]
  else
    vim.cmd [[
       hi clear CursorLine
     ]]
  end
end, { desc = "Toggle cursorline highlight" })

map("n", "<leader>l", ":diffget //3<CR>", { desc = "Choose right git diff" })
map("n", "<leader>h", ":diffget //2<CR>", { desc = "Choose left git diff" })

map("n", "<C-l>", ":BufferNext<CR>", { desc = "Goto next buffer", nowait = true })
map("n", "<C-h>", ":BufferPrevious<CR>", { desc = "Goto prev buffer", nowait = true })
map("n", "<C-x>", ":BufferWipeout<CR>", { desc = "Close buffer", nowait = true })

map("n", "<C-o>", ":BufferMoveNext<CR>", { desc = "Goto next buffer", nowait = true })
map("n", "<C-y>", ":BufferMovePrevious<CR>", { desc = "Goto prev buffer", nowait = true })

map("n", "+", function()
  require("telescope.builtin").find_files {
    hidden = true,
    no_ignore = false,
    no_ignore_parent = false,
  }
end, { desc = "Open Telescope find_files (hidden=true, no_ignore=false)" })

map("n", "<leader>+", function()
  require("telescope.builtin").find_files {
    hidden = true,
    no_ignore = true,
    no_ignore_parent = true,
  }
end, { desc = "Open Telescope find_files (hidden=true, no_ignore=true)" })

map("n", "<leader>@", function()
  require("telescope.builtin").buffers()
end, { desc = "Open Telescope buffers" })

map("n", "<leader>!", function()
  require("telescope.builtin").git_status()
end, { desc = "Open Telescope find_files" })

map("n", "<leader>f", function()
  require("telescope").extensions.live_grep_args.live_grep_args()
end, { desc = "Open Telescope find_files", nowait = true })

map("n", "<leader>g", function()
  require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = "Open Spectre Search/Replace" })

map(
  "n",
  "n",
  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
  { desc = "Go to next search match" }
)

map(
  "n",
  "N",
  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
  { desc = "Go to next search match" }
)

map("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], { desc = "Search word under cursor in file (forward)" })

map("n", "#", [[*<Cmd>lua require('hlslens').start()<CR>]], { desc = "Search word under cursor in file (backward)" })

map(
  "n",
  "g*",
  [[*<Cmd>lua require('hlslens').start()<CR>]],
  { desc = "Search whole file for word (inclusive those where it is only part of too) (forward)" }
)

map(
  "n",
  "g#",
  [[*<Cmd>lua require('hlslens').start()<CR>]],
  { desc = "Search whole file for word (inclusive those where it is only part of too) (backward)" }
)

map(
  "n",
  "<leader><Enter>",
  "<Cmd>noh<CR>",
  { desc = "Search whole file for word (inclusive those where it is only part of too) (backward)" }
)

map("n", "zR", function()
  require("ufo").openAllFolds()
end, { desc = "Open all folds" })

map("n", "zM", function()
  require("ufo").openAllFolds()
end, { desc = "Close all folds" })

map("v", "<C-k>", ":MoveBlock(-1)<CR>", { desc = "Move block up", nowait = true, noremap = true, silent = true })
map("v", "<C-j>", ":MoveBlock(1)<CR>", { desc = "Move block down", nowait = true, noremap = true, silent = true })

map("v", "<leader>b", function()
  require("gitlinker").get_buf_range_url("v", { action_callback = require("gitlinker.actions").open_in_browser })
end, { desc = "Open repository url" })

map("v", "<leader>f", function()
  require("telescope-live-grep-args.shortcuts").grep_visual_selection()
end, { desc = "Search in files" })

map("v", "<leader>g", function()
  require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
end, { desc = "Open Search/Replace" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function()
    map("n", "gt", function()
      vim.lsp.buf.type_definition()
    end, { desc = "LSP definition type" })

    map("n", "gs", function()
      vim.lsp.buf.signature_help()
    end, { desc = "LSP signature help" })

    map("n", "<leader>rn", function()
      require "nvchad.lsp.renamer" ()
    end, { desc = "LSP rename" })

    map("n", "<leader>a", function()
      vim.lsp.buf.code_action()
    end, { desc = "LSP code action" })

    map("n", "<leader>ap", function()
      vim.diagnostic.goto_prev { float = { border = "rounded" } }
    end, { desc = "Goto prev" })

    map("n", "<leader>an", function()
      vim.diagnostic.goto_next { float = { border = "rounded" } }
    end, { desc = "Goto next" })

    map("n", "F", function()
      vim.diagnostic.open_float { border = "rounded" }
    end, { desc = "Floating diagnostic" })
  end,
})
