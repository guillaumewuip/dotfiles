local settings = require("settings")
local colors = require("colors")
local merge = require("helpers.merge")

local primary = {
	icon = {
		color = colors.white,
		highlight_color = colors.white,
		padding_left = 8,
		padding_right = 4,
	},

	label = {
		color = colors.grey,
		highlight_color = colors.white,
		padding_left = 4,
		padding_right = 8,
	},

	background = {
		color = colors.bg2,
		highlight_color = colors.bg2,
	},

	border = {
		color = colors.black,
		width = 1,
		highlight_color = colors.grey,
	},

	padding_left = 3,
	padding_right = 3,
}

local secondary = {
	icon = {
		color = colors.grey,

		padding_right = 8,
		padding_left = 0,
	},

	label = {
		color = colors.grey,

		font = {
			style = settings.font.style_map["Heavy"],
			size = 12.0,
		},

		padding_right = 8,
		padding_left = 0,
	},

	background = {
		color = colors.transparent,
	},

	padding_left = 8,
	padding_right = 8,
}

local widget = merge.deep(primary, {
	label = {
		color = colors.white,
	},

	padding_left = 2,
	padding_right = 2,
})

return {
	primary = primary,
	secondary = secondary,
	widget = widget,
}
