local item = require("item")
local app_icons = require("helpers.app_icons")

local front_app_icon = sbar.add("item", "front_app_icon", {
	display = "active",
	icon = {
		drawing = false,
	},
	label = {
		font = "sketchybar-app-font:Regular:16.0",
		color = item.secondary.icon.color,
		padding_left = item.secondary.icon.padding_left,
		padding_right = item.secondary.icon.padding_right,
	},
	padding_left = item.secondary.padding_left,
	updates = true,
})

local front_app = sbar.add("item", "front_app", {
	display = "active",
	icon = { drawing = false },
	label = {
		font = item.secondary.label.font,
		color = item.secondary.label.color,
		padding_left = item.secondary.label.padding_left,
		padding_right = item.secondary.label.padding_right,
	},
	padding_right = item.secondary.padding_right,
	updates = true,
})

sbar.add("bracket", { front_app_icon.name, front_app.name }, {
	bg = {
		color = item.secondary.background.color,
	},
})

front_app:subscribe("front_app_switched", function(env)
	local lookup = app_icons[env.INFO]
	local icon = ((lookup == nil) and app_icons["Default"] or lookup)

	front_app_icon:set({ label = icon })
	front_app:set({ label = { string = env.INFO } })
end)
