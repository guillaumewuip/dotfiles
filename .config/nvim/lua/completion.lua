local set = vim.opt
local use = require('packer').use

-- wild menu options
set.wildmode = 'list:longest:full'
-- ignore compiled files in wild menu
set.wildignore = '*.o,*~,*.pyc'

set.completeopt = {'menu', 'menuone', 'noselect'}

local hover = function()
  local float_opts = {
    focusable = false,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    border = "solid",
    source = "always", -- show source in diagnostic popup window
    prefix = '- ',
    header = "",
  }

  if not vim.b.diagnostics_pos then
    vim.b.diagnostics_pos = { nil, nil }
  end

  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  if (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2]) and #vim.diagnostic.get() > 0
  then
    vim.diagnostic.open_float(nil, float_opts)
  end

  vim.b.diagnostics_pos = cursor_pos
end

-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  pattern = "*",
  callback = hover,
})

use 'b0o/schemastore.nvim'

use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  requires = {
    {'neovim/nvim-lspconfig'},
    {
      'williamboman/mason.nvim',
      run = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'},
    {'onsails/lspkind.nvim'},
    {'RRethy/vim-illuminate'},
    {'j-hui/fidget.nvim'},
    {
      'RishabhRD/lspactions',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-lua/popup.nvim'
      }
    },

    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-cmdline'},
    {'hrsh7th/cmp-emoji'},
    {'ray-x/cmp-treesitter'},
    {'hrsh7th/cmp-nvim-lua'},
    {'hrsh7th/cmp-nvim-lsp-signature-help'},
    {'petertriho/cmp-git'},
    {'saadparwaiz1/cmp_luasnip'},
    {'L3MON4D3/LuaSnip'},

  },
  config = function()
    require('fidget').setup {}

    require('illuminate').configure({
      delay = 50
    })

    local lsp = require('lsp-zero').preset({
      float_border = 'solid',
      call_servers = 'local',
      configure_diagnostics = false,
      setup_servers_on_start = true,
      set_lsp_keymaps = { -- remove ?
        preserve_mappings = false,
        omit = {},
      },
      manage_nvim_cmp = {
        set_sources = false,
        set_basic_mappings = false,
        set_extra_mappings = false,
        use_luasnip = false,
        set_format = false,
        documentation_window = true,
      },
    })

    lsp.on_attach(function(client, bufnr)
      local lspactions = require'lspactions'
      vim.ui.select = lspactions.select
      vim.ui.input = lspactions.input

      local opts = { buffer = bufnr }

      vim.keymap.set('', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('', 'gt', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('', 'gs', vim.lsp.buf.signature_help, opts)

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

      vim.keymap.set('', '<leader>rn', vim.lsp.buf.rename, opts)

      vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
      vim.keymap.set('v', '<leader>a', vim.lsp.buf.range_code_action, opts)

      vim.keymap.set('', '<leader>fo', vim.lsp.buf.format, opts)

      vim.keymap.set('n', '<leader>ap', vim.diagnostic.goto_prev)
      vim.keymap.set('n', '<leader>an', vim.diagnostic.goto_next)
    end)

    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

    local cmp = require('cmp')

    local luasnip = require 'luasnip'
    require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })
    luasnip.filetype_set("javascriptreact", { "javascript" })
    luasnip.filetype_set("typescript", { "javascript" })
    luasnip.filetype_set("typescriptreact", { "javascriptreact" })

    local lspkind = require('lspkind')

    cmp.setup({
      preselect = 'item',
      sources = {
        { name = "path",    priority = 100 },
        {
          name = 'luasnip',
          priority = 100,
          keyword_length = 1,
        },
        {
          name = 'nvim_lsp_signature_help',
          priority = 100,
          keyword_length = 1,
        },

        {
          name = "nvim_lsp",
          priority = 90
        },
        {
          name = "treesitter",
          keyword_length = 3,
          priority = 80,
        },
        {
          name = "buffer",
          keyword_length = 3,
          priority = 70,
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end
          }
        },
        { name = "emoji" },
        { name = 'nvim_lua' }
      },

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      formatting = {
        fields = { 'menu', 'abbr', 'kind' },
        format = lspkind.cmp_format({
          mode = 'symbol_text',   -- show only symbol annotations
          maxwidth = 50,          -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        })
      },

      mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
    })

    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'cmp_git' },
      }, {
        { name = 'buffer' },
      })
    })

    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })

    vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
    vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
    vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>luasnip-previous-choice", {})
    vim.api.nvim_set_keymap("s", "<C-p>", "<Plug>luasnip-previous-choice", {})

    lsp.setup()

    vim.diagnostic.config({
      signs = true,
      underline = true,
      virtual_text = {
        source = false,
        spacing = 2,
        prefix = '-',
      },
      severity_sort = true,
      update_in_insert = true,
    })
  end
}
