local settings = require("settings")
local item = require("item")

local cal = sbar.add("item", {
	position = "right",
	icon = {
		color = item.primary.icon.color,
		font = {
			style = settings.font.style_map["Heavy"],
			size = 12.0,
		},
		padding_left = item.primary.icon.padding_left,
	},
	label = {
		color = item.primary.label.color,
		font = { family = settings.font.numbers },
		padding_left = item.primary.label.padding_left,
		padding_right = item.primary.label.padding_right,
	},
	background = {
		color = item.primary.background.color,
		border_color = item.primary.border.color,
	},
	padding_left = item.primary.padding_left,
	padding_right = 10,

	update_freq = 30,
	click_script = "open -a 'BusyCal'",
})

cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
	cal:set({
		icon = os.date("%a. %b %d"),
		label = os.date("%H:%M"),
	})
end)
