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
	update_freq = 60,
	updates = "on",
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

-- Cached event data from the last Swift script execution
local cached_event = nil

local function render_calendar_event()
	if not cached_event then
		calendar_event:set({ drawing = false })
		return
	end

	local now = os.time()
	local label_str = ""
	local label_color = item.primary.label.color
	local icon_color = item.primary.icon.color

	if cached_event.start_timestamp <= now then
		local time_remaining = cached_event.end_timestamp - now
		if time_remaining <= 0 then
			-- Event has ended, clear cache
			cached_event = nil
			calendar_event:set({ drawing = false })
			return
		end
		label_str = string.format("%s (ends in %s)", cached_event.title, format_duration(time_remaining))
	else
		local time_until = cached_event.start_timestamp - now
		local minutes_until = math.floor(time_until / 60)

		if minutes_until < 15 then
			icon_color = colors.icon.warning
			label_color = colors.label.warning
		end

		label_str = string.format("%s (in %s)", cached_event.title, format_duration(time_until))
	end

	calendar_event:set({
		drawing = true,
		icon = { color = icon_color },
		label = { string = label_str, color = label_color },
	})
end

local function fetch_calendar_event()
	sbar.exec("~/.config/sketchybar/helpers/calendar_event.swift", function(result)
		result = result:gsub("^%s*(.-)%s*$", "%1") -- trim whitespace

		if result == "NO_EVENT" or result == "" then
			cached_event = nil
			render_calendar_event()
			return
		end

		local title, start_date, end_date = result:match("([^|]+)|([^|]+)|([^|]+)")

		if not title then
			calendar_event:set({ drawing = true, label = "error no title!" })
			return
		end

		local start_timestamp = tonumber(start_date)
		local end_timestamp = tonumber(end_date)

		if not start_timestamp or not end_timestamp then
			calendar_event:set({ drawing = true, label = "error with date!" })
			return
		end

		cached_event = {
			title = title,
			start_timestamp = start_timestamp,
			end_timestamp = end_timestamp,
		}

		render_calendar_event()
	end)
end

calendar_event:subscribe({ "forced", "routine", "system_woke" }, function()
	render_calendar_event()

	fetch_calendar_event()
end)

-- Initial fetch
fetch_calendar_event()
