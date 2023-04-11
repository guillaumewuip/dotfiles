local set = vim.opt
local use = require('packer').use

use {
  'tpope/vim-fugitive',
  config = function ()
  end
}

use {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup {
      signs = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '-' },
        topdelete    = { text = '-' },
        changedelete = { text = '~' },
        untracked    = { text = '?' },
      },
      current_line_blame = true,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local opts = { buffer = bufnr }

        vim.keymap.set('n', '}', function()
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { buffer = bufnr, expr=true })

        vim.keymap.set('n', '{', function()
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { buffer = bufnr, expr=true })

        vim.keymap.set({'n', 'v'}, '<leader>ga', ':Gitsigns stage_hunk<CR>', opts)
        vim.keymap.set('n', '<leader>gA', gs.stage_buffer, opts)
        vim.keymap.set('n', '<leader>gu', gs.undo_stage_hunk, opts)

        vim.keymap.set({'n', 'v'}, '<leader>gr', ':Gitsigns reset_hunk<CR>', opts)
        vim.keymap.set('n', '<leader>gR', gs.reset_buffer, opts)

        vim.keymap.set('n', '<leader>gb', function() gs.blame_line({ full = true }) end, opts)

        vim.keymap.set('n', '<leader>gd', gs.diffthis, opts)
        vim.keymap.set('n', '<leader>gD', function () gs.diffthis("~") end, opts)
      end
    }
  end
}

use {
  'ruifm/gitlinker.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require("gitlinker").setup{
      mappings = nil
    }

    vim.keymap.set('n', '<leader>b', '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', {silent = true})
    vim.keymap.set('v', '<leader>b', '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', {})
  end
}

