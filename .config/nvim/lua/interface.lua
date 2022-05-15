local set = vim.opt
local cmd = vim.cmd

-- always show current position
set.ruler = true

-- height of the command bar
set.cmdheight = 2

-- always show signcolumns
set.signcolumn = 'yes'

-- Show matching brackets when text indicator is over them
set.showmatch = true
-- How many tenths of a second to blink when matching brackets
set.matchtime = 2

-- Display relative line numbers and absolute line number for the current line
set.number = true

-- Not highlight the screen line of the cursor
set.cursorline = false
set.cursorcolumn = false
-- Highlight the screen line of the cursor with H
vim.keymap.set('n', 'H', ':set cursorline!')

-- Always show x lines around cursor
set.scrolloff = 7
set.sidescrolloff = 7
set.sidescroll = 1

-- add 80 caracter column
set.colorcolumn = '80'

-- treat long lines as break lines (useful when moving around in them)
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

vim.keymap.set('', '<ScrollWheelUp>', 'k')
vim.keymap.set('', '<ScrollWheelDown>', 'j')

vim.cmd('colorscheme desert')

set.background = 'dark'

cmd[[highlight CursorLine cterm=NONE ctermbg=236]]

cmd[[highlight Search cterm=NONE ctermfg=15 ctermbg=172]]
cmd[[highlight CocHighlightText ctermfg=15 ctermbg=136]]
cmd[[highlight CocHighlightRead ctermfg=15 ctermbg=136]]
cmd[[highlight CocHighlightWrite ctermfg=15 ctermbg=136]]

cmd[[highlight Pmenu       cterm=NONE ctermfg=255 ctermbg=236]]
cmd[[highlight PmenuSel    cterm=NONE ctermfg=15 ctermbg=240]]
cmd[[highlight CocFloating cterm=NONE ctermfg=255 ctermbg=236]]

cmd[[highlight TabLine                     cterm=NONE ctermfg=255 ctermbg=236]]
cmd[[highlight TabLineCell                 cterm=NONE ctermfg=255 ctermbg=236]]
cmd[[highlight TabLineCellSelected         cterm=NONE ctermfg=15 ctermbg=172]]
cmd[[highlight TabLineCellModified         cterm=NONE ctermfg=255 ctermbg=244]]
cmd[[highlight TabLineCellSelectedModified cterm=NONE ctermfg=15 ctermbg=160]]
cmd[[highlight FloatermBorder              ctermfg=black]]

cmd[[highlight clear SignColumn]]

-- move among buffers
vim.keymap.set('', '<C-L>', ':bnext<CR>')
vim.keymap.set('', '<C-H>', ':bprev<CR>')
-- close buffer
vim.keymap.set('', '<C-X>', ':bd<CR>')

-- Specify the behavior when switching between buffers
set.switchbuf = 'useopen'

-- open file under cursor in new tab
vim.keymap.set('n', 't', '<c-w>gf', { noremap = true })
