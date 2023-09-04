---@type NvPluginSpec[]
local plugins = {
	{
		"NvChad/nvterm",
		enabled = false,
	},

	{
		"nvim-tree/nvim-tree.lua",
		enabled = false,
	},

	{
		"rafamadriz/friendly-snippets",
		enabled = false,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					local null_ls = require("null-ls")

					local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

					null_ls.setup({
						sources = {
							null_ls.builtins.code_actions.eslint_d,
							null_ls.builtins.diagnostics.eslint_d,
							null_ls.builtins.formatting.eslint_d,

							null_ls.builtins.formatting.stylua,
						},

						on_attach = function(client, bufnr)
							if client.supports_method("textDocument/formatting") then
								vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
								vim.api.nvim_create_autocmd("BufWritePre", {
									group = augroup,
									buffer = bufnr,
									callback = function()
										-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
										-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
										vim.lsp.buf.format({ async = false })
									end,
								})
							end
						end,
					})
				end,
			},

			"b0o/schemastore.nvim",

			{
				"williamboman/mason.nvim",
				opts = {
					ensure_installed = {
						"lua-language-server",
						"typescript-language-server",
						"bash-language-server",
						"css-lsp",
						"dockerfile-language-server",
						"eslint-lsp",
						"eslint_d",
						"html-lsp",
						"json-lsp",
						"stylua",
						"terraform-ls",
						"vim-language-server",
						"yaml-language-server",
						"helm-ls",
					},
				},
			},

			{
				"RishabhRD/lspactions",
				dependencies = {
					"nvim-lua/popup.nvim",
				},
			},

			{
				"kevinhwang91/nvim-ufo",
				event = "BufReadPost",
				dependencies = {
					"kevinhwang91/promise-async",
				},
			},
		},
		config = function()
			require("plugins.configs.lspconfig")

			local configs = require("plugins.configs.lspconfig")

			local on_attach = configs.on_attach
			local capabilities = configs.capabilities
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			vim.o.foldcolumn = "0" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			local lspconfig = require("lspconfig")

			local servers = {
				"html",
				"cssls",
				"tsserver",
				"lua_ls",
				"dockerls",
				"jsonls",
				"html",
				"bashls",
				"terraformls",
				"vimls",
				"yamlls",
				"helm_ls",
			}

			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end

			require("ufo").setup()

			local lspactions = require("lspactions")
			vim.ui.select = lspactions.select
			vim.ui.input = lspactions.input
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				version = "1.*",
				build = "make install_jsregexp",
				config = function(_, opts)
					require("plugins.configs.others").luasnip(opts)

					require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim.d/snippets" })

					local luasnip = require("luasnip")
					luasnip.filetype_set("javascriptreact", { "javascript" })
					luasnip.filetype_set("typescript", { "javascript" })
					luasnip.filetype_set("typescriptreact", { "javascript" })
				end,
			},

			"hrsh7th/cmp-nvim-lsp-signature-help",
			"petertriho/cmp-git",
			"ray-x/cmp-treesitter",
			"hrsh7th/cmp-emoji",
			-- "zbirenbaum/copilot.lua",
			-- "zbirenbaum/copilot-cmp",
		},
		opts = function()
			local compare = require("cmp.config.compare")

			local cmp_ui = require("core.utils").load_config().ui.cmp

			local nvchadOptions = require("plugins.configs.cmp")
			local customOptions = {
				sources = {
					{
						name = "path",
					},
					{
						name = "luasnip",
					},
					{
						name = "nvim_lsp_signature_help",
						keyword_length = 1,
					},
					{
						name = "nvim_lsp",
						keyword_length = 1,
					},
					{
						name = "git",
						keyword_length = 1,
					},
					{
						name = "emoji",
						keyword_length = 1,
					},
					-- {
					--   name = "copilot",
					-- },
					{
						name = "treesitter",
						keyword_length = 3,
					},
					{
						name = "buffer",
						keyword_length = 3,
					},
					{
						name = "nvim_lua",
					},
				},

				window = {
					completion = {
						scrollbar = true,
					},
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, item)
						local icons = require("nvchad.icons.lspkind")
						local icon = (cmp_ui.icons and icons[item.kind]) or ""

						icon = cmp_ui.lspkind_text and (" " .. icon .. " ") or icon
						item.kind = string.format("%s %s", icon, cmp_ui.lspkind_text and item.kind or "")
						item.menu = entry.source.name

						return item
					end,
				},
				mapping = {
					["<Esc>"] = require("cmp").mapping.close(),
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						-- require("copilot_cmp.comparators").prioritize,
						compare.offset,
						-- compare.scopes, --this is commented in nvim-cmp too
						compare.exact,
						compare.score,
						compare.recently_used,
						compare.locality,
						compare.kind,
						compare.sort_text,
						compare.length,
						compare.order,
					},
				},
				experimental = {
					ghost_text = true,
				},
			}

			return vim.tbl_deep_extend("force", nvchadOptions, customOptions)
		end,
		config = function(_, opts)
			-- require("copilot").setup {
			--   suggestion = { enabled = false },
			--   panel = {
			--     enabled = true,
			--     auto_refresh = true,
			--     keymap = {
			--       jump_prev = "[[",
			--       jump_next = "]]",
			--       accept = "<CR>",
			--       refresh = "gr",
			--       open = "<M-CR>",
			--     },
			--     layout = {
			--       position = "right", -- | top | left | right
			--       ratio = 0.4,
			--     },
			--   },
			--   filetypes = {
			--     ["."] = true,
			--     --["*"] = false, -- disable for all other filetypes and ignore default `filetypes`
			--     sh = function()
			--       if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
			--         -- disable for .env files
			--         return false
			--       end
			--       return true
			--     end,
			--   },
			--   copilot_node_command = "node", -- Node.js version must be > 16.x
			--   server_opts_overrides = {
			--     trace = "verbose",
			--     settings = {
			--       advanced = {
			--         listCount = 6, -- #completions for panel
			--         inlineSuggestCount = 5, -- #completions for getCompletions
			--       },
			--     },
			--   },
			-- }
			--
			-- require("copilot_cmp").setup()
			--
			require("cmp").setup(opts)
		end,
	},

	{
		"RRethy/vim-illuminate",
		event = "BufEnter",
		config = function()
			require("illuminate").configure({
				delay = 50,
			})
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signcolumn = false,
			numhl = true,
			current_line_blame = true,
		},
	},

	{
		"max397574/better-escape.nvim",
		event = "BufEnter",
	},

	{
		"fedepujol/move.nvim",
		event = "BufEnter",
	},

	{
		"kevinhwang91/rnvimr",
		cmd = { "RnvimrToggle" },
		-- commit after introduce an issue with refresh inside ranger when changing directory
		-- @see https://github.com/kevinhwang91/rnvimr/commit/cd0311d65cb3b8f8737b52f3294eb77d2fcec826
		commit = "40b4e0b",
		config = function()
			vim.g.rnvimr_edit_cmd = "drop"
			vim.g.rnvimr_enable_picker = true
			vim.g.rnvimr_enable_bw = true
			vim.g.rnvimr_hide_gitignore = false
		end,
	},

	{
		"ruifm/gitlinker.nvim",
		keys = { "<leader>b" },
		opts = {
			mappings = nil,
		},
	},

	{
		"petertriho/nvim-scrollbar",
		event = "BufEnter",
		config = function(_, opts)
			require("scrollbar").setup(opts)
		end,
	},

	{
		"kdheepak/tabline.nvim",
		lazy = false,
		dependencies = {
			{
				"nvim-lualine/lualine.nvim",
				dependencies = {
					{
						"arkav/lualine-lsp-progress",
					},
				},
				opts = {
					options = {
						theme = "ayu_dark",
						component_separators = { left = "|", right = "|" },
						section_separators = { left = " ", right = " " },
						globalstatus = true,
					},

					sections = {
						lualine_a = { "mode" },
						lualine_b = { "diff", "diagnostics" },
						lualine_c = {
							{
								"filename",
								path = 1,
								symbols = {
									modified = "+",
									readonly = "-",
									unnamed = "[No Name]",
								},
							},
						},
						lualine_x = {
							"lsp_progress",
							"filetype",
						},
						lualine_y = { "progress" },
						lualine_z = { "location" },
					},

					extensions = {
						"quickfix",
					},
				},
			},
		},
		opts = {
			options = {
				section_separators = { " ", " " },
				component_separators = { "|", "|" },
				max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
				modified_italic = true, -- set to true by default; this determines whether the filename turns italic if modified
			},
		},
		config = function(_, opts)
			require("tabline").setup(opts)

			vim.cmd([[
	       set guioptions-=e " use showtabline in gui vim
	       set sessionoptions+=tabpages,globals " store tabpages and globals in session
	     ]])
		end,
	},

	{
		"vladdoster/remember.nvim",
		event = "BufEnter",
		config = function()
			require("remember")
		end,
	},

	{
		"mg979/vim-visual-multi",
		event = "BufEnter",
	},

	{
		"nvim-pack/nvim-spectre",
		keys = { "<leader>g" },
	},

	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
	},

	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				lazy = false,
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				lazy = false,
			},
		},
		config = function()
			local telescope = require("telescope")
			telescope.load_extension("live_grep_args")
			telescope.load_extension("themes")
			telescope.load_extension("terms")

			local actions = require("telescope.actions")

			require("telescope").setup({
				pickers = {
					find_files = {
						follow = true,
					},
				},
				defaults = {
					initial_mode = "insert",
					sorting_strategy = "ascending",
					layout_strategy = "vertical",
					layout_config = {
						mirror = true,
						prompt_position = "top",
					},
					vimgrep_arguments = {
						"rg",
						"-L",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob",
						"!**/.git/*",
						"--glob",
						"!**/node_modules/*",
					},
					file_sorter = require("telescope.sorters").get_fuzzy_file,
					generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
					path_display = { "truncate" },
					winblend = 0,
					border = {},
					borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					color_devicons = true,
					set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
					buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
					mappings = {
						i = {
							["<C-o>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<C-a>"] = actions.select_all,
							["<C-z>"] = actions.drop_all,
							["<M-Down>"] = actions.cycle_history_next,
							["<M-Up>"] = actions.cycle_history_prev,
							["<C-q>"] = require("telescope-live-grep-args.actions").quote_prompt(),
							["<C-g>"] = require("telescope-live-grep-args.actions").quote_prompt({
								postfix = ' --iglob ""',
							}),
						},
						n = {
							["<C-o>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<C-a>"] = actions.select_all,
							["<C-z>"] = actions.drop_all,
							["<M-Down>"] = actions.cycle_history_next,
							["<M-Up>"] = actions.cycle_history_prev,
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})
		end,
	},

	{
		"ecthelionvi/NeoColumn.nvim",
		event = "BufEnter",
		opts = {
			always_on = true,
		},
		config = function(_, opts)
			require("NeoColumn").setup(opts)
		end,
	},

	{
		"kevinhwang91/nvim-hlslens",
		event = "BufEnter",
		config = function(_, opts)
			require("hlslens").setup(opts)
		end,
	},

	{
		"luukvbaal/statuscol.nvim",
		event = "BufReadPost",
		opts = function()
			local builtin = require("statuscol.builtin")
			return {
				setopt = true,
				relculright = true,
				segments = {
					-- { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
					{ sign = { name = { "Diagnostic" } }, click = "v:lua.ScSa" },
					{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
					-- { sign = { name = { ".*" } }, click = "v:lua.ScSa" },
				},
			}
		end,
	},
}

return plugins
