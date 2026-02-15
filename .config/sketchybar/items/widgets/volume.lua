local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local item = require("item")

sbar.add("item", "widgets.volume.right", {
	position = "right",
	width = item.widget.padding_right,
})

local volume_percent = sbar.add("item", "widgets.volume1", {
	position = "right",
	icon = { drawing = false },
	label = {
		string = "??%",
		font = { family = settings.font.numbers },
		color = item.widget.label.color,
	},
	padding_left = item.widget.label.padding_left,
	padding_right = item.widget.label.padding_right,
})

local volume_icon = sbar.add("item", "widgets.volume2", {
	position = "right",
	icon = {
		drawing = true,
		string = icons.volume._100,
		width = 0,
		align = "left",
		color = colors.icon.dimmed,
		font = {
			style = settings.font.style_map["Regular"],
			size = 14.0,
		},
	},
	label = {
		align = "left",
		font = {
			style = settings.font.style_map["Regular"],
			size = 14.0,
		},
		color = item.widget.icon.color,
	},
	padding_left = item.widget.icon.padding_left,
})

sbar.add("bracket", "widgets.volume.bracket", {
	volume_icon.name,
	volume_percent.name,
}, {
	background = {
		color = item.widget.background.color,
	},
})

sbar.add("item", "widgets.volume.left", {
	position = "right",
	width = item.widget.padding_left,
})

volume_percent:subscribe("volume_change", function(env)
	local volume = tonumber(env.INFO)
	local icon = icons.volume._0
	if volume > 60 then
		icon = icons.volume._100
	elseif volume > 30 then
		icon = icons.volume._66
	elseif volume > 10 then
		icon = icons.volume._33
	elseif volume > 0 then
		icon = icons.volume._10
	end

	local lead = ""
	if volume < 10 then
		lead = "0"
	end

	volume_icon:set({ label = icon })
	volume_percent:set({ label = lead .. volume .. "%" })
end)
