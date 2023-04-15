local set = vim.opt
local use = require('packer').use

use {
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
}

vim.keymap.set('n', "!", "<cmd>Git<CR>", { noremap = true, silent = true })

vim.cmd([[
  aug FugitiveCustom
    au!
    au User FugitiveIndex nmap <buffer> pp :Git push<CR>
    au User FugitiveIndex nmap <buffer> pf :Git push --force-with-lease<CR>

    au User FugitiveIndex nmap <buffer> <esc> :bwipeout<CR>
  aug end
]])

vim.keymap.set('n', '<leader>b', ':GBrowse<CR>')
vim.keymap.set('v', '<leader>b', ":'<,'>GBrowse<CR>")

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

vim.keymap.set('n', "gl", "<cmd>diffget //3<CR>")
vim.keymap.set('n', "gh", "<cmd>diffget //2<CR>")
