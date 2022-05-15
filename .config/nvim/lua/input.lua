local set = vim.opt

-- Allow vim clipboad <-> host clipboard to share data
-- @see https://ploegert.gitbook.io/til/tools/vim/allow-neovim-to-copy-paste-with-system-clipboard
set.clipboard = unnamedplus

set.mouse = a

-- Maximum width of text that is being inserted.
-- A longer line will be broken after white space to get this width.
set.textwidth = 80
set.linebreak = true

-- Use spaces instead of tabs
set.expandtab = true

-- 1 tab == 2 spaces
set.shiftwidth = 2
set.tabstop = 2
set.softtabstop = 2

set.smartindent = true

set.foldmethod = 'syntax'
set.foldlevelstart = 99
set.foldcolumn = '0'

-- decrement number with ctrl+z
vim.keymap.set('n', '<C-z>', '<C-x>')

-- Move a line of text using Ctrl+[jk]
-- Normal mode
vim.keymap.set('n', '<C-j>', ":m .+1<CR>==", { noremap = true})
vim.keymap.set('n', '<C-k>', ":m .-2<CR>==", { noremap = true})
-- Insert mode
vim.keymap.set('i', '<C-j>', "<ESC>:m .+1<CR>==gi", { noremap = true})
vim.keymap.set('i', '<C-k>', "<ESC>:m .-2<CR>==gi", { noremap = true})
-- Visual mode
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { noremap = true})
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv", { noremap = true})
