-- Auto resize panes when resizing nvim window

local set = vim.opt
local autocmd = vim.api.nvim_create_autocmd

vim.g.mapleader = ","

-- Maximum width of text that is being inserted.
-- A longer line will be broken after white space to get this width.
set.textwidth = 80
set.linebreak = true

autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.md",
	command = "setlocal textwidth=0",
})

-- Display relative line numbers and absolute line number for the current line
set.number = true
set.relativenumber = true

-- Not highlight the screen line of the cursor
set.cursorline = true
set.cursorcolumn = false

-- Always show x lines around cursor
set.scrolloff = 7
set.sidescrolloff = 7

-- Ignore case when searching
set.ignorecase = true
set.smartcase = true

set.sidescroll = 1

-- If this many milliseconds nothing is typed the swap file will be written to disk
-- Also used for the CursorHold autocommand event.
set.updatetime = 100

-- Time in milliseconds to wait for a mapped sequence to complete.
set.timeoutlen = 500
