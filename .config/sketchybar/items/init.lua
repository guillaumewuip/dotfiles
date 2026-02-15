local item = require("item")

-- left

require("items.apple")
require("items.spaces")
require("items.front_app")

-- right (right to left)

require("items.calendar")
require("items.calendar_event")

sbar.add("item", "separator_1", {
	position = "right",
	padding_left = item.widget.padding_left * 2,
})

require("items.widgets.battery")
require("items.widgets.audio")
require("items.widgets.network")
require("items.widgets.cpu")
require("items.secure_input")
