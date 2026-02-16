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

local function remove_emoji(text)
	if not text then return text end
	-- Remove emoji and other unicode symbols
	-- Emoji ranges: U+1F300-U+1F9FF, U+2600-U+26FF, U+2700-U+27BF
	-- Also remove variation selectors and zero-width joiners
	local cleaned = text:gsub("[\u{1F300}-\u{1F9FF}]", "")
	cleaned = cleaned:gsub("[\u{2600}-\u{26FF}]", "")
	cleaned = cleaned:gsub("[\u{2700}-\u{27BF}]", "")
	cleaned = cleaned:gsub("[\u{FE00}-\u{FE0F}]", "") -- variation selectors
	cleaned = cleaned:gsub("[\u{200D}]", "") -- zero-width joiner
	-- Trim leading/trailing whitespace
	cleaned = cleaned:gsub("^%s*(.-)%s*$", "%1")
	return cleaned
end

local function set_front_app(app_name, title)
	local lookup = app_icons[app_name]
	local icon = ((lookup == nil) and app_icons["Default"] or lookup)
	front_app_icon:set({ label = icon })

	if app_name == "Ghostty" and title and title ~= "" then
		local cleaned_title = remove_emoji(title)
		front_app:set({ label = { string = cleaned_title } })
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

front_app:subscribe("window_focus", function(env)
	update_from_window_id(env.WINDOW_ID)
end)

front_app:subscribe("title_change", function(env)
	update_from_window_id(env.WINDOW_ID)
end)
