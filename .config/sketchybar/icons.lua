local settings = require("settings")

local icons = {
	sf_symbols = {
		plus = "􀅼",
		loading = "􀖇",
		apple = "􀣺",
		gear = "􀍟",
		cpu = "􀫥",
		clipboard = "􀉄",

		switch = {
			on = "􁏮",
			off = "􁏯",
		},
		volume = {
			_100 = "􀊩",
			_66 = "􀊧",
			_33 = "􀊥",
			_10 = "􀊡",
			_0 = "􀊣",
		},
		sound = {
			airpods = "􀪷",
			hifi = "􀝎",
		},
		mic = {
			airpods = "􀪷",
			on = "􀊱",
			muted = "􀊳",
			external = "􀑫",
		},
		battery = {
			_100 = "􀛨",
			_75 = "􀺸",
			_50 = "􀺶",
			_25 = "􀛩",
			_0 = "􀛪",
			charging = "􀢋",
		},
		network = {
			upload = "􀄨",
			download = "􀄩",
			connected = "􀙇",
			disconnected = "􀙈",
			router = "􁓤",
			ethernet = "􀤆",
			hotspot = "􀉤",
		},
		media = {
			back = "􀊊",
			forward = "􀊌",
			play_pause = "􀊈",
		},
	},
}

return icons.sf_symbols
