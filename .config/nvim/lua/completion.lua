local set = vim.opt
local use = require('packer').use

-- wild menu options
set.wildmode = 'list:longest:full'
-- ignore compiled files in wild menu
set.wildignore = '*.o,*~,*.pyc'

use "b0o/schemastore.nvim"

-- require('lspconfig').jsonls.setup {
--   settings = {
--     json = {
--       schemas = require('schemastore').json.schemas(),
--     },
--   },
-- }
