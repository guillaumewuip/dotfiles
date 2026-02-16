local item = require("item")
local settings = require("settings")
local app_icons = require("helpers.app_icons")
local colors = require("colors")

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

-- Check if any Ghostty window in the given space has a bell emoji in its title
local function check_ghostty_bell_in_space(space_number, callback)
	local cmd = string.format(
		"yabai -m query --windows --space %d | jq -c '.[] | select(.app == \"Ghostty\") | .title'",
		space_number
	)

	sbar.exec(cmd, function(result)
		local has_bell = false
		if result and result ~= "" then
			-- Check each line (each window title) for bell emoji prefix
			for title in result:gmatch("[^\r\n]+") do
				-- Remove quotes from jq output
				title = title:gsub('^"', ""):gsub('"$', "")
				-- Check if title starts with bell emoji
				if title:match("^🔔") then
					has_bell = true
					break
				end
			end
		end
		callback(has_bell)
	end)
end

-- Update space display with app icons and Ghostty bell check
local function update_space_display(space_number, apps)
	local icon_line = ""
	local no_app = true
	local has_ghostty = false

	for _, app in ipairs(apps) do
		no_app = false
		if app == "Ghostty" then
			has_ghostty = true
		end
		local lookup = app_icons[app]
		local icon = ((lookup == nil) and app_icons["Default"] or lookup)
		icon_line = icon_line .. icon
	end

	if no_app then
		icon_line = "—"
	end

	-- Check for Ghostty bell notification if Ghostty is present
	if has_ghostty then
		check_ghostty_bell_in_space(space_number, function(has_bell)
			sbar.animate("tanh", 4, function()
				if has_bell then
					spaces[space_number]:set({
						icon = {
							string = "•",
							color = colors.icon.error,
							highlight_color = colors.icon.error,
						},
						label = icon_line,
					})
				else
					spaces[space_number]:set({
						icon = {
							string = space_number,
							color = item.primary.icon.color,
							highlight_color = item.primary.icon.highlight_color,
						},
						label = icon_line,
					})
				end
			end)
		end)
	else
		sbar.animate("tanh", 4, function()
			spaces[space_number]:set({
				icon = { string = space_number, color = item.primary.icon.color },
				label = icon_line,
			})
		end)
	end
end

local space_window_observer = sbar.add("item", {
	drawing = false,
	updates = true,
})

space_window_observer:subscribe("space_windows_change", function(env)
	local apps = {}
	for app, _ in pairs(env.INFO.apps) do
		table.insert(apps, app)
	end

	update_space_display(env.INFO.space, apps)
end)

space_window_observer:subscribe("title_change", function(env)
	-- Query which space the window belongs to and get apps in that space
	local window_id = env.WINDOW_ID
	sbar.exec("yabai -m query --windows --window " .. window_id .. " | jq -r '.space'", function(space_result)
		local space_number = tonumber(space_result)
		if space_number then
			-- Query apps in that space
			sbar.exec(
				"yabai -m query --windows --space " .. space_number .. " | jq -r '[.[].app] | unique'",
				function(apps_result)
					local apps = {}
					if apps_result and apps_result ~= "" and apps_result ~= "[]" then
						-- Parse JSON array - extract app names from lines like '  "Arc",'
						for line in apps_result:gmatch("[^\r\n]+") do
							local app_name = line:match('"([^"]+)"')
							if app_name then
								table.insert(apps, app_name)
							end
						end
					end
					update_space_display(space_number, apps)
				end
			)
		end
	end)
end)
