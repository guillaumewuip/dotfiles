local icons = require("icons")
local settings = require("settings")
local item = require("item")

local state = {
	output_source = "",
	input_source = "",
	output_volume = nil,
	input_volume = nil,
}

local function trim(value)
	return (value or ""):gsub("^%s*(.-)%s*$", "%1")
end

local function get_volume_icon(volume)
	if not volume or volume <= 0 then
		return icons.volume._0
	elseif volume > 60 then
		return icons.volume._100
	elseif volume > 30 then
		return icons.volume._66
	elseif volume > 10 then
		return icons.volume._33
	end

	return icons.volume._10
end

local function get_output_source_icon(source, volume)
	local normalized_source = source:lower()

	if normalized_source:match("airpods") then
		return icons.sound.airpods
	elseif normalized_source:match("denon") then
		return icons.sound.hifi
	elseif normalized_source:match("lsx") then
		return icons.sound.hifi
	end

	return get_volume_icon(volume)
end

local function get_input_source_icon(source, volume)
	local normalized_source = source:lower()

	if volume == 0 then
		return icons.mic.muted
	elseif normalized_source:match("macbook") or normalized_source:match("built%-in") then
		return icons.mic.on
	elseif normalized_source:match("airpods") then
		return icons.mic.airpods
	elseif normalized_source ~= "" then
		return icons.mic.external
	end

	return icons.mic.on
end

local function format_percent(volume)
	if volume == nil then
		return "--%"
	end
	return string.format("%02d%%", volume)
end

local audio = sbar.add("item", "widgets.audio", {
	position = "right",
	icon = { drawing = false },
	label = {
		string = "􀊣 --% · 􀊱 --%",
		font = { family = settings.font.numbers },
		color = item.widget.label.color,
		padding_left = item.widget.icon.padding_left,
		padding_right = item.widget.label.padding_right,
	},
	background = {
		color = item.widget.background.color,
	},
	padding_left = item.widget.padding_left,
	padding_right = item.widget.padding_right,
	update_freq = 10,
})

local function render_output()
	local output_icon = get_output_source_icon(state.output_source, state.output_volume)

	if state.output_volume == 0 then
		return output_icon
	end

	return string.format("%s%s", output_icon, format_percent(state.output_volume))
end

local function render_input()
	local input_icon = get_input_source_icon(state.input_source, state.input_volume)

	if state.input_source == "" then
		return ""
	end

	return string.format(" %s%s", input_icon, format_percent(state.input_volume))
end

local function render()
	audio:set({
		label = {
			string = string.format("%s%s", render_output(), render_input()),
		},
	})
end

local switch_audio_source_bin = "/opt/homebrew/bin/SwitchAudioSource"

local function get_switch_audio_source_command(mode)
	local source_mode = mode == "input" and "-t input " or ""
	return switch_audio_source_bin .. " " .. source_mode .. "-c"
end

local function refresh_output_source()
	sbar.exec(get_switch_audio_source_command("output"), function(result)
		state.output_source = trim(result)
		render()
	end)
end

local function refresh_input_source()
	sbar.exec(get_switch_audio_source_command("input"), function(result)
		state.input_source = trim(result)
		render()
	end)
end

local function refresh_output_volume()
	sbar.exec("osascript -e 'output volume of (get volume settings)'", function(result)
		state.output_volume = result
		render()
	end)
end

local function refresh_input_volume()
	sbar.exec("osascript -e 'input volume of (get volume settings)'", function(result)
		state.input_volume = result
		render()
	end)
end

local function refresh()
	refresh_output_source()
	refresh_output_volume()
	refresh_input_source()
	refresh_input_volume()
end

audio:subscribe("volume_change", function(env)
	state.output_volume = tonumber(env.INFO)
	render()
end)

audio:subscribe({ "routine", "forced", "system_woke" }, function()
	refresh()
end)

refresh()
