local item = require("item")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local spaces = {}

for i = 1, 10, 1 do
	local space = sbar.add("space", "space." .. i, {
		space = i,
		icon = {
			string = i,
			font = { family = settings.font.numbers },
			color = item.primary.icon.color,
			highlight_color = item.primary.icon.highlight_color,
			padding_left = item.primary.icon.padding_left,
			padding_right = item.primary.icon.padding_right,
		},
		label = {
			font = "sketchybar-app-font:Regular:16.0",
			color = item.primary.label.color,
			highlight_color = item.primary.label.highlight_color,
			padding_left = item.primary.label.padding_left,
			padding_right = item.primary.label.padding_right,
		},
		background = {
			color = item.primary.background.color,
			highlight_color = item.primary.background.highlight_color,
			border_width = item.primary.border.width,
			border_color = item.primary.border.color,
		},
		padding_left = item.primary.padding_left,
		padding_right = item.primary.padding_right,
	})

	spaces[i] = space

	space:subscribe("space_change", function(env)
		local selected = env.SELECTED == "true"

		space:set({
			icon = { highlight = selected },
			label = { highlight = selected },
			background = {
				color = selected and item.primary.background.highlight_color or item.primary.background.color,
				border_color = selected and item.primary.border.highlight_color or item.primary.border.color,
			},
		})
	end)
end

local space_window_observer = sbar.add("item", {
	drawing = false,
	updates = true,
})

space_window_observer:subscribe("space_windows_change", function(env)
	local icon_line = ""
	local no_app = true
	for app, count in pairs(env.INFO.apps) do
		no_app = false
		local lookup = app_icons[app]
		local icon = ((lookup == nil) and app_icons["Default"] or lookup)
		icon_line = icon_line .. icon
	end

	if no_app then
		icon_line = "—"
	end

	sbar.animate("tanh", 4, function()
		spaces[env.INFO.space]:set({ label = icon_line })
	end)
end)
