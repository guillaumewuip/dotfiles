local colors = require("colors")
local item = require("item")
local icons = require("icons")

local calendar_event = sbar.add("item", "calendar_event", {
	position = "right",
	drawing = false,
	icon = {
		string = icons.calendar_badge,
		color = item.primary.icon.color,
		padding_left = item.primary.icon.padding_left,
		padding_right = item.primary.icon.padding_right,
	},
	label = {
		color = item.primary.label.color,
		padding_left = item.primary.label.padding_left,
		padding_right = item.primary.label.padding_right,
	},
	background = {
		color = item.primary.background.color,
	},
	padding_left = item.primary.padding_left,
	padding_right = item.primary.padding_right,
	update_freq = 30,
	click_script = "open -a 'Calendar'",
})

local function format_duration(seconds)
	local minutes = math.floor(seconds / 60)
	local hours = math.floor(minutes / 60)

	if hours > 0 then
		return string.format("%dh%dm", hours, minutes % 60)
	else
		return string.format("%dm", minutes)
	end
end

local function update_calendar_event()
	sbar.exec("~/.config/sketchybar/helpers/calendar_event.sh", function(result)
		result = result:gsub("^%s*(.-)%s*$", "%1") -- trim whitespace

		-- Hide item when no event
		if result == "NO_EVENT" or result == "" then
			calendar_event:set({
				drawing = false,
			})
			return
		end

		-- Parse result: "title|start_date|end_date|status"
		local title, start_date, end_date, status = result:match("([^|]+)|([^|]+)|([^|]+)|([^|]+)")

		if not title then
			calendar_event:set({
				drawing = true,
				label = "error no title!",
			})
			return
		end

		local now = os.time()
		local start_timestamp = tonumber(start_date)
		local end_timestamp = tonumber(end_date)

		if not start_timestamp or not end_timestamp then
			calendar_event:set({
				drawing = true,
				label = "error with date!",
			})
			return
		end

		local label_str = ""
		local label_color = item.primary.label.color
		local icon_color = item.primary.icon.color

		if status == "current" then
			-- Event is happening now
			local time_remaining = end_timestamp - now
			label_str = string.format("%s (ends in %s)", title, format_duration(time_remaining))
		elseif status == "upcoming" then
			-- Event is upcoming
			local time_until = start_timestamp - now
			local minutes_until = math.floor(time_until / 60)

			-- Orange background if starting in less than 10 minutes
			if minutes_until < 15 then
				icon_color = colors.icon.warning
				label_color = colors.label.warning
			end

			label_str = string.format("%s (in %s)", title, format_duration(time_until))
		end

		calendar_event:set({
			drawing = true,
			icon = {
				color = icon_color,
			},
			label = {
				string = label_str,
				color = label_color,
			},
		})
	end)
end

calendar_event:subscribe({ "forced", "routine", "system_woke" }, function()
	update_calendar_event()
end)

-- Initial update
update_calendar_event()
