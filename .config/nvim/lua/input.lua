local set = vim.opt
local use = require('packer').use

-- Allow vim clipboad <-> host clipboard to share data
-- @see https://ploegert.gitbook.io/til/tools/vim/allow-neovim-to-copy-paste-with-system-clipboard
-- don't know why not working with set.clipboard
vim.cmd [[
  set clipboard=unnamedplus
]]

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

-- decrement number with ctrl+z
vim.keymap.set('n', '<C-z>', '<C-x>')

-- highlight the region that just yanked
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

use {
  'windwp/nvim-ts-autotag',
  'andymass/vim-matchup',
  'tree-sitter/tree-sitter-embedded-template',
  'nvim-treesitter/nvim-treesitter-context',
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      auto_install = true,
      ignore_install = {},
      ensure_installed = {
        'css',
        'bash',
        'comment',
        'diff',
        'dockerfile',
        'embedded_template',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'help',
        'html',
        'javascript',
        'jq',
        'jsdoc',
        'json',
        'json5',
        'markdown',
        'markdown_inline',
        'php',
        'phpdoc',
        'regex',
        'scss',
        'terraform',
        'tsx',
        'twig',
        'typescript',
        'vim',
      },
      sync_install = true,
      autotag = {
        enable = true,
      },
      matchup = {
        enable = true
      },
      highlight = {
        enable = true, -- false will disable the whole extension
      },
      indent = {
        enable = true
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 'gnn',
          node_incremental = 'grn',
          scope_incremental = 'grc',
          node_decremental = 'grm',
        },
      },
    }
  end
}

use {
  'ntpeters/vim-better-whitespace',
  config = function()
    vim.g.strip_whitespace_on_save = 1
    vim.g.strip_whitespace_confirm = 0
  end
}

use {
  'preservim/nerdcommenter',
  config = function ()
    vim.g.NERDSpaceDelims = true
    vim.g.NERDCommentEmptyLines = true
  end
}

-- auto open/close parentheses and stuff
use {
  'windwp/nvim-autopairs',
  rpt = 'lua', -- need to go inside the lua/ dir
  config = function()
    require('nvim-autopairs').setup({
      check_ts = true,
      fast_wrap = false,
    })
  end
}

use 'machakann/vim-sandwich'

use {
  "lukas-reineke/indent-blankline.nvim",

  setup = function ()
    vim.opt.list = true
  end,

  after = "nvim-treesitter",

  config = function ()
    require("indent_blankline").setup {
      show_current_context = true,
      space_char_blankline = ' ',
    }
  end
}
