local colors = require("colors")
local item = require("item")
local icons = require("icons")

sbar.add("item", {
	icon = {
		font = { size = 16.0 },
		string = icons.apple,
		color = item.primary.icon.color,
		padding_left = item.primary.icon.padding_left,
		padding_right = item.primary.label.padding_right,
	},
	label = { drawing = false },
	background = {
		border_width = item.primary.border.width,
		color = colors.bar.background,
	},
	padding_left = 10,
	padding_right = item.primary.padding_right,
})
