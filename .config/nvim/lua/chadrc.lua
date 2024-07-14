---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "onedark",
	theme_toggle = {},
	transparency = true,
	lsp_semantic_tokens = true,

	hl_override = {
		-- Comment = {
		--   italic = true,
		-- },
		IlluminatedWordText = {},
		IlluminatedWordRead = {},
		IlluminatedWordWrite = {},
		Folded = {
			bg = "#353b45",
		},
	},

	hl_add = {},

	statusline = {
		enabled = false,
	},

	tabufline = {
		enabled = false,
	},

	cmp = {
		icons = true,
		lspkind_text = true,
		style = "default", -- default/flat_light/flat_dark/atom/atom_colored
		border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
		selected_item_bg = "simple", -- colored / simple
	},

	telescope = { style = "borderless" }, -- borderless / bordered
}

return M
