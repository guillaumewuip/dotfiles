local set = vim.opt
local use = require('packer').use

-- Ignore case when searching
set.ignorecase = true

-- Disable highlight
vim.keymap.set('n', '<leader><cr>', ':noh<cr>', { silent = true })

-- next search result
vim.keymap.set('', '<leader>n', ':cn<cr>')
-- prev search result
vim.keymap.set('', '<leader>p', ':cp<cr>')

use {
  'nvim-telescope/telescope.nvim',
  requires = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    { 'nvim-treesitter/nvim-treesitter', cmd = 'TSUpdate' },
    { 'kyazdani42/nvim-web-devicons' },
    { 'xiyaowong/telescope-emoji.nvim' },
  },
  config = function()
    require("telescope").load_extension("emoji")
    require('telescope').setup {
      layout_strategy = 'flex',
      layout_config = {
        prompt_position = "top"
      },
      defaults = {
        sorting_strategy = "ascending",
      }
    }

    vim.keymap.set('', ')', require('telescope.builtin').buffers)
    vim.keymap.set('', '+', require('telescope.builtin').git_files)
    vim.keymap.set('', '=', require('telescope.builtin').find_files)
    vim.keymap.set('', '<Leader>g', require('telescope.builtin').live_grep)
    vim.keymap.set('', '!', require('telescope.builtin').git_status)
  end
}

use {
  'windwp/nvim-spectre',
  requires = {
    { 'nvim-lua/plenary.nvim' },
  },
  config = function()
    require('telescope').setup{}

    vim.keymap.set('n', '<Leader>G', require('spectre').open)
    vim.keymap.set('v', '<Leader>G', function()
      require('spectre').open_visual({ select_word = true })
    end)
  end
}

