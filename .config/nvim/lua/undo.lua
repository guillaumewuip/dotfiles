local use = require('packer').use

use {
  'simnalamburt/vim-mundo',
  config = function()
    vim.keymap.set('', '&', ":MundoToggle<CR>", { noremap = true })

    vim.g.mundo_width = 60
    vim.g.mundo_preview_height = 30
    vim.g.mundo_right = 1
  end
}

