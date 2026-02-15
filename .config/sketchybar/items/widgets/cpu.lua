local icons = require("icons")
local colors = require("colors")
local settings = require("settings")
local item = require("item")

-- Execute the event provider binary which provides the event "cpu_update" for
-- the cpu load data, which is fired every 2.0 seconds.
sbar.exec("killall cpu_load >/dev/null; $CONFIG_DIR/helpers/event_providers/cpu_load/bin/cpu_load cpu_update 2.0")

sbar.add("item", "widgets.resource.left", {
	position = "right",
	width = item.widget.padding_left,
})

local ram = sbar.add("graph", "ram", 42, {
	position = "right",
	graph = {
		color = colors.blue,
	},
	background = {
		drawing = true,
		height = 22,
		color = { alpha = 0 },
		border_color = { alpha = 0 },
	},
	icon = { drawing = false },
	label = {
		string = "ram ??%",
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Bold"],
			size = 9.0,
		},
		align = "right",
		padding_right = 0,
		width = 0,
		y_offset = 4,
	},
	padding_right = item.widget.label.padding_right + item.widget.padding_right,
	update_freq = 30,
	updates = true,
})

local cpu = sbar.add("graph", "widgets.cpu", 42, {
	position = "right",
	graph = {
		color = colors.blue,
	},
	background = {
		drawing = true,
		height = 22,
		color = { alpha = 0 },
		border_color = { alpha = 0 },
	},
	icon = {
		string = icons.cpu,
		color = item.widget.icon.color,
		padding_left = item.widget.icon.padding_left,
		padding_right = item.widget.icon.padding_right,
	},
	label = {
		string = "cpu ??%",
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Bold"],
			size = 9.0,
		},
		align = "right",
		padding_right = 0,
		width = 0,
		y_offset = 4,
	},
	padding_right = item.widget.label.padding_right,
})

sbar.add("bracket", "widgets.resources.bracket", { cpu.name, ram.name }, {
	background = {
		color = item.widget.background.color,
	},
})

sbar.add("item", "widgets.resources.right", {
	position = "right",
	width = item.widget.padding_right,
})

cpu:subscribe("cpu_update", function(env)
	-- Also available: env.user_load, env.sys_load
	local load = tonumber(env.total_load)
	cpu:push({ load / 100. })

	local color = colors.blue
	if load > 30 then
		if load < 60 then
			color = colors.yellow
		elseif load < 80 then
			color = colors.orange
		else
			color = colors.red
		end
	end

	cpu:set({
		graph = { color = color },
		label = "cpu " .. env.total_load .. "%",
	})
end)

ram:subscribe({ "routine", "forced", "system_woke" }, function(env)
	sbar.exec("memory_pressure", function(output)
		local percentage = output:match("System%-wide memory free percentage: (%d+)")
		local load = 100 - tonumber(percentage)
		ram:push({ load / 100. })

		local color = colors.green
		if load >= 90 then
			color = colors.red
		elseif load >= 75 then
			color = colors.orange
		elseif load >= 50 then
			color = colors.yellow
		end

		ram:set({
			graph = { color = color },
			label = { color = color, string = "RAM " .. load .. "%" },
		})
	end)
end)

cpu:subscribe("mouse.clicked", function(env)
	sbar.exec("open -a 'Activity Monitor'")
end)
