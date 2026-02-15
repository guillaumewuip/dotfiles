local item = require("item")
local colors = require("colors")
local settings = require("settings")

local secure_input = sbar.add("item", "secure_input", {
	position = "right",
	drawing = false,
	icon = {
		drawing = false,
	},
	label = {
		string = "􀎡",
		color = colors.icon.error,
		font = {
			style = settings.font.style_map["Regular"],
			size = 14.0,
		},
		padding_left = item.primary.label.padding_left,
		padding_right = item.primary.label.padding_right,
		align = "center",
		width = 40,
	},
	background = {
		color = item.primary.background.color,
		border_color = item.primary.border.color,
	},
	padding_left = item.primary.padding_left,
	padding_right = item.primary.padding_right,
	update_freq = 10,
})

secure_input:subscribe({ "forced", "routine", "system_woke" }, function()
	sbar.exec("ioreg -l -w 0 | grep SecureInput", function(secure_input_state)
		sbar.animate("tanh", 4, function()
			secure_input:set({ drawing = secure_input_state ~= nil and secure_input_state ~= "" })
		end)
	end)
end)

-- @see https://superuser.com/questions/1472593/mac-how-can-i-see-if-secure-input-is-enabled-better-touch-tool-being-blocked
-- @see https://espanso.org/docs/troubleshooting/secure-input/
