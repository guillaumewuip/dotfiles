local settings = require("settings")
local colors = require("colors")
local merge = require("helpers.merge")

local primary = {
	icon = {
		color = colors.icon.color,
		highlight_color = colors.icon.highlight_color,
		padding_left = 8,
		padding_right = 4,
	},

	label = {
		color = colors.label.color,
		highlight_color = colors.label.highlight_color,
		padding_left = 4,
		padding_right = 8,
	},

	background = {
		color = colors.background.color,
		highlight_color = colors.background.highlight_color,
	},

	border = {
		color = colors.border.color,
		highlight_color = colors.border.highlight_color,
		width = 2,
	},

	padding_left = 3,
	padding_right = 3,
}

local secondary = {
	icon = {
		color = colors.icon.dimmed,

		padding_right = 8,
		padding_left = 0,
	},

	label = {
		color = colors.label.dimmed,

		font = {
			style = settings.font.style_map["Heavy"],
			size = 12.0,
		},

		padding_right = 8,
		padding_left = 0,
	},

	background = {
		color = colors.background.dimmed,
	},

	padding_left = 8,
	padding_right = 8,
}

local widget = merge.deep(primary, {
	label = {
		color = colors.icon.color,
	},

	padding_left = 2,
	padding_right = 2,
})

return {
	primary = primary,
	secondary = secondary,
	widget = widget,
}
