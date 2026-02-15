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

local function set_front_app(app_name, title)
	local lookup = app_icons[app_name]
	local icon = ((lookup == nil) and app_icons["Default"] or lookup)
	front_app_icon:set({ label = icon })

	if app_name == "Ghostty" and title and title ~= "" then
		front_app:set({ label = { string = title } })
	else
		front_app:set({ label = { string = app_name } })
	end
end

local function update_from_window_id(window_id)
	sbar.exec("yabai -m query --windows --window " .. window_id .. " | jq -r '[.app, .title] | @tsv'", function(result)
		result = result:gsub("^%s*(.-)%s*$", "%1")
		local app_name, title = result:match("([^\t]+)\t?(.*)")
		if app_name then
			set_front_app(app_name, title)
		end
	end)
end

front_app:subscribe("front_app_switched", function(env)
	-- front_app_switched doesn't give window id, query current window
	sbar.exec("yabai -m query --windows --window | jq -r '[.app, .title] | @tsv'", function(result)
		result = result:gsub("^%s*(.-)%s*$", "%1")
		local app_name, title = result:match("([^\t]+)\t?(.*)")
		if app_name then
			set_front_app(app_name, title)
		end
	end)
end)

-- Register custom events triggered by yabai - see .yabairc
sbar.add("event", "window_focus")
sbar.add("event", "title_change")

front_app:subscribe("window_focus", function(env)
	update_from_window_id(env.WINDOW_ID)
end)

front_app:subscribe("title_change", function(env)
	update_from_window_id(env.WINDOW_ID)
end)
