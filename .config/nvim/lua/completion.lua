local set = vim.opt
local use = require('packer').use

-- wild menu options
set.wildmode = 'list:longest:full'
-- ignore compiled files in wild menu
set.wildignore = '*.o,*~,*.pyc'

set.completeopt = {'menu', 'menuone', 'noselect'}

vim.diagnostic.config({
  signs = true,
  underline = true,
  virtual_text = {
    source = false,
    prefix = '-',
  },
  float = {
    style = "minimal",
    border = "single",
    source = "always",
    focusable = true,
    header = "",
  },
  severity_sort = true,
  update_in_insert = true,
})

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>ap', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>an', vim.diagnostic.goto_next)

use {
  "b0o/schemastore.nvim",

  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-emoji',
  'ray-x/cmp-treesitter',
  'hrsh7th/cmp-nvim-lua',
  'petertriho/cmp-git',
  'onsails/lspkind.nvim',

  'RRethy/vim-illuminate',

  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',

  'j-hui/fidget.nvim',

  {
    'RishabhRD/lspactions',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim'
    }
  },

  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',

  {
    'neovim/nvim-lspconfig',
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        automatic_installation = true,
      }

      require('fidget').setup {}
      local lspconfig = require("lspconfig")

      require('illuminate').configure({
        delay = 50
      })

      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
        'force',
        lspconfig.util.default_config,
        capabilities
      )

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        {border = 'rounded'}
      )

      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        {border = 'rounded'}
      )

      local lspactions = require'lspactions'
      vim.ui.select = lspactions.select
      vim.ui.input = lspactions.input

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(args)
          -- hide diagnostic for Helm file
          if vim.bo[args.buf].buftype ~= "" or vim.bo[args.buf].filetype == "helm" then
            vim.diagnostic.disable(args.buf)
            vim.defer_fn(function()
              vim.diagnostic.reset(nil, args.buf)
            end, 1000)
          end

          local opts = { buffer = true, noremap = true }

          vim.keymap.set('', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('', 'gt', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('', 'gi', vim.lsp.buf.implementation, opts)

          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

          vim.keymap.set('', '<leader>rn', lspactions.rename, opts)

          vim.keymap.set('n', '<leader>a', lspactions.code_action, opts)
          vim.keymap.set('v', '<leader>a', lspactions.range_code_action, opts)

          vim.keymap.set('', '<leader>fo', vim.lsp.buf.formatting, opts)
        end
      })

      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
              -- Setup your lua path
              path = runtime_path,
            },
            diagnostics = {
              globals = {'vim'},
            },
            workspace = {
              preloadFileSize = 1000,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
            completion = {
              keywordSnippet="Replace",
              callSnippet="Replace"
            },
          }
        }
      }

      lspconfig.jsonls.setup {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
          },
        },
      }

      lspconfig.tsserver.setup {
        settings = {
          completions = {
            completeFunctionCalls = true
          },
        }
      }

      lspconfig.eslint.setup {
        settings = {
          codeAction = {
            disableRuleComment = {
              enable = true,
              location = "separateLine"
            },
            showDocumentation = {
              enable = true
            }
          },
          codeActionOnSave = {
            enable = true,
            mode = "all"
          },
          format = true,
          run = "onType",
          validate = "on",
          workingDirectory = {
            mode = 'location'
          }
        },
        root_dir = require('lspconfig.util').find_git_ancestor,
      }

      lspconfig.html.setup {}

      lspconfig.cssls.setup {}

      lspconfig.bashls.setup {}

      lspconfig.dockerls.setup {}

      lspconfig.yamlls.setup {
        filetypes = { "yaml" }
      }

      lspconfig.vimls.setup {}

      lspconfig.terraformls.setup {}

      local lspkind = require('lspkind')

      local luasnip = require 'luasnip'
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
      luasnip.filetype_set("javascriptreact", { "javascript" })
      luasnip.filetype_set("typescript", { "javascript" })
      luasnip.filetype_set("typescriptreact", { "javascriptreact" })

      local cmp = require 'cmp'

      cmp.setup {
        sources = {
          { name = "path", priority = 100 },
          {
            name = 'luasnip',
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
          fields = {'menu', 'abbr', 'kind'},
          format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
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

        window = {
          documentation = cmp.config.window.bordered()
        },
      }

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
    end
  }
}
