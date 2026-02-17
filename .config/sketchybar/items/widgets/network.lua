local item = require("item")
local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Execute the event provider binary which provides the event "network_update"
-- for the current network interface, which is fired every 2.0 seconds.

local current_interface = nil

local function start_network_load()
	sbar.exec("route get default 2>/dev/null | awk '/interface: / {print $2}'", function(iface)
		iface = iface and iface:match("^%s*(.-)%s*$") -- trim whitespace
		if not iface or iface == "" then
			return
		end

		-- Only restart if interface changed
		if iface == current_interface then
			return
		end

		current_interface = iface

		sbar.exec(
			string.format(
				"pkill -f 'network_load.*network_update' >/dev/null 2>&1; "
					.. "$CONFIG_DIR/helpers/event_providers/network_load/bin/network_load %s network_update 2.0 &",
				iface
			)
		)
	end)
end

-- run immediately at startup
start_network_load()

-- re-run when system wakes or network changes
sbar.add("event", "system_woke"):subscribe("system_woke", start_network_load)
sbar.add("event", "network_change"):subscribe("network_change", start_network_load)

-- Periodically check if interface changed (every 10 seconds)
sbar.exec("sleep 30 && while true; do sketchybar --trigger interface_check; sleep 30; done &")
sbar.add("event", "interface_check"):subscribe("interface_check", start_network_load)

sbar.add("item", "widgets.network.left", {
	position = "right",
	width = item.widget.padding_left,
})

local network_up = sbar.add("item", "widgets.network1", {
	position = "right",
	padding_left = -5,
	width = 0,
	icon = {
		padding_right = 0,
		font = {
			style = settings.font.style_map["Bold"],
			size = 9.0,
		},
		string = icons.network.upload,
	},
	label = {
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Bold"],
			size = 9.0,
		},
		color = colors.graph.red,
		string = "??? Bps",
	},
	y_offset = 6,
	padding_right = item.widget.label.padding_right + item.widget.padding_right,
})

local network_down = sbar.add("item", "widgets.network2", {
	position = "right",
	padding_left = -5,
	icon = {
		padding_right = 0,
		font = {
			style = settings.font.style_map["Bold"],
			size = 9.0,
		},
		string = icons.network.download,
	},
	label = {
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Bold"],
			size = 9.0,
		},
		color = colors.graph.blue,
		string = "??? Bps",
	},
	y_offset = -4,
	padding_right = item.widget.label.padding_right + item.widget.padding_right,
})

local up_history = {}
local down_history = {}
local max_up_history = 1
local max_down_history = 1 -- number of values to average over for download

local net_graph_up = sbar.add("graph", "widgets.net_graph_up", 42, {
	position = "right",
	graph = {
		color = colors.graph.red,
	},
	background = {
		height = 10,
		color = { alpha = 0 },
		border_color = { alpha = 0 },
		drawing = true,
	},
	updates = true,
	y_offset = 5,
	padding_right = -2,

	update_freq = 30,
})

local net_graph_down = sbar.add("graph", "widgets.net_graph_down", 42, {
	position = "right",
	padding_right = -49,
	graph = {
		color = colors.graph.blue,
	},
	background = {
		height = 10,
		color = { alpha = 0 },
		border_color = { alpha = 0 },
		drawing = true,
	},
	updates = true,
	y_offset = -5,
	update_freq = 30,
})

net_graph_down:subscribe("network_update", function(env)
	local up = tonumber(env.upload:match("%d+")) or 0

	-- add new value to history
	table.insert(up_history, up)
	if #up_history > max_up_history then
		table.remove(up_history, 1)
	end

	-- calculate average
	local sum = 0
	for _, v in ipairs(up_history) do
		sum = sum + v
	end
	local avg_up = sum / #up_history

	-- normalize and push (scale: divide by 100KB)
	net_graph_up:push({ math.min(avg_up / 100, 1) })

	-------------

	local down = tonumber(env.download:match("%d+")) or 0

	-- add new value to history
	table.insert(down_history, down)
	if #down_history > max_down_history then
		table.remove(down_history, 1)
	end

	-- calculate average
	local sum = 0
	for _, v in ipairs(down_history) do
		sum = sum + v
	end
	local avg_down = sum / #down_history

	-- normalize and push (scale: divide by 100KB)
	net_graph_down:push({ math.min(avg_down / 100, 1) })
end)

local status = sbar.add("item", "widgets.network.status", {
	position = "right",
	icon = {
		string = icons.network.disconnected,
		font = {
			size = 14.0,
		},
		color = item.widget.icon.color,
		padding_left = item.widget.icon.padding_left,
		padding_right = item.widget.icon.padding_right,
	},
	label = { drawing = false },
})

-- Background around the item
sbar.add("bracket", "widgets.network.bracket", {
	network_up.name,
	network_down.name,
	net_graph_up.name,
	net_graph_down.name,
	status.name,
}, {
	background = { color = item.widget.background.color },
})

sbar.add("item", "widgets.network.right", {
	position = "right",
	width = item.widget.padding_right,
})

network_up:subscribe("network_update", function(env)
	local up_color = (env.upload == "000 Bps") and colors.graph.grey or colors.graph.red
	local down_color = (env.download == "000 Bps") and colors.graph.grey or colors.graph.blue

	network_up:set({
		icon = { color = up_color },
		label = {
			string = env.upload,
			color = up_color,
		},
	})

	network_down:set({
		icon = { color = down_color },
		label = {
			string = env.download,
			color = down_color,
		},
	})
end)

local function updateNetworkStatus()
	-- 1. First check if ANY interface has internet
	sbar.exec("ping -c1 -t1 8.8.8.8 >/dev/null 2>&1 && echo 1 || echo 0", function(hasInternet)
		-- 3. Check active interface (only if needed)
		sbar.exec("route get default 2>/dev/null | awk '/interface: / {print $2}'", function(activeInterface)
			-- Visual feedback logic
			if tonumber(hasInternet) == 0 then
				-- DISCONNECTED
				status:set({
					icon = { string = icons.network.disconnected },
				})
			elseif activeInterface and tonumber(activeInterface:match("^en(%d+)")) >= 1 then
				-- ETHERNET
				status:set({
					icon = { string = icons.network.ethernet },
				})
			else
				-- WIFI/HOTSPOT CHECK using system_profiler
				sbar.exec(
					"networksetup -listpreferredwirelessnetworks en0 | sed -n '2p' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'",
					function(ssid_result)
						local ssid_str = ssid_result or ""
						if ssid_str:match("iPhone") then
							-- Detected hotspot
							status:set({
								icon = { string = icons.network.hotspot },
							})
						else
							-- Normal Wi-Fi
							status:set({
								icon = { string = icons.network.connected },
							})
						end
					end
				)
			end
		end)
	end)
end

-- Initial update with 1s delay to allow network stabilization
sbar.delay(1, updateNetworkStatus)

-- Event subscriptions
status:subscribe({ "wifi_change", "system_woke", "network_update", "vpn_state_change" }, function()
	sbar.delay(0.5, updateNetworkStatus)
end)
