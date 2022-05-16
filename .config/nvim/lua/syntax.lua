local set = vim.opt
local cmd = vim.cmd
local use = require('packer').use

use {
  'preservim/vim-markdown',
  requires = {
    { 'godlygeek/tabular' }
  },
  config = function()
    vim.g.vim_markdown_folding_disabled = 1
    vim.g.vim_markdown_conceal = 0
  end
}

use 'GutenYe/json5.vim'

cmd[[
  au BufRead,BufNewFile *.scss set filetype=scss
  au BufEnter *.scss :syntax sync fromstart
]]

use 'pangloss/vim-javascript'
use 'leafgarland/typescript-vim'
use 'ianks/vim-tsx'
use 'jxnblk/vim-mdx-js'
